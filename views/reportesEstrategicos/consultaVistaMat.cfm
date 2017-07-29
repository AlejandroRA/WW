<cfprocessingdirective pageEncoding="utf-8"> 
<cfinclude template="consultaVistaMat_js.cfm">
<link href="/includes/css/plugins/iCheck/custom.css" rel="stylesheet">
<script src="/includes/bootstrap/bootstrap-toggle/bootstrap-toggle.min.js"></script>
<link href="/includes/bootstrap/bootstrap-toggle/bootstrap-toggle.min.css" rel="stylesheet">    
<script src="/includes/js/jquery-validation-1.14.0/jquery.validate.min.js"></script>
<script src="/includes/js/jquery-validation-1.14.0/additional-methods.min.js"></script>

<script src="/includes/bootstrap/bootstrap-table/bootstrap-table.min.js"></script>
<link href="/includes/bootstrap/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">   
<script src="/includes/bootstrap/bootstrap-table/extensions/export/bootstrap-table-export.js"></script>
<script src="/includes/bootstrap/bootstrap-table/extensions/accent-neutralise/bootstrap-table-accent-neutralise.js"></script>
<script src="/includes/js/tableExport/tableExport.js"></script>


<script src="/includes/bootstrap/bootstrap-table/locale/bootstrap-table-es-MX.js"></script>


<style>

.footerAcciones{
	position: fixed;
    bottom: 0px;  
    background-color:rgba(250,250,250,.8);
    width:100%;
    border-top:solid 2px #7f2554;
    padding:5px;
    z-index:100;
}
</style>

<!-- Select2 -->
<!--- <script src="/includes/js/select2/select2.full.min.js"></script> --->
<script src="/includes/js/select2/select2.js"></script>
<script src="/includes/js/select2/i18n/es.js"></script>
<!--- <link href="/includes/css/plugins/select2/select2.min.css" rel="stylesheet"> --->
<link href="/includes/css/plugins/select2/select2.css" rel="stylesheet">
<link href="/includes/css/reportesEstrategicos.css" rel="stylesheet">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <cfoutput>
        <!--- <cfif structCount(getPlugin('SessionStorage').getVar('conjunto')) GT 0> --->
        <cfif structKeyExists(Session.cbstorage.conjunto, "TITULO")>
            <h2> #Session.cbstorage.conjunto.TITULO# </h2>
        </cfif>
        <ol class="breadcrumb">
            <li>                
                <a href="#event.buildLink('inicio.index')#">Inicio</a>                
            </li>
            <li>                
                Reportes Estratégicos
            </li>
            <li class="active">
                <strong> #Session.cbstorage.conjunto.TITULO# </strong>
            </li>
        </ol>
        </cfoutput>
    </div>
    <div class="col-lg-2">
    </div>

</div>

<div class="wrapper wrapper-content animated fadeInRight">
    
    <div class="col-md-12 ">
        <ul class="nav navbar-top-links navbar-right abreporeEstrategico">
            <li>
                <span class="m-r-sm text-muted welcome-message">Reportes Estratégicos</span>
            </li>
            <li class="dropdown">
                <a class="dropdown-toggle count-info showreport">
                    <i class="fa fa-folder-open"></i>  
					<span class="label label-warning totalSR" id=""></span>
                </a>                
            </li>
        </ul>
    </div>

    <div class="row estrategico">    
        
        <div class="col-md-6  pull-left" id="leftPanel" >
			<div  class="panel panel-warning" id="leftPanelContent" >
				<div class="panel-heading hideFilter">
					<i class="fa fa-filter pull-right" title="Mostrar u ocultar Filtros" data-toggle="tooltip"></i>
					Configuración del Reporte
				</div>
		        <div class="panel-content" id="configPanelInformation" >
					<cfinclude template="filtros.cfm">
				</div>	
        	</div>
		</div>

        <div class="col-md-6 pull-right" id="rightPanel"> 
			<div class="row">       
	            <div class="ibox float-e-margins datos"> 
	                <div class="ibox-title">
	                    <h5>Reporte Generado</h5>
	                    <div class="ibox-tools">
	                        <a class="hideFilter">
	                            <i class="fa fa-filter" title="Cambiar tamaño" data-toggle="tooltip"></i>
	                        </a>
	                    </div>
	                </div>
		            <div class="ibox-content">
	                    <div class="table-responsive" id="contTable">
	                        <table  id="tab" data-locale="es-MX"></table>
	                        <div id="tabImg">
		                        
		                        <div class="panel panel-info"> 
									<div class="panel-heading"> 
										<i class="fa fa-info-circle"></i>
									</div>
									<div class="panel-body text-center">
										
			                        	<h4> Seleccione los parametros de la gráfica y a continuación de clic en el boton "Generar Reporte"
			                        	
										</h4>
									</div>
								</div>
		                        
		                        
		                        	<img alt="image" class="img-responsive" src="/includes/img/reportesEstrategicos/indicators.png" >
	                        </div>
	                    </div>
		            </div> 
		    	</div>
		    </div>
		    <div class="row">
       		    <div class="ibox float-e-margins "> 
		            <div class="ibox-title">
		                <h5>Gráfica</h5>
		            </div>
					<div class="ibox-content">
		                    <cfinclude template="grafica.cfm">
		                </div>
		            </div> 
		        </div>
       		</div>
        </div>            
    </div>
	
	<!--- footer de las acciones disponibles--->
	<div class="row">
		<div class="footerAcciones">
			
			<div class="col-sm-3">
			</div>
			
			<div class="col-sm-6">
				<button class=" col-sm-2 btn btn-primary btn-outline nextBtn dim btn-xs" id="graficar" title="Generar reporte" data-toggle="tooltip">
					<i  class="fa fa-table fa-2x"></i> <i  class="fa fa-bar-chart fa-2x"></i> 
				</button>
				<button class="col-sm-2  btn btn-warning btn-outline nextBtn dim btn-xs hideFilter" title="Mostrar u ocultar Filtros" data-toggle="tooltip">
					<i class="fa fa-filter fa-2x"></i>
				</button>
				<button class="col-sm-2 btn btn-success btn-outline nextBtn dim btn-xs save-sr" id="buttonConfig" title="Guardar Reporte" data-toggle="tooltip">
					<i class="fa fa-floppy-o fa-2x"></i>Nuevo
				</button>
				<button class="col-sm-2  btn btn-info nextBtn btn-outline dim btn-xs  count-info showreport" title="Mostrar Reportes Guardados" data-toggle="tooltip">
	                <i class="fa fa-folder-open fa-2x"></i>  
	                <span class="label label-warning totalSR" id=""></span>
	            </button>
	        </div>
			
			<div class="col-sm-3">
			</div>
			
		</div>
	</div> 
</div>
<!--- lista del componente de ayuda --->
<ul id="tlyPageGuide" data-tourtitle="Cómo crear un reporte estrátegico.">
    <li class="tlypageguide_top" data-tourtarget=".abreporeEstrategico">
        <div>
          Abre la vista de los reportes estrategicos previamente creados. 
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".parametroS">
        <div>
          Seleccionar las columnas que quieren verse refejadas en los ejes de la gráfica.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".tiempo">
        <div>
          Seleccionar los filtros correspondientes a la dimensión tiempo, para específicar el periodo de consulta. 
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".dependencia">
        <div>
          Seleccionar los filtros correspondientes a la dimensión unidad responsable, para específicar el nombre de alguna dependencia en caso de ser necesario.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".otros">
        <div>
          Seleccionar alguno de los filtros restantes, en caso de requerir una consulta muy específica.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".datos">
        <div>
            Analizar los datos que se obtuvieron de la consulta generada y que fueron considerados para crear la gráfica.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".grafica">
        <div>
          Seleccionar el tipo de gráfica que quiere visualizarse.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".config">
        <div>
          Modificar alguna de las configuraciones de la gráfica en caso de ser necesario.
        </div>
    </li>
</ul>

<!--- Modal (tabla de reportes) --->
<div class="modal inmodal fade" id="strategicreport" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg" style="width:70%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                <h4 class="modal-title">Reportes Estratégicos</h4>
               
            </div>
            <div class="modal-body">

                <div id="table-sr"></div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
				
            </div>
        </div>
    </div>
</div>

<!--- Modal (guardar/actualizar) --->
<div class="modal inmodal fade" id="saveConfirmation" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                <h4 class="modal-title title-save"></h4>
                <medium class="font-normal"></medium>
            </div>
            <div class="modal-body">
                <form id="formSave">
                    <div class="form-group">
                        <label>Descripción:</label>
                        <textarea class="form-control" name="desc_usr" placeholder="" data-toggle="tooltip" data-placement="top" title="" data-original-title="Cambiar descripción" ></textarea> 
                    </div>    
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary save-sr" id="buttonConfig2">Guardar</button>
            </div>
        </div>
    </div>
</div>

<!--- Modal (eliminar) --->
<div id="deleteConfirmation" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Eliminar reporte estratégico</h3>
            </div>
            <div class="modal-body">                
                <p class="deleteText"></p>                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <button type="button" class="btn btn-primary confirm-delete-sr">Sí</button>
            </div>
        </div>
    </div>
</div>

<div id="tmp" style="visibility:hidden"></div>
<div id="div_qr" style="display:none"></div>
