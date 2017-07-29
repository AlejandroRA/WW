<cfprocessingdirective pageEncoding="utf-8">

<div class="panel panel-info"> 
	<div class="panel-heading"> 
		<i class="fa fa-info-circle"></i> Seleccione alguno de los reportes previamente diseñados.
	</div>
	<div class="panel-body text-center">
		
		<medium > Es posible visualizar, editar o eliminar.</medium>
	</div>
</div>

<table id="tablaReportes" class="table table-striped table-responsive" data-pagination="true" data-page-size="5" data-search="true" data-unique-id="id">
    <thead>
        <tr>
            <th class="text-center" data-field="id">#</th>
            <th class="text-center col-xs-1" data-field="tipo" data-sortable="true">Tipo</th>
            <th class="text-left col-xs-4" data-field="desc" data-sortable="true">Nombre</th>
            <th class="text-left col-xs-4" data-field="nombre" data-sortable="true">Descripcion</th>
            <th class="text-center col-xs-1" data-field="fecha" data-sortable="true">Fecha de última <br> modificación</th>
            <th class="text-center col-xs-2" data-field="accion" data-formatter="actionFormatter" data-events="actionEvents">Acciones</th>
        </tr>

    </thead>
</table>

<script>

    <!---
        * Descripcion: LLenar tabla de reportes estratégicos
        * Fecha:       02 de febrero de 2016
        * @author      Yareli Andrade
    --->
    var data = [];
    <cfif isDefined('prc.reporte.recordCount')>
        <cfloop index='i' from='1' to='#prc.reporte.recordCount#'>
            <cfoutput>
                data.push({
                    id: "#i#",
                    tipo: "<img class='report-graph' src='/includes/img/reportesEstrategicos/iconos/#prc.reporte.TIPO[i]#.png' alt='' id='#prc.reporte.NUM[i]#'>",
                    nombre: "#prc.reporte.NOMBRE[i]#",
                    desc: "#prc.reporte.DESCRIPCION[i]#",
                    fecha: "#prc.reporte.FECHA_MOD[i]#"                    
                });
            </cfoutput>
        </cfloop>
    </cfif>
    
    function actionFormatter(value, row, index) {
        return [
            '<button class="btn btn-info btn-xs view-sr" data-tooltip="tooltip" title="Ver"><span class="glyphicon glyphicon-search"></span></button>', 
            '<button class="btn btn-warning btn-xs edit-sr ml5" data-tooltip="tooltip" title="Editar"><span class="glyphicon glyphicon-pencil"></span></button>', 
            '<button class="btn btn-danger btn-xs delete-sr ml5" data-toggle="modal" href="#deleteConfirmation" data-tooltip="tooltip" title="Eliminar"><span class="glyphicon glyphicon-trash"></span></button>'
        ].join('');
    }

    $(document).ready(function() {    

        $('#tablaReportes').bootstrapTable(); 
        $('#tablaReportes').bootstrapTable('hideColumn', 'id');
        $('#tablaReportes').bootstrapTable('load', data);
        $('body').tooltip({
            selector: '[data-tooltip=tooltip]'
        });

    });

</script>