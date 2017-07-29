<cfprocessingdirective pageEncoding="utf-8">
<cfoutput>
	<table class="table ">
        <thead>
        	<th>
	    		Nombre
	    	</th>
	    	<cfif prc.email>
        	<th>
	    		Email
	    	</th>
	    	</cfif>
	    	<th>
	    		Compartir
	    	</th>
        </thead>
        <tbody>
    	    <cfloop array="#prc.usuarios#" index="usr">
		        <tr data-id-usr="#usr.getId()#" data-email-usr="#usr.getemail()#">
		    	    <td>
		                #usr.getNombre()#
		            </td>
		            <cfif prc.email>
		            <td>
		                #usr.getemail()#
		            </td>
		            </cfif>
		            <td>
		            	<cfif usr.getPropietario() eq 1>
		            		<input type="checkbox" name="#'usr_'&usr.getId()#" checked>
		            	<cfelse>
		            		<input type="checkbox" name="#'usr_'&usr.getId()#" >
		            	</cfif>
		            </td>

		        </tr>
	        </cfloop>
	    </tbody>
	</table>

</cfoutput>