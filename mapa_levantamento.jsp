<%@ page language="java" import="java.sql.*,java.lang.*,java.util.*,java.text.*" contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="conexao.jsp"%>
<%request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html>

<html lang="pt-BR">
    <head>
        <meta http-equiv="Content-Language" content="pt-br" charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>MAPA DE RISCO</title>

        <link rel="stylesheet" href="css_default/css/bootstrap.min.css">
        <link rel="stylesheet" href="css_default/css/bootstrap-datepicker.min.css">
        <link rel="stylesheet" href="css_default/css/style.css">
        <link rel="stylesheet" href="css_default/css/all.min.css">

        <script type="text/javascript" src="css_default/jquery-3.3.1.slim.min.js"></script>
        <script type="text/javascript" src="css_default/popper.min.js"></script>
        <script type="text/javascript" src="css_default/bootstrap.min.js"></script>
        <script type="text/javascript" src="css_default/bootstrap-datepicker.min.js"></script>
        <script type="text/javascript" src="css_default/bootstrap-datepicker.pt-BR.min.js"></script>
        <style>
            input[type="radio"] {
                -webkit-transform: scale(1.4);
            }
        </style>
    </head>
    <body>
        <!-- nav-bar -->	
        <div  name="topo" id="navBarRoll">
            <nav class="navbar navbar-expand-lg navbar-light colorBar">
                <a class="navbar-brand" id="texto_titulo" href="index.jsp">
                    <img src="css/images/logo.png" class="img-responsive" width="40" height="40" alt="">
                    <b class="text-dark">Segurança e Saúde no Trabalho</b>
                </a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                        </li>
                        <li class="nav-item">
                        </li>
                    </ul>
                </div>
            </nav>  

            <!-- ================ -->
            <!-- == Breadcrumb == -->
            <!-- ================ -->
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-dark">
                    <li class="breadcrumb-item"><a href="../mapa_levantamento.jsp">Segurança no Trabalho</a></li>
                    <li class="breadcrumb-item text-light active" aria-current="page"><b>Mapa de risco - Levantamento</b></li>
                </ol>
            </nav>
        </div>


        <%

            //String quem = x_Chave.substring(1,8);
            String quem = "1234567";
            String x_UorGrupo = "18914";
            Calendar hoje = Calendar.getInstance();
            int mesAtual = hoje.get(Calendar.MONTH);
            int anoAtual = hoje.get(Calendar.YEAR);
            int diaAtual = hoje.get(Calendar.DAY_OF_MONTH);

            Calendar dt_limite = Calendar.getInstance();
            dt_limite.add(Calendar.YEAR, 1);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
            String dt_limite_alteracao = sdf.format(dt_limite.getTime());
            //String naoExisteHabilitado = "required";
            //String naoExisteHabilitado = "";
            //if( existe == 0 ){ naoExisteHabilitado = "checked"; }

            //Dados gerais do prédio
            String p_id = "";
            String p_nome = "";
            String p_endereco = "";
            String p_bairro = "";
            String p_mun = "";
            String p_uf = "";
            String p_idPredioSetor = "";
            String p_num_pavimento = "";
            String p_tipo_pavimento = "";
            String p_prefixo = "";
            String qry_predio = "";
            qry_predio += "SELECT b.predio_id, c.predio_nome, c.predio_logradouro, c.predio_bairro, c.predio_municipio, c.predio_uf, b.idpredio_setor, b.pavimento, b.tipo_pavimento, d.prefixo ";
            qry_predio += "FROM dipes_disst_seguranca.predios_setores_uor AS a ";
            qry_predio += "INNER JOIN dipes_disst_seguranca.predios_setores AS b ON a.id_setor = b.idpredio_setor ";
            qry_predio += "INNER JOIN dipes_disst_seguranca.predios_base AS c ON b.predio_id = c.idpredio ";
            qry_predio += "INNER JOIN tb_uor AS d ON a.uor = d.uor_dependencia ";
            qry_predio += "WHERE a.uor = "+x_UorGrupo+" ";
            ResultSet rs_predio = st.executeQuery(qry_predio);
                while (rs_predio.next()){
                    p_id = rs_predio.getString("b.predio_id");
                    p_nome = rs_predio.getString("c.predio_nome");
                    p_endereco = rs_predio.getString("c.predio_logradouro");
                    p_bairro = rs_predio.getString("c.predio_bairro");
                    p_mun = rs_predio.getString("c.predio_municipio");
                    p_uf = rs_predio.getString("c.predio_uf");
                    p_idPredioSetor = rs_predio.getString("b.idpredio_setor");
                    p_num_pavimento = rs_predio.getString("b.pavimento");
                    p_tipo_pavimento = rs_predio.getString("b.tipo_pavimento");
                    p_prefixo = rs_predio.getString("d.prefixo");
                }
            rs_predio.close();

            ArrayList<Integer> listIdGrupo = new ArrayList<>();              
            ArrayList listDescGrupo = new ArrayList();              
            ArrayList listCorFundoGrupo = new ArrayList();
            ArrayList listCorFrenteGrupo = new ArrayList();
            String qry_buscaGrupo = "";
            qry_buscaGrupo += "SELECT codigo, descricao, cor_fundo, cor_frente ";
            qry_buscaGrupo += "FROM dipes_disst_seguranca.gro_tipo_perigo_grupo ";
            ResultSet rs_buscaGrupo = st.executeQuery(qry_buscaGrupo);
                while (rs_buscaGrupo.next()){
                    listIdGrupo.add(rs_buscaGrupo.getInt("codigo")); 
                    listDescGrupo.add(rs_buscaGrupo.getString("descricao")); 
                    listCorFundoGrupo.add(rs_buscaGrupo.getString("cor_fundo")); 
                    listCorFrenteGrupo.add(rs_buscaGrupo.getString("cor_frente")); 
                }
            rs_buscaGrupo.close();

            ArrayList<Integer> listIdGrupoRisco = new ArrayList<>();  
            ArrayList<Integer> listIdRisco = new ArrayList<>();              
            ArrayList<String> listDescRisco = new ArrayList<>();
            ArrayList<String> listCodigoRisco = new ArrayList<>();  
            String qry_buscaRisco = "";
            qry_buscaRisco += "SELECT a.cd_grupo, a.codigo, a.descricao, CONCAT('g',a.cd_grupo,'r',a.codigo) AS codigo_risco ";
            qry_buscaRisco += "FROM dipes_disst_seguranca.gro_tipo_perigo as a ";
            qry_buscaRisco += "WHERE a.ativo = 1 ";
            qry_buscaRisco += "ORDER BY a.cd_grupo, a.codigo ";
            ResultSet rs_buscaRisco = st.executeQuery(qry_buscaRisco);
                while (rs_buscaRisco.next()){
                    listIdGrupoRisco.add(rs_buscaRisco.getInt("a.cd_grupo"));                     
                    listIdRisco.add(rs_buscaRisco.getInt("a.codigo")); 
                    listDescRisco.add(rs_buscaRisco.getString("a.descricao"));
                    listCodigoRisco.add(rs_buscaRisco.getString("codigo_risco"));   
                }
            rs_buscaRisco.close();

            // Busca se o respondente é RPA ou cipeiro

            String eh_rpa = "";
            String qry_eh_rpa = "";
            qry_eh_rpa += "SELECT a.rpa_cipa ";
            qry_eh_rpa += "FROM dipes_disst_seguranca.ocupantes AS a ";
            qry_eh_rpa += "WHERE a.matricula = "+quem+" ";
            ResultSet rs_qry_eh_rpa = st.executeQuery(qry_eh_rpa);
                while(rs_qry_eh_rpa.next()){
                    eh_rpa = rs_qry_eh_rpa.getString("a.rpa_cipa");
                }
            rs_qry_eh_rpa.close();

            //Busca por dados de respostas anteriores da pessoa que está acessando o mapa
            ArrayList<Integer> listIdGrupoRisco_avaliacao = new ArrayList<>();  
            ArrayList<Integer> listIdRisco_avaliacao = new ArrayList<>();  
            ArrayList<Integer> listIntensidade_avaliacao = new ArrayList<>();  
            String qry_busca_avaliacao = "";

            qry_busca_avaliacao +="SELECT a.cd_grupo, a.codigo, IFNULL(b.intensidade, 0) AS intensidade, b.quem_gravou, a.ativo ";
            qry_busca_avaliacao +="FROM dipes_disst_seguranca.gro_tipo_perigo AS a ";
            qry_busca_avaliacao +="LEFT JOIN dipes_disst_seguranca.mapa_risco_avaliacao AS b ON a.codigo = b.risco AND b.quem_gravou = "+quem+" ";
            qry_busca_avaliacao +="LEFT JOIN dipes_disst_seguranca.mapa_risco AS c ON b.id_mapa = c.id_mapa AND c.dt_limite >= DATE(NOW()) ";
            qry_busca_avaliacao +="WHERE a.ativo = 1 ";
            qry_busca_avaliacao +="ORDER BY a.cd_grupo, a.codigo ";

            ResultSet rs_busca_avaliacao = st.executeQuery(qry_busca_avaliacao);
                while (rs_busca_avaliacao.next()){
                    listIdGrupoRisco_avaliacao.add(rs_busca_avaliacao.getInt("a.cd_grupo"));                     
                    listIdRisco_avaliacao.add(rs_busca_avaliacao.getInt("a.codigo")); 
                    listIntensidade_avaliacao.add(rs_busca_avaliacao.getInt("intensidade"));                     
                }
            rs_busca_avaliacao.close();

        %>
        <div class="card">
            <div class="card-header colorBar text-dark text-center">
                <h5><b> MAPA DE RISCOS - LEVANTAMENTO DOS RISCOS </b></h5>
            </div>
            <div class="card-body text-secondary">
                <div class="form-row">
                    <div class="form-group col-md-11 mx-auto">
                        <div class="row">
                            <div class="col-sm-12">
                                <h5><b>PREZADO(A) COLEGA:</h5></b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <P class=" text-justify h6">O mapa de riscos é uma representação gráfica dos dados, resultante do 
                                levantamento dos riscos existentes no ambiente de trabalho, segundo a percepção dos trabalhadores, 
                                que podem comprometer a saúde do trabalhador. A elaboração do mapa de riscos deve contar com a 
                                participação de todos os funcionários, pois estes estarão tomando conhecimento das suas condições 
                                de trabalho e se conscientizando da necessidade de modificá-las ou preservá-las. Para elaboração 
                                do Mapa de Riscos, você está acessando este questionário para classificar, de acordo com a sua 
                                percepção, a INTENSIDADE dos riscos presentes em sua atividade, assinalando a coluna correspondente, 
                                de acordo com a legenda:</P>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-10 h6">
                                <h5><b>LOCAL:</b></h5>
                                Prédio <%=p_nome%>, Bairro: <%=p_bairro%>, Município: <%=p_mun%>, UF: <%=p_uf%>, Andar: <%=p_num_pavimento%> <%=p_tipo_pavimento%>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"></div>
                            <div class="col-8 col-offset-2">
                                <form method="post" action="mapa_levantamento_grava.jsp">
                                    <input type="hidden" name="id_predio" id="id_predio" value="<%=p_id%>">
                                    <input type="hidden" name="andar" id="andar" value="<%=p_num_pavimento%>">
                                    <input type="hidden" name="ano" id="ano" value="<%=anoAtual%>">
                                    <input type="hidden" name="quem" id="quem" value="<%=quem%>">
                                    <input type="hidden" name="dt_limite_alteracao" id="dt_limite_alteracao" value="<%=dt_limite_alteracao%>">
                                    <input type="hidden" name="eh_rpa" id="eh_rpa" value="<%=eh_rpa%>">
                                    
                                    <table class="table table-sm table-striped table-hover" width="100%" cellspacing="0">
                                        <%for(int i = 0, j = 0; i < listIdGrupo.size(); i++){%>
                                            <tr>
                                                <th class="col-sm-4 h6" style="background-color:<%=listCorFundoGrupo.get(i)%>; color:<%=listCorFrenteGrupo.get(i)%>;"><b><%=listDescGrupo.get(i)%></b></th>
                                                <th class="col-sm-1 h6 text-center"><b>NÃO EXISTE</b></th>
                                                <th class="col-sm-1 h6 text-center"><b>PEQUENO</b></th>
                                                <th class="col-sm-1 h6 text-center"><b>MÉDIO</b></th>
                                                <th class="col-sm-1 h6 text-center"><b>GRANDE</b></th>
                                            </tr>
                                            <%for(; j <  listIdGrupoRisco.size() && listIdGrupo.get(i) == listIdGrupoRisco.get(j) ; j++ ){%>
                                                <%String id_html = "g" + listIdGrupo.get(i) + "r" + listIdRisco.get(j);%>
                                                <tr>
                                                    <th class="col-sm-4 h6"><%=listDescRisco.get(j)%></th>
                                                    <%for(int k = 0; k < 4; k++){%>
                                                        <th class="col-sm-1 h6 text-center">
                                                            <input type="radio" id="<%=id_html%>" name="<%=id_html%>"
                                                                value="<%if(listIdGrupoRisco_avaliacao.size() == 0 && k == 0){%>0<%}else{%><%=k%><%}%>"
                                                                <%if(listIntensidade_avaliacao.get(j) == k){%>
                                                                checked required
                                                                <%}else{%>
                                                                required<%}%>
                                                            >
                                                        </th>
                                                    <%}%>
                                                </tr>
                                            <%}%>
                                        <%}%>
                                    </table>
                            </div>
                        </div>
                                        <div class="card-footer">
                                            <div class="col-12 text-center">
                                                    <input type="submit" name="button" id="button" value="Gravar resposta e ver o Mapa de Riscos" class="btn btn-primary btn-sm" />
                                            </div>
                                        </div>
                            </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
<%@include file="Fecha_ConeXao.jsp"%>

