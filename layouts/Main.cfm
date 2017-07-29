<!DOCTYPE html>
<cfprocessingdirective pageEncoding="utf-8"> 
<html>
    <head>
        <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">

	    <title>SII | IPN</title>

	    <!-- Hojas de estilo -->
	    <link href="/includes/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
	    <link href="/includes/bootstrap/bootstrap-select/bootstrap-select.min.css" rel="stylesheet">
	    <link href="/includes/font-awesome/css/font-awesome.css" rel="stylesheet">
	    <link href="/includes/css/inspinia/animate.css" rel="stylesheet">
	    <link href="/includes/css/inspinia/style.css" rel="stylesheet">	   	  
	    <link href="/includes/css/plugins/morris/morris-0.4.3.min.css" rel="stylesheet">
		<link href="/includes/css/plugins/iCheck/custom.css" rel="stylesheet">
		<link rel="stylesheet" href="/includes/css/jquery-ui/jquery-ui.min.css">
	    <link href="/includes/css/plugins/pageguide/pageguide.min.css" rel="stylesheet">
	    <link href="/includes/css/reportesAdhoc.css" rel="stylesheet">     

	    <!-- Scripts -->
		<script src="/includes/js/jquery/jquery-2.1.4.min.js"></script>
		<script src="/includes/js/jquery/jquery-ui-1.11.4.min.js"></script>
		
		<script src="/includes/js/jquery-validation-1.14.0/jquery.validate.min.js"></script>	

		<script src="/includes/bootstrap/3.3.4/js/bootstrap.min.js"></script>
		<script src="/includes/bootstrap/bootstrap-select/bootstrap-select.min.js"></script>
		<script src="/includes/js/inspinia/plugins/metisMenu/jquery.metisMenu.js"></script>
		<script src="/includes/js/inspinia/plugins/slimscroll/jquery.slimscroll.min.js"></script>	
		<script type="text/javascript" src="/includes/js/pageguide/pageguide.js"></script>	
		
		<!-- Plugin javascript -->
		<script src="/includes/js/inspinia/inspinia.js"></script>
		<script src="/includes/js/inspinia/plugins/pace/pace.min.js"></script>
		<script src="/includes/js/inspinia/plugins/toastr/toastr.min.js"></script>

		<script language="javascript" src="/includes/js/jspdf/jspdf.min.js"></script>
		<script language="javascript" src="/includes/js/qrCode/qrcode.min.js"></script>

		<!-- Morris -->
		<script src="/includes/js/inspinia/plugins/morris/raphael-2.1.0.min.js"></script>
		<script src="/includes/js/inspinia/plugins/morris/morris.js"></script>
		<!-- iCheck -->
    	<script src="/includes/js/inspinia/plugins/iCheck/icheck.min.js"></script>

    	<!--- FusionCharts --->
    	<script type="text/javascript" src="/includes/js/fusioncharts/fusioncharts.js"></script>
		<script type="text/javascript" src="/includes/js/fusioncharts/themes/fusioncharts.theme.zune.js"></script>	
		<script type="text/javascript" src="/includes/js/fusioncharts/themes/fusioncharts.theme.carbon.js"></script>	
		<script type="text/javascript" src="/includes/js/fusioncharts/themes/fusioncharts.theme.fint.js"></script>	
		<script type="text/javascript" src="/includes/js/fusioncharts/themes/fusioncharts.theme.ocean.js"></script>	

    	<!--- <script src="/includes/js/Chart.js"></script> --->
    	<cfinclude template="Main_js.cfm">
	  
    </head>
    <style type="text/css">
    .border-top{
    	border-top: 1px solid #e7eaec !important;
    }
	.header {
	   /*position: fixed !important;*/
	   /*width: 100%;*/
	   /*z-index: 10000;*/
	   	z-index: 2001;	    
	    position: absolute;
	    top:0px;
	    width: 100%;
	    height: 80px;
	    /*background: #F3F3F4;*/
	    background:	#f1f3f3;
	 }
	 .header-fixed {	   
	   	z-index: 2001;	    
	    position: fixed;
	    top:0px;
	    width: 100%;
	    height: 80px;
	    /*background: #F3F3F4;*/
	    background:	#f1f3f3;
	 }
	 
	.site { 
	 	padding-top: 80px; 
	 	/*z-index: 10000;*/ 
	 }

	.pace-done .nav-header {
		transition: all 0.5s;
	    -webkit-transition: all 0.5s;
	    -moz-transition: all 0.5s;
	    -o-transition: all 0.5s;
	    transition: all 0.5s;
	}

	@media (max-width: 768px) {
	    .h_img0{       
	        display: none;
	    }
	    .h_img1{
	    	padding-right: inherit !important;
	    }
	}

	.h_img0{
		padding-left: 71px;
	}

	.h_img1 {
		padding-right: 80px;
	}

    </style>
    <body <!--- class="skin-1" ---> class="site">

        <cfoutput>
    		<nav class="navbar-default navbar-static-side" role="navigation">
		        <div class="sidebar-collapse">
		            <ul class="nav" id="side-menu">
		                <li class="nav-header">
		                    
		                    <div class="dropdown profile-element" style="text-align: center;">
		                        
		                            <!--- <span> --->
		                                <img alt="image" style="width:105px" src="/includes/img/logo/LogoSII_mini.png">
		                                <!--- 
		                                <cfif #Session.cbstorage.usuario.GENERO# EQUAL 4>	
		                                	<img alt="image" class="img-circle" src="/includes/img/menu/man.png">
		                                <cfelse>
		                                	<img alt="image" class="img-circle" src="/includes/img/menu/woman.png">
		                                </cfif>
		                                --->
		                            <!--- </span> --->
		                            <a data-toggle="dropdown" class="dropdown-toggle" href="">
			                            <span class="clear"> 			                            	
			                            	<span class="block m-t-xs"> <strong class="font-bold">  #Session.cbstorage.usuario.NOMBRE# #Session.cbstorage.usuario.AP_PAT#</strong> <b class="caret"></b>
			                             	</span>                        	                        	
			                         	</span> 
			                         	
		                         	</a>
		                            <ul class="dropdown-menu animated fadeInRight m-t-xs">
		                                <li><a href="#event.buildLink('login.cerrarSesion')#">Cerrar Sesión</a></li>
		                            </ul>		                        
		                    </div>
		                    <div class="logo-element">
		                        <!--- SII --->
		                        <img alt="image" style="width:56px" src="/includes/img/logo/LogoSII_mini.png">
		                    </div>
		                </li>				

		                <li class="#event.getActiveLink('inicio.index')#">
		                    <a href="#event.buildLink('inicio.index')#"><i class="fa fa-th-large"></i> <span class="nav-label">Dashboard principal</span></a>
		                </li>            

					    <cfset auxsecretaria = ''>
						<cfset auxmodulo = ''>
						<cfloop index="x" from="1" to="#Session.cbstorage.menu.recordcount#">     
						    <cfif auxmodulo NEQ #Session.cbstorage.menu.MODULO[x]#>						      
						      <li <!--- class="#event.getActiveLink('#Session.cbstorage.menu.URL_N1[x]#')#" --->>
						        <a href="##"><i class="#Session.cbstorage.menu.ICON_N2[x]#"></i> 
						        <span class="nav-label">#Session.cbstorage.menu.NOM_N2[x]# </span>
						        <span class="fa arrow"></span></a>						      
						      	<cfset auxmodulo = #Session.cbstorage.menu.MODULO[x]#>

						      	 <ul class="nav nav-second-level">
							            <cfloop index="z" from="1" to="#Session.cbstorage.menu.recordcount#">
								        	<cfif auxmodulo EQUAL #Session.cbstorage.menu.MODULO[z]#>
								        			<cfif #Session.cbstorage.menu.CONCATENA[z]# neq 0>  

									                <li class="#event.getActiveLink('#Session.cbstorage.menu.URL_N3[z]##Session.cbstorage.menu.CONJUNTO[z]#')#">
									                <!--- <a href="#event.buildLink('#Session.cbstorage.menu.URL_N2[z]#')#">#Session.cbstorage.menu.NOM_N3[z]#</a> --->
									                <a href="#event.buildLink('#Session.cbstorage.menu.URL_N3[z]##Session.cbstorage.menu.CONJUNTO[z]#')#">#Session.cbstorage.menu.NOM_N3[z]#</a>
									                </li>
									                <cfelse>
									                <li class="#event.getActiveLink('#Session.cbstorage.menu.URL_N3[z]#')#">
									                <!--- <a href="#event.buildLink('#Session.cbstorage.menu.URL_N2[z]#')#">#Session.cbstorage.menu.NOM_N3[z]#</a> --->
									                <a href="#event.buildLink('#Session.cbstorage.menu.URL_N3[z]#')#">#Session.cbstorage.menu.NOM_N3[z]#</a>
									                </li>

									                </cfif>
								                                    
								            </cfif>
							      		</cfloop>
							    </ul>
						     
						      </li>					      
						    </cfif>
					    </cfloop> 				

					    <li class="#event.getActiveLink('indicadores.indicadores.index')#">
		                    <a href="#event.buildLink('indicadores.indicadores.index')#"><i class="fa fa-line-chart"></i><span class="nav-label">Indicadores</span></a>
		                </li>
						
		            </ul>

		        </div>
		    </nav>
		</cfoutput>

	    <div id="headerSII" class="header pace-done border-bottom">	
	    	<!--- <div class="row"> --->
	    	
	    	<div class="col-lg-1"></div>
	    	<div class="col-lg-5 h_img0">
	    		<img class="pull-left" style="width:220px" src="/includes/img/logo/logo_sep.png">
	    	</div> 
	    	<div class="col-lg-5 h_img1">
	    		<img class="pull-right" style="width:220px" src="/includes/img/logo/logo_ipn.png">
	    	</div>
	    	<div class="col-lg-1"></div>
	    	<!--- </div> --->
    	</div>

	    <div id="wrapper">    		    
		    <div id="page-wrapper" class="gray-bg">          	
				
		        <div class="row border-bottom">
                	<nav class="navbar navbar-static-top white-bg" role="navigation" style="margin-bottom: 0">
		                <div class="navbar-header col-lg-1">
		                    <a class="navbar-minimalize minimalize-styl-2 btn btn-primary "><i class="fa fa-bars"></i> </a>
		                </div>

		                <ul class="nav navbar-top-links navbar-right">
		                    <li>
		                    	<cfoutput>
		                        <a href="#event.buildLink('login.cerrarSesion')#">
		                            <i class="fa fa-sign-out"></i> Cerrar sesión
		                        </a>
		                        </cfoutput>
		                    </li>
		                </ul>

		            </nav>		                
		        </div>
		        
		        <cfoutput>
		           	#renderView()#
		        </cfoutput>		        

	    	</div>
    	</div>

    	<div class="theme-config">
		    <div class="theme-config-box">
		        <div class="spin-icon">
		            <i class="fa fa-cogs fa-spin"></i>
		        </div>
		        <div class="skin-setttings">
		            <div class="title">Configuraciones</div>
		            <div class="setings-item">
		                    <span>
		                        Fijar <br> encabezado
		                    </span>

		                <div class="switch">
		                    <div class="onoffswitch">
		                        <input type="checkbox" name="fixedheader" class="onoffswitch-checkbox" id="fixedheader">
		                        <label class="onoffswitch-label" for="fixedheader">
		                            <span class="onoffswitch-inner"></span>
		                            <span class="onoffswitch-switch"></span>
		                        </label>
		                    </div>
		                </div>
		            </div>		            
		            <div class="setings-item pageguide">
		                    <span>
		                        Ver guía de <br> ayuda
		                    </span>

		                <div class="switch">
		                    <div class="onoffswitch">
		                        <input type="checkbox" name="showpageguide" class="onoffswitch-checkbox" id="showpageguide">
		                        <label class="onoffswitch-label" for="showpageguide">
		                            <span class="onoffswitch-inner"></span>
		                            <span class="onoffswitch-switch"></span>
		                        </label>
		                    </div>
		                </div>
		            </div>
		            <div class="setings-item filters">
		                    <span>
		                        Ocultar filtros
		                    </span>

		                <div class="switch">
		                    <div class="onoffswitch">
		                        <input type="checkbox" name="collapsefilters" class="onoffswitch-checkbox" id="collapsefilters">
		                        <label class="onoffswitch-label" for="collapsefilters">
		                            <span class="onoffswitch-inner"></span>
		                            <span class="onoffswitch-switch"></span>
		                        </label>
		                    </div>
		                </div>
		            </div>
		            <!--- 
		            <div class="setings-item">
	                    <span>
	                        Ver Reportes <br> Estratégicos
	                    </span>
		                <div class="switch">
		                    <div class="onoffswitch">
		                        <input type="checkbox" name="showreport" class="onoffswitch-checkbox" id="showreport">
		                        <label class="onoffswitch-label" for="showreport">
		                            <span class="onoffswitch-inner"></span>
		                            <span class="onoffswitch-switch"></span>
		                        </label>
		                    </div>
		                </div>
		            </div>
		            --->
		        </div>
		    </div>
		</div>

    </body>
</html>   
