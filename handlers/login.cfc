<!---
* =========================================================================
* IPN - CSII
* Sistema: SII
* Modulo: Principal
* Sub modulo: Login
* Fecha: Junio 18, 2015
* Descripcion: Handler para la autenticacion del usuario
* =========================================================================
--->

<cfcomponent>	
	<!---
	* Fecha creacion: Junio 18, 2015
	* @author Yareli Andrade
	--->
	<cffunction name="autenticacion" access="public" returntype="void" output="false" hint="Valida los datos de acceso del usuario">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();			
			if ( NOT Len(rc.user) OR NOT Len(rc.password) ){
				getPlugin("MessageBox").setMessage("error2","Favor de llenar los campos de usuario y contrase&ntilde;a.");
				setNextEvent("main.index");
			} 
			else {
				var cnLogin = getModel("login.CN_Login");
				var usuario = cnLogin.validarUsuario(rc.user, rc.password);
				if ( usuario.validado EQ 1 ){					
					urlPaginaInicial = event.buildLink('inicio.index');					
					getPlugin("SessionStorage").setVar("usuario", usuario);
					getPlugin("SessionStorage").setVar("urlPaginaInicial", urlPaginaInicial);
					setNextEvent("inicio.index");
				} 
				else { 
					getPlugin("MessageBox").setMessage("error2","Nombre de usuario o contrase&ntilde;a incorrectos.");
					setNextEvent("main.index");
				}
			}
		</cfscript>
	</cffunction>

	<!---
	* Fecha creacion: Junio 18, 2015
	* @author: Yareli Andrade
	--->
	<cffunction name="cerrarSesion" access="public" returntype="void" output="false" hint="Validación del usuario">
		<cfargument name="Event" type="any">
		<cfscript>
			getPlugin("SessionStorage").clearAll();
			setNextEvent("main.index");
		</cfscript>	
	</cffunction>	

</cfcomponent>