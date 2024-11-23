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
        <script src='https://cdn.plot.ly/plotly-2.32.0.min.js'></script>

        <script language="javascript">Plotly.setPlotConfig({locale: 'pt-BR'})</script>

        <style type="text/css">
            
            .just-padding {
            padding: 0px;
            }

            @media print { 
                #noprint { display:none; },
                body {
                    background: #fff;
                    print-color-adjust: exact !important;
                },

                .folha {
                    page-break-after: always;
                },
                .article {
                    column-width: 17em;
                    column-gap: 3em;
                },
              
            }
            @page {size: landscape;}
            
        </style>
    </head>

    <body>
        <!-- nav-bar -->	
        <div  name="topo" id="navBarRoll">
            <nav class="navbar navbar-expand-lg navbar-light colorBar">
                <a class="navbar-brand" id="texto_titulo" href="../../../disst/index.jsp">
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
                    <li class="breadcrumb-item"><a href="mapa_levantamento.jsp">Mapa de risco - Levantamento</a></li>
                    <li class="breadcrumb-item text-light active" aria-current="page"><b>Mapa de risco - gráficos</b></li>
                </ol>
            </nav>
        </div>
        <%
            Calendar hoje = Calendar.getInstance();
            int mesAtual = hoje.get(Calendar.MONTH);
            int anoAtual = hoje.get(Calendar.YEAR);

          
            //Dados gerais do prédio do respondente
            String x_UorGrupo = "18914";
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

            //Retorna o total de respondentes no prédio e andar
            int qtd_respondentes = 0;
            String qry_geralRespondentes = "";
            qry_geralRespondentes +="SELECT COUNT(DISTINCT (b.quem_gravou)) AS qtd_respondentes ";
            qry_geralRespondentes +="FROM dipes_disst_seguranca.mapa_risco AS a ";
            qry_geralRespondentes +="INNER JOIN dipes_disst_seguranca.mapa_risco_avaliacao AS b ON a.id_mapa = b.id_mapa ";
            qry_geralRespondentes +="WHERE a.dt_limite >= DATE(NOW()) AND a.id_predio = "+p_id+" AND a.andar = "+p_num_pavimento+" ";
            ResultSet rs_geralRespondentes = st.executeQuery(qry_geralRespondentes);
                while (rs_geralRespondentes.next()){
                    qtd_respondentes = rs_geralRespondentes.getInt("qtd_respondentes");
                }
            rs_geralRespondentes.close();


            //Retorna a validade do mapa de riscos no prédio e andar (a partir da data de resposta do primeiro funcionário é adicionado 1 ano como validade)
            String validade_mapa = "";
            String qry_validade_mapa = "";
            qry_validade_mapa +="SELECT DATE_FORMAT(a.dt_limite, '%d/%m/%Y') AS dt_limite ";
            qry_validade_mapa +="FROM dipes_disst_seguranca.mapa_risco AS a ";
            qry_validade_mapa +="WHERE a.dt_limite >= DATE(NOW()) AND a.id_predio = "+p_id+" AND a.andar = "+p_num_pavimento+" ";
            ResultSet rs_validade_mapa = st.executeQuery(qry_validade_mapa);
                while (rs_validade_mapa.next()){
                    validade_mapa = rs_validade_mapa.getString("dt_limite");
                }
            rs_validade_mapa.close();


            //Retorna os totais das intensidades dos riscos indicados pelo funcionários no predio/andar (Pequeno = 1, médio = 2, grande = 3)
            
            int tot_risco_pequeno = 0;
            int tot_risco_medio = 0;
            int tot_risco_grande = 0;
            String qry_total_riscos = "";
            qry_total_riscos +="SELECT "; 
            qry_total_riscos +="SUM(if(b.intensidade = 1, 1, 0)) AS risco_pequeno, ";
            qry_total_riscos +="SUM(if(b.intensidade = 2, 1, 0)) AS risco_medio, ";
            qry_total_riscos +="SUM(if(b.intensidade = 3, 1, 0)) AS risco_grande ";
            qry_total_riscos +="FROM dipes_disst_seguranca.mapa_risco AS a ";
            qry_total_riscos +="INNER JOIN dipes_disst_seguranca.mapa_risco_avaliacao AS b ON a.id_mapa = b.id_mapa ";
            qry_total_riscos +="INNER JOIN dipes_disst_seguranca.gro_tipo_perigo AS c ON b.risco = c.codigo ";
            qry_total_riscos +="WHERE a.dt_limite >= DATE(NOW()) AND c.ativo = 1 AND a.id_predio = "+p_id+" AND a.andar = "+p_num_pavimento+" ";
            ResultSet rs_total_riscos = st.executeQuery(qry_total_riscos);
                while (rs_total_riscos.next()){
                    tot_risco_pequeno = rs_total_riscos.getInt("risco_pequeno");
                    tot_risco_medio = rs_total_riscos.getInt("risco_medio");
                    tot_risco_grande = rs_total_riscos.getInt("risco_grande");
                }
            rs_total_riscos.close();

            String label_pequeno = "";
            String label_medio = "";
            String label_grande = "";
            if(tot_risco_pequeno != 0){label_pequeno = "Risco Pequeno";} else {label_pequeno = "Risco pequeno não observado.";}
            if(tot_risco_medio != 0){label_medio = "Risco Médio";} else {label_medio = "Risco médio não observado.";}
            if(tot_risco_grande != 0){label_grande = "Risco Grande";} else {label_grande = "Risco grande não observado.";}


        %>
        <div class="card-header colorBar text-dark text-center">
            <h5><b>MAPA DE RISCOS - ANDAR: <%=p_num_pavimento%> - VÁLIDO ATÉ: <%=validade_mapa%></b></h5> 
            <div class="h6"><b>LOCAL:</b> PRÉDIO <%=p_nome%>, BAIRRO: <%=p_bairro%>, MUNICÍPIO: <%=p_mun%>, UF: <%=p_uf%>.</div>
        </div>
        <div class="card">
            <div class="form-group row">           
            </div>
            

            <div class="form-group row">
                <div class="card col-3 border-0 ml-0 mr-0 mt-0 mb-0 pl-0 pr-0 pt-0 pb-0">
                    <div class="card-body text-secondary">
                        <div class="just-padding"> 
                            <div id="geral_grafico_risco_1"></div>
                            <%if(tot_risco_pequeno != 0){%>
                                <div class="card-footer mt-3">
                                    <div class="row mb-3 text-center">
                                        <div class=col-12>
                                            Riscos identificados nível BAIXO:
                                        </div>
                                    </div> 
                                    <%
                                        String geral_risco_pequeno = "";
                                        String qry_detalha_risco_peq = "";
                                        qry_detalha_risco_peq +="SELECT CONCAT(c.descricao, ' - ', d.descricao, ' - Expostos: ', COUNT(d.codigo)) geral_risco_pequeno ";
                                        qry_detalha_risco_peq +="FROM dipes_disst_seguranca.mapa_risco AS a ";
                                        qry_detalha_risco_peq +="INNER JOIN dipes_disst_seguranca.mapa_risco_avaliacao AS b ON a.id_mapa = b.id_mapa ";
                                        qry_detalha_risco_peq +="INNER JOIN dipes_disst_seguranca.gro_tipo_perigo_grupo AS c ON b.grupo = c.codigo ";
                                        qry_detalha_risco_peq +="INNER JOIN dipes_disst_seguranca.gro_tipo_perigo AS d ON b.risco = d.codigo ";
                                        qry_detalha_risco_peq +="WHERE a.dt_limite >= DATE(NOW()) AND d.ativo = 1 AND a.id_predio = "+p_id+" AND a.andar = "+p_num_pavimento+" AND b.intensidade = 1 ";
                                        qry_detalha_risco_peq +="GROUP BY c.codigo, d.codigo ";
                                        qry_detalha_risco_peq +="ORDER BY c.codigo, d.codigo ";
                                        ResultSet rs_detalha_risco_peq = st.executeQuery(qry_detalha_risco_peq);
                                            while (rs_detalha_risco_peq.next()){ 
                                                geral_risco_pequeno = rs_detalha_risco_peq.getString("geral_risco_pequeno");
                                    %>
                                                <div class="row">
                                                    <div class=col-12>
                                                        <i class="fas fa-check fa-sm"></i> <%=geral_risco_pequeno%>
                                                    </div>
                                                </div>
                                    <%        
                                            }
                                        rs_detalha_risco_peq.close();
                                    %>
                                </div>
                            <%}%>
                        </div>
                    </div>    
                </div>

                <div class="card col-3 border-0 ml-0 mr-0 mt-0 mb-0 pl-0 pr-0 pt-0 pb-0">
                    <div class="card-body text-secondary">
                        <div class="just-padding"> 
                            <div id="geral_grafico_risco_2"></div>
                            <%if(tot_risco_medio != 0){%>
                                <div class="card-footer mt-3">
                                    <div class="row mb-3 text-center">
                                        <div class=col-12>
                                            Riscos identificados - Nível MÉDIO:
                                        </div>
                                    </div> 
                                    <%
                                        String geral_risco_medio = "";
                                        String qry_detalha_risco_med = "";
                                        qry_detalha_risco_med +="SELECT CONCAT(c.descricao, ' - ', d.descricao, ' - Expostos: ', COUNT(d.codigo)) geral_risco_medio ";
                                        qry_detalha_risco_med +="FROM dipes_disst_seguranca.mapa_risco AS a ";
                                        qry_detalha_risco_med +="INNER JOIN dipes_disst_seguranca.mapa_risco_avaliacao AS b ON a.id_mapa = b.id_mapa ";
                                        qry_detalha_risco_med +="INNER JOIN dipes_disst_seguranca.gro_tipo_perigo_grupo AS c ON b.grupo = c.codigo ";
                                        qry_detalha_risco_med +="INNER JOIN dipes_disst_seguranca.gro_tipo_perigo AS d ON b.risco = d.codigo ";
                                        qry_detalha_risco_med +="WHERE a.dt_limite >= DATE(NOW()) AND d.ativo = 1 AND a.id_predio = "+p_id+" AND a.andar = "+p_num_pavimento+" AND b.intensidade = 2 ";
                                        qry_detalha_risco_med +="GROUP BY c.codigo, d.codigo ";
                                        qry_detalha_risco_med +="ORDER BY c.codigo, d.codigo ";
                                        ResultSet rs_detalha_risco_med = st.executeQuery(qry_detalha_risco_med);
                                            while (rs_detalha_risco_med.next()){ 
                                                geral_risco_medio = rs_detalha_risco_med.getString("geral_risco_medio");
                                    %>
                                                <div class="row">
                                                    <div class=col-12>
                                                        <i class="fas fa-check fa-sm"></i> <%=geral_risco_medio%>
                                                    </div>
                                                </div>
                                    <%        
                                            }
                                        rs_detalha_risco_med.close();
                                    %>
                                </div>
                            <%}%>
                        </div>
                    </div>    
                </div>

               <div class="card col-3 border-0 ml-0 mr-0 mt-0 mb-0 pl-0 pr-0 pt-0 pb-0">
                    <div class="card-body text-secondary">
                        <div class="just-padding"> 
                            <div id="geral_grafico_risco_3"></div>
                            <%if(tot_risco_grande != 0){%>
                                <div class="card-footer mt-3">
                                    <div class="row mb-3 text-center">
                                        <div class=col-12>
                                            Riscos identificados nível ALTO:
                                        </div>
                                    </div> 
                                    <%
                                        String geral_risco_grande = "";
                                        String qry_detalha_risco_gra = "";
                                        qry_detalha_risco_gra +="SELECT CONCAT(c.descricao, ' - ', d.descricao, ' - Expostos: ', COUNT(d.codigo)) geral_risco_grande ";
                                        qry_detalha_risco_gra +="FROM dipes_disst_seguranca.mapa_risco AS a ";
                                        qry_detalha_risco_gra +="INNER JOIN dipes_disst_seguranca.mapa_risco_avaliacao AS b ON a.id_mapa = b.id_mapa ";
                                        qry_detalha_risco_gra +="INNER JOIN dipes_disst_seguranca.gro_tipo_perigo_grupo AS c ON b.grupo = c.codigo ";
                                        qry_detalha_risco_gra +="INNER JOIN dipes_disst_seguranca.gro_tipo_perigo AS d ON b.risco = d.codigo ";
                                        qry_detalha_risco_gra +="WHERE a.dt_limite >= DATE(NOW()) AND d.ativo = 1 AND a.id_predio = "+p_id+" AND a.andar = "+p_num_pavimento+" AND b.intensidade = 3 ";
                                        qry_detalha_risco_gra +="GROUP BY c.codigo, d.codigo ";
                                        qry_detalha_risco_gra +="ORDER BY c.codigo, d.codigo ";
                                        ResultSet rs_detalha_risco_gra = st.executeQuery(qry_detalha_risco_gra);
                                            while (rs_detalha_risco_gra.next()){ 
                                                geral_risco_grande = rs_detalha_risco_gra.getString("geral_risco_grande");
                                    %>
                                                <div class="row">
                                                    <div class=col-12>
                                                        <i class="fas fa-check fa-sm"></i> <%=geral_risco_grande%>
                                                    </div>
                                                </div>
                                    <%        
                                            }
                                        rs_detalha_risco_gra.close();
                                    %>
                                </div>
                            <%}%>
                        </div>
                    </div>    
                </div>

                <div class="card col-2 border-0">
                    <div class="card-body text-secondary">
                        <div class="just-padding"> 
                            <div id="legenda"></div>
                                <table class="table table-sm table-bordered" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th class="text-center"><strong>Grupo</strong></th>
                                        <th class="text-left"><strong>Risco</strong></th>
                                        <th><strong>Cor</strong></th>
                                    </tr>
                                </thead>  
                                <tbody>
                                    <tr>
                                        <th class="text-center">1</th>
                                        <td class="text-left">Físico</td>
                                        <td class="text-left" style="background-color:#00b050;"></td>
                                    </tr> 
                                    <tr>
                                        <th class="text-center">2</th>
                                        <td class="text-left">Químico</td>
                                        <td class="text-left" style="background-color:#ff0000;"></td>
                                    </tr> 
                                    <tr>
                                        <th class="text-center">3</th>
                                        <td class="text-left">Biológico</td>
                                        <td class="text-left" style="background-color:#833c0c;"></td>
                                    </tr> 
                                    <tr>
                                        <th class="text-center">4</th>
                                        <td class="text-left">Ergonômico</td>
                                        <td class="text-left" style="background-color:#ffff00;"></td>
                                    </tr> 
                                    <tr>
                                        <th class="text-center">5</th>
                                        <td class="text-left">Acidente</td>
                                        <td class="text-left" style="background-color:#0070c0;"></td>
                                    </tr> 
                                </tbody>
                            </table>
                            Total de respondentes no andar: <%=qtd_respondentes%>
                        </div>
                    </div>    
                </div>
            </div>
            <div class="card-footer">
                <div class="col-12 text-center">
                    <form method="post" action="mapa_levantamento.jsp">
                        <input type="hidden" name="a" id="a" value="(Substituir Variavel)">
                        <input type="hidden" name="an" id="an" value="(Substituir Variavel)">
                        <input type="submit" name="button" id="button" value="Retornar ao questionário" class="btn btn-primary btn-sm" />
                    </form>
                </div>	
            </div>  

            <%
                /*Numeros para o gráfico de risco pequeno*/
                    int qtd_pequeno_fisico = 0;
                    int qtd_pequeno_quimico = 0;
                    int qtd_pequeno_biologico = 0;
                    int qtd_pequeno_ergonomico = 0;
                    int qtd_pequeno_acidente = 0;
                    String qry_qtd_risco_pequeno = "";
                    qry_qtd_risco_pequeno +="SELECT ";
                    qry_qtd_risco_pequeno +="SUM(if(b.grupo = 1, 1, 0)) AS qtd_pequeno_fisico, ";
                    qry_qtd_risco_pequeno +="SUM(if(b.grupo = 2, 1, 0)) AS qtd_pequeno_quimico, ";
                    qry_qtd_risco_pequeno +="SUM(if(b.grupo = 3, 1, 0)) AS qtd_pequeno_biologico, ";
                    qry_qtd_risco_pequeno +="SUM(if(b.grupo = 4, 1, 0)) AS qtd_pequeno_ergonomico, ";
                    qry_qtd_risco_pequeno +="SUM(if(b.grupo = 5, 1, 0)) AS qtd_pequeno_acidente ";
                    qry_qtd_risco_pequeno +="FROM dipes_disst_seguranca.mapa_risco AS a ";
                    qry_qtd_risco_pequeno +="INNER JOIN dipes_disst_seguranca.mapa_risco_avaliacao AS b ON a.id_mapa = b.id_mapa ";
                    qry_qtd_risco_pequeno +="INNER JOIN dipes_disst_seguranca.gro_tipo_perigo_grupo AS c ON b.grupo = c.codigo ";
                    qry_qtd_risco_pequeno +="INNER JOIN dipes_disst_seguranca.gro_tipo_perigo AS d ON b.risco = d.codigo ";
                    qry_qtd_risco_pequeno +="WHERE a.dt_limite >= DATE(NOW()) AND d.ativo = 1 AND a.id_predio = "+p_id+" AND a.andar = "+p_num_pavimento+" AND b.intensidade = 1 ";
                    ResultSet rs_qtd_risco_pequeno = st.executeQuery(qry_qtd_risco_pequeno);
                        while (rs_qtd_risco_pequeno.next()){ 
                            qtd_pequeno_fisico = rs_qtd_risco_pequeno.getInt("qtd_pequeno_fisico");
                            qtd_pequeno_quimico = rs_qtd_risco_pequeno.getInt("qtd_pequeno_quimico");
                            qtd_pequeno_biologico = rs_qtd_risco_pequeno.getInt("qtd_pequeno_biologico");
                            qtd_pequeno_ergonomico = rs_qtd_risco_pequeno.getInt("qtd_pequeno_ergonomico");
                            qtd_pequeno_acidente = rs_qtd_risco_pequeno.getInt("qtd_pequeno_acidente");
                        }
                    rs_qtd_risco_pequeno.close();

                    if(qtd_pequeno_fisico != 0){qtd_pequeno_fisico = 1;}
                    if(qtd_pequeno_quimico != 0){qtd_pequeno_quimico = 1;}
                    if(qtd_pequeno_biologico != 0){qtd_pequeno_biologico = 1;}
                    if(qtd_pequeno_ergonomico != 0){qtd_pequeno_ergonomico = 1;}
                    if(qtd_pequeno_acidente != 0){qtd_pequeno_acidente = 1;}



                /*Numeros para o gráfico de risco médio*/
                    int qtd_medio_fisico = 0;
                    int qtd_medio_quimico = 0;
                    int qtd_medio_biologico = 0;
                    int qtd_medio_ergonomico = 0;
                    int qtd_medio_acidente = 0;
                    String qry_qtd_risco_medio = "";
                    qry_qtd_risco_medio +="SELECT ";
                    qry_qtd_risco_medio +="SUM(if(b.grupo = 1, 1, 0)) AS qtd_medio_fisico, ";
                    qry_qtd_risco_medio +="SUM(if(b.grupo = 2, 1, 0)) AS qtd_medio_quimico, ";
                    qry_qtd_risco_medio +="SUM(if(b.grupo = 3, 1, 0)) AS qtd_medio_biologico, ";
                    qry_qtd_risco_medio +="SUM(if(b.grupo = 4, 1, 0)) AS qtd_medio_ergonomico, ";
                    qry_qtd_risco_medio +="SUM(if(b.grupo = 5, 1, 0)) AS qtd_medio_acidente ";
                    qry_qtd_risco_medio +="FROM dipes_disst_seguranca.mapa_risco AS a ";
                    qry_qtd_risco_medio +="INNER JOIN dipes_disst_seguranca.mapa_risco_avaliacao AS b ON a.id_mapa = b.id_mapa ";
                    qry_qtd_risco_medio +="INNER JOIN dipes_disst_seguranca.gro_tipo_perigo_grupo AS c ON b.grupo = c.codigo ";
                    qry_qtd_risco_medio +="INNER JOIN dipes_disst_seguranca.gro_tipo_perigo AS d ON b.risco = d.codigo ";
                    qry_qtd_risco_medio +="WHERE a.dt_limite >= DATE(NOW()) AND d.ativo = 1 AND a.id_predio = "+p_id+" AND a.andar = "+p_num_pavimento+" AND b.intensidade = 2 ";
                    ResultSet rs_qtd_risco_medio = st.executeQuery(qry_qtd_risco_medio);
                        while (rs_qtd_risco_medio.next()){ 
                            qtd_medio_fisico = rs_qtd_risco_medio.getInt("qtd_medio_fisico");
                            qtd_medio_quimico = rs_qtd_risco_medio.getInt("qtd_medio_quimico");
                            qtd_medio_biologico = rs_qtd_risco_medio.getInt("qtd_medio_biologico");
                            qtd_medio_ergonomico = rs_qtd_risco_medio.getInt("qtd_medio_ergonomico");
                            qtd_medio_acidente = rs_qtd_risco_medio.getInt("qtd_medio_acidente");
                        }
                    rs_qtd_risco_medio.close();

                    if(qtd_medio_fisico != 0){qtd_medio_fisico = 1;}
                    if(qtd_medio_quimico != 0){qtd_medio_quimico = 1;}
                    if(qtd_medio_biologico != 0){qtd_medio_biologico = 1;}
                    if(qtd_medio_ergonomico != 0){qtd_medio_ergonomico = 1;}
                    if(qtd_medio_acidente != 0){qtd_medio_acidente = 1;}



                /*Numeros para o gráfico de risco grande*/
                    int qtd_grande_fisico = 0;
                    int qtd_grande_quimico = 0;
                    int qtd_grande_biologico = 0;
                    int qtd_grande_ergonomico = 0;
                    int qtd_grande_acidente = 0;
                    String qry_qtd_risco_grande = "";
                    qry_qtd_risco_grande +="SELECT ";
                    qry_qtd_risco_grande +="SUM(if(b.grupo = 1, 1, 0)) AS qtd_grande_fisico, ";
                    qry_qtd_risco_grande +="SUM(if(b.grupo = 2, 1, 0)) AS qtd_grande_quimico, ";
                    qry_qtd_risco_grande +="SUM(if(b.grupo = 3, 1, 0)) AS qtd_grande_biologico, ";
                    qry_qtd_risco_grande +="SUM(if(b.grupo = 4, 1, 0)) AS qtd_grande_ergonomico, ";
                    qry_qtd_risco_grande +="SUM(if(b.grupo = 5, 1, 0)) AS qtd_grande_acidente ";
                    qry_qtd_risco_grande +="FROM dipes_disst_seguranca.mapa_risco AS a ";
                    qry_qtd_risco_grande +="INNER JOIN dipes_disst_seguranca.mapa_risco_avaliacao AS b ON a.id_mapa = b.id_mapa ";
                    qry_qtd_risco_grande +="INNER JOIN dipes_disst_seguranca.gro_tipo_perigo_grupo AS c ON b.grupo = c.codigo ";
                    qry_qtd_risco_grande +="INNER JOIN dipes_disst_seguranca.gro_tipo_perigo AS d ON b.risco = d.codigo ";
                    qry_qtd_risco_grande +="WHERE a.dt_limite >= DATE(NOW()) AND d.ativo = 1 AND a.id_predio = "+p_id+" AND a.andar = "+p_num_pavimento+" AND b.intensidade = 3 ";
                    ResultSet rs_qtd_risco_grande = st.executeQuery(qry_qtd_risco_grande);
                        while (rs_qtd_risco_grande.next()){ 
                            qtd_grande_fisico = rs_qtd_risco_grande.getInt("qtd_grande_fisico");
                            qtd_grande_quimico = rs_qtd_risco_grande.getInt("qtd_grande_quimico");
                            qtd_grande_biologico = rs_qtd_risco_grande.getInt("qtd_grande_biologico");
                            qtd_grande_ergonomico = rs_qtd_risco_grande.getInt("qtd_grande_ergonomico");
                            qtd_grande_acidente = rs_qtd_risco_grande.getInt("qtd_grande_acidente");
                        }
                    rs_qtd_risco_grande.close();

                    if(qtd_grande_fisico != 0){qtd_grande_fisico = 1;}
                    if(qtd_grande_quimico != 0){qtd_grande_quimico = 1;}
                    if(qtd_grande_biologico != 0){qtd_grande_biologico = 1;}
                    if(qtd_grande_ergonomico != 0){qtd_grande_ergonomico = 1;}
                    if(qtd_grande_acidente != 0){qtd_grande_acidente = 1;}
            %>
<!--
        <script>
            function MM_jumpMenu(targ, selObj, restore) { //v3.0
                eval(targ + ".location='" + selObj.options[selObj.selectedIndex].value + "'");
                if (restore) selObj.selectedIndex = 0;
            }
        </script>
-->
    </body>
</html>
<%@include file="Fecha_ConeXao.jsp"%>
