<!---
* =========================================================================
* IPN - CSII
* Sistema: SII
* Modulo: Principal
* Sub modulo: 
* Fecha: Junio 17, 2015
* Descripcion: Handler para mostrar el menu principal 
* =========================================================================
--->

<cfcomponent>	
	<!---
	* Fecha creacion: Junio 17, 2015
	* @author Yareli Andrade
	--->
	<cffunction name="index" access="public" returntype="void" output="false" hint="Redirecciona a la vista principal del sistema">
		<cfargument name="event" type="any">
		<cfscript>			
			var cn	= getModel("usuario.CN_Menu");
			var rol	= Session.cbstorage.usuario.ROL;			
			var niveles = cn.getMenu(rol);
			getPlugin("SessionStorage").setVar("menu", niveles);
			var rolDesc = cn.getRol(Session.cbstorage.usuario.PK);
			getPlugin("SessionStorage").setVar("rol", rolDesc);
			event.setView("index");
		</cfscript>
	</cffunction>

</cfcomponent>

