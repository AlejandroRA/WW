<!---
* =========================================================================
* IPN - CSII
* Sistema: SII
* Modulo: Principal 
* Sub modulo: Login
* Fecha: Junio 17, 2015
* Descripcion: Permite el acceso al sistema y muestra contenidos informativos
* @author Yareli Andrade
* =========================================================================
--->

<!DOCTYPE html>
<cfprocessingdirective pageEncoding="utf-8">    
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SII | IPN</title>

    <!-- Hojas de estilo -->
    <link href="/includes/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
    <link href="/includes/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/includes/css/inspinia/animate.css" rel="stylesheet">
    <link href="/includes/css/inspinia/style.css" rel="stylesheet">

    <!-- Scripts -->
    <script src="/includes/js/jquery/jquery-2.1.4.min.js"></script>
    <script src="/includes/bootstrap/3.3.4/js/bootstrap.min.js"></script>

		<style type="text/css">

			.bienvenida {
				font-family: "Myriad Pro";
				font-size: 18px;
				font-weight: 500;
				color: #7F2554;
			}
			.leyenda{
				font-family: "Myriad Pro";
				font-size: 18px;
				font-weight: 500;
				color: #686266;
			}
			.leyenda{
				font-family: "Myriad Pro";
				font-size: 18px;
				font-weight: 500;
				color: #686266;
				text-align:center;
			}
			.usuario{
				font-family: "Myriad Pro";
				font-size: 18px;
				font-weight: 500;
				color: #B7B6B6;
				background-position: left center;
				background-image: url(/includes/img/login/usuario.png);
				background-repeat: no-repeat;
				padding-left: 35px;
			}.pass{
				font-family: "Myriad Pro";
				font-size: 18px;
				font-weight: 500;
				color: #B7B6B6;
				background-position: left center;
				background-image: url(/includes/img/login/contras.png);
				background-repeat: no-repeat;
				padding-left: 35px;
			}
			.version{
				font-family: "Open Sans";
				font-size: 10px;
				font-weight: 500;
				color: #686266;
			}
			.direccion{
				font-family: "Open Sans";
				font-size: 10px;
				font-weight: 500;
				color: #686266;
				text-align:center;
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
</head>

<body class="gray-bg">
	<!---
    <div class="middle-box text-center loginscreen animated fadeInDown">
        <div>
            <div>
                <!--- <h1 class="logo-name">SII</h1> --->
                <img src="/includes/img/logo/LogoSII.png" style="width:300px">
            </div>
	--->
	<div class="animated fadeInDown">
		<div  class="pace-done">	
	    	<div class="row">
	    		<div class="col-lg-1"></div>
		    	<div class="col-lg-5 h_img0"> 
		    		<img class="pull-left" style="width:220px" src="/includes/img/logo/logo_sep.png">
		    	</div> 
		    	<div class="col-lg-5 h_img1">
		    		<img class="pull-right" style="width:220px" src="/includes/img/logo/logo_ipn.png">
		    	</div>
	    		<div class="col-lg-1"></div>
	    	</div>
    	</div>
		<!--- <div>
			<img alt="" src="/includes/img/logo/IPN.png"/>
		</div> --->
	    <div align="center" style="margin-top:100px">
		     <img src="/includes/img/logo/LogoSII_medium.png" style="width:300px">
	    </div>
	    <div class="middle-box text-center loginscreen">
	        <div>
	            <br><br><br><br>
	            <!---><h3>Bienvenido al SII</h3>--->
	            <p class="bienvenida">Sistema Institucional de Información</p>
	            <input   type="text" name="user" class="form-control leyenda" value="ACCESO AL SISTEMA" disabled="true" >

	            <!---<p>ACCESO AL SISTEMA</p>--->
	            <cfoutput>
	            <form class="m-t" action="#event.buildLink('login.autenticacion')#" method="post">

	                #getPlugin("MessageBox").renderIt()#

	                <div class="form-group">
						<input type="text" name="user" class="form-control usuario" placeholder="Usuario">
	                </div>
	                <div class="form-group">
	                    <input type="password" name="password" class="form-control pass" placeholder="Contraseña">
	                </div>
	                <button type="submit" class="btn btn-primary block full-width m-b">Entrar</button>

	                <!-- <a href=""><small>Forgot password?</small></a>
	                <p class="text-muted text-center"><small>Do not have an account?</small></p>
	                <a class="btn btn-sm btn-white btn-block" href="register.html">Create an account</a> -->
	            </form>
	            </cfoutput>
	            <p class=" version"> <small>SII versión 2.1  2016</small> </p>
	        </div>
    	</div>
		<div align="center">
			<p class="direccion"> D.R. Instituto Politécnico Nacional (IPN), Av. Luis Enrique Erro S/N, Unidad Profesional Adolfo López Mateos, Zacatenco Delegación Gustavo A. Madero, C.P. 07738, Ciudad de México.</small> </p>
		</div>
	</div>
</body>

</html>
