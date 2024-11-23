<%@ page language="java" import="java.sql.*,java.lang.*,java.util.*,java.text.*" contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="conexao.jsp"%>
<%request.setCharacterEncoding("UTF-8");%>
   
<%
    String id_predio = request.getParameter("id_predio");
    String andar = request.getParameter("andar");
    String dt_limite = request.getParameter("dt_limite_alteracao");
    //out.print(dt_limite);
    String quem = request.getParameter("quem");
    //out.print(quem);
    String eh_rpa = request.getParameter("eh_rpa");
    //out.print(eh_rpa);
    // Verifica se existe ou não um mapa válido para o prédio e pavimento. Retorna 0 (não tem mapa feito) ou 1 (tem mapa já feito)
    int existe_mapa_valido = 0;
    String qry_localiza_mapa = "";
    qry_localiza_mapa +="SELECT COUNT(a.id_predio) AS existe_mapa_valido ";
    qry_localiza_mapa +="FROM dipes_disst_seguranca.mapa_risco AS a ";
    qry_localiza_mapa +="WHERE a.dt_limite >= DATE(NOW()) AND a.id_predio = "+id_predio+" AND a.andar = "+andar+" ";
    ResultSet rs_localiza_mapa = st.executeQuery(qry_localiza_mapa);
        while (rs_localiza_mapa.next()){
            existe_mapa_valido = rs_localiza_mapa.getInt("existe_mapa_valido");   
        }
    rs_localiza_mapa.close();

    // Aqui é o caso para um mapa novo não existente. Ele cria o mapa na tabela mapa_risco, ms ainda não colocou as avaliações
    /* Primeira etapa. Se id_predio diferente de null, insere os dados do mapa de riscos na tabela mapa_risco*/                                
    if(id_predio != null && existe_mapa_valido == 0){
        String qry_insert_mapa = "";
        qry_insert_mapa +="INSERT IGNORE INTO dipes_disst_seguranca.mapa_risco ";
        qry_insert_mapa +="(id_predio, andar, dt_limite, dt_avaliacao) "; 
        qry_insert_mapa +="VALUES ";
        qry_insert_mapa +="(?, ?, ?, NOW()) ";

        //out.print("#######");
        //Calendar dt_teste = Calendar.getInstance();
        //out.print(dt_teste);
        PreparedStatement statement;
        statement = connect.prepareStatement(qry_insert_mapa);
        statement.setString(1, id_predio);
        statement.setString(2, andar);
        statement.setString(3, dt_limite);
        statement.executeUpdate();
        statement.close();        
    }

    // Faz uma busca pelo mapa mais novo do local, seja novo ou não.
    String id_mapa = "";
    String qry_localiza_id_mapa = "";
    qry_localiza_id_mapa +="SELECT MAX(a.id_mapa) AS id_mapa ";
    qry_localiza_id_mapa +="FROM dipes_disst_seguranca.mapa_risco AS a ";
    qry_localiza_id_mapa +="WHERE a.dt_limite >= DATE(NOW()) AND a.id_predio = "+id_predio+" AND a.andar = "+andar+" ";
    ResultSet rs_localiza_id_mapa = st.executeQuery(qry_localiza_id_mapa);
        while (rs_localiza_id_mapa.next()){
            id_mapa  = rs_localiza_id_mapa.getString("id_mapa");
        }
    rs_localiza_id_mapa.close();   


    /* Busca os Grupos de riscos ativos de forma longa (mesmo tamanho dos 
    códigos de riscos ativos e mesmo tamanho das avaliações) para fazer a comparação no momento de inserir os dados no BD
    
    Busca os riscos ativos para fazer a comparação no momento de inserir os dados no BD
    */
    ArrayList<Integer> listaIdGrupoRiscoLonga = new ArrayList<>();
    ArrayList<Integer> listIdCodigoRisco = new ArrayList<>();

    String qry_grupo_riscos_ativos_longa = "";
    qry_grupo_riscos_ativos_longa += "SELECT a.cd_grupo, a.codigo ";
    qry_grupo_riscos_ativos_longa += "FROM dipes_disst_seguranca.gro_tipo_perigo AS a ";
    qry_grupo_riscos_ativos_longa += "WHERE a.ativo = 1 ";
    qry_grupo_riscos_ativos_longa += "ORDER BY a.cd_grupo ";
    ResultSet rs_grupo_riscos_ativos_longa = st.executeQuery(qry_grupo_riscos_ativos_longa);
    while (rs_grupo_riscos_ativos_longa.next()){
        listaIdGrupoRiscoLonga.add(rs_grupo_riscos_ativos_longa.getInt("a.cd_grupo"));
        listIdCodigoRisco.add(rs_grupo_riscos_ativos_longa.getInt("a.codigo"));
    }
    rs_grupo_riscos_ativos_longa.close();

    /*
    Recuperação das respostas do questionário do mapa.
    Aqui se recebem os pares grupos de risco e riscos enviados da página anterior
    de levantamento dos riscos (mapa_levantamento.jsp)
    Acima é feita a busca dos riscos ativos que foram respondidos colocados nos arrays:
    listaIdGrupoRiscoLonga
    listIdCodigoRisco
    É feita uma busca por esses mesmos riscos ativos para uso na gravação logo abaixo.
    Como são recebidos da página anterior os pares gXrY 
    Onde X é o Grupo de risco (1, 2, 3, 4 ou 5) (ver tabela BD gro_tipo_perigo_grupo)
    E Y é o código de risco atualmente ativo (ver BD tabela gro_tipo_perigo)
    */

    ArrayList<Integer> avaliacoes = new ArrayList<>();
    for(int i=0;i<listaIdGrupoRiscoLonga.size();i++){
        String id_html = "g" + listaIdGrupoRiscoLonga.get(i) + "r" + listIdCodigoRisco.get(i);
        if(request.getParameter(id_html)!=null){
            if(Integer.parseInt(request.getParameter(id_html))!=0){
                avaliacoes.add(Integer.parseInt(request.getParameter(id_html)));
            } else{
                avaliacoes.add(null);
            }
        }
    }
    
    /*
        A gravação funciona da sequinte forma:
        Tem 3 listas (Arrays) de mesmo tamanho
        listaIdGrupoRiscoLonga
        listIdCodigoRisco
        avaliacoes

        Essas listas são sempre do mesmo tamanho e cada item corresponde a um grupo de risco / codigo de risco / avaliação realizada

        Dessa forma, abaixo itera-se sobre esses arrays (foi usado avaliações, mas poderia ser um dos outros), pegando sempre cada um dos grupo(i)/código(i)/avaliação(i) e grava no respectivo mapa de risco
    */
        for(int i = 0; i < avaliacoes.size(); i++){
            if(avaliacoes.get(i)==null){
                String qry_apaga_avaliacao_nao_existe = "";
                qry_apaga_avaliacao_nao_existe += "DELETE FROM dipes_disst_seguranca.mapa_risco_avaliacao ";
                qry_apaga_avaliacao_nao_existe += "WHERE id_mapa = "+id_mapa+" AND grupo = "+listaIdGrupoRiscoLonga.get(i)+" AND risco = "+listIdCodigoRisco.get(i)+" AND id_respondente = "+quem+" ";
                PreparedStatement statement;
                statement = connect.prepareStatement(qry_apaga_avaliacao_nao_existe);
                statement.executeUpdate();
                statement.close();
            }else{
                String qry_insert_avaliacao = "";
                qry_insert_avaliacao +="INSERT INTO dipes_disst_seguranca.mapa_risco_avaliacao ";
                qry_insert_avaliacao +="(id_mapa, id_predio, andar, grupo, risco, quem_gravou, rpa_cipa, intensidade, dt_gravacao, id_respondente) "; 
                qry_insert_avaliacao +="VALUES ";
                qry_insert_avaliacao +="(?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?) ";
                qry_insert_avaliacao +="ON DUPLICATE KEY UPDATE "; 
                qry_insert_avaliacao +="intensidade = ?, dt_alteracao = NOW() ";
                PreparedStatement statement;
                statement = connect.prepareStatement(qry_insert_avaliacao);
                statement.setString(1, id_mapa);
                statement.setString(2, id_predio);
                statement.setString(3, andar);
                statement.setInt(4, listaIdGrupoRiscoLonga.get(i));
                statement.setInt(5, listIdCodigoRisco.get(i));
                statement.setString(6, quem);
                statement.setString(7, eh_rpa);
                statement.setInt(8, avaliacoes.get(i));
                statement.setString(9, quem);
                statement.setInt(10, avaliacoes.get(i));
                statement.executeUpdate();
                statement.close();
                }     
        }
%>      

    <form id="form" name="form" method="post" action="mapa_grafico.jsp">
        <input type="hidden" name="a" id="a" value="<%=andar%>">
        <input type="hidden" name="an" id="an" value="Verificar retorno da gravação">
    </form>
    <script type="text/javascript">document.form.submit();</script>

<%@include file="Fecha_ConeXao.jsp"%>




