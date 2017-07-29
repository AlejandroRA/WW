<cfcomponent output="false" singleton>

	<!--- Default Action --->
	<cffunction name="index" returntype="void" output="false" hint="Evento que se ejecuta por default al iniciar la aplicacion">
		<cfargument name="event">
		<cfset event.setView("login").noLayout()>
	</cffunction> 

<!------------------------------------------- GLOBAL IMPLICIT EVENTS ONLY ------------------------------------------>
<!--- In order for these events to fire, you must declare them in the ColdBox.cfc --->
		
	<cffunction name="onAppInit" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		
	</cffunction>

	<cffunction name="onRequestStart" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			if((NOT isDefined("Session.cbstorage") OR isDefined("Session.cbstorage") 
					AND StructIsEmpty(Session.cbstorage))
				AND (rc.event NEQ "main.index" AND rc.event NEQ "login.autenticacion")){
					location(url="/main/index");
					//setNextEvent("main.index","");				
			}			
		</cfscript>
	</cffunction>

	<cffunction name="onRequestEnd" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
	</cffunction>
	
	<cffunction name="onSessionStart" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		
	</cffunction>
	
	<cffunction name="onSessionEnd" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		
		<cfset var sessionScope = event.getValue("sessionReference")>
		<cfset var applicationScope = event.getValue("applicationReference")>
		
	</cffunction>

	<cffunction name="onException" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		
		<cfscript>
			//Grab Exception From request collection, placed by ColdBox
			var exceptionBean = event.getValue("ExceptionBean");
			//Place exception handler below:

		</cfscript>
	</cffunction>
	
	<cffunction name="onMissingTemplate" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			//Grab missingTemplate From request collection, placed by ColdBox
			var missingTemplate = event.getValue("missingTemplate");
			
		</cfscript>
	</cffunction>

</cfcomponent>