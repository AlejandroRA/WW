<cfprocessingdirective pageEncoding="utf-8"> 
<cfoutput>
    <div class="col-md-3 animated fadeInDown">
        <div class="ibox" data-rep-id="#prc.reporte.getId()#">
            <div class="ibox-content el-contenido">
                <div class="el-vista-previa">
                      <img src="/includes/img/reportesAdhoc/vistasVis/reportesPh.png">
                </div>
                <span class="el-eliminar">
                    <i class="glyphicon glyphicon-remove"></i>
                </span>

                <span class="el-publicar">
                    <i class="glyphicon glyphicon-cloud-upload"></i>
                </span>
                <span class="el-copiar-rep">
                    <i class="fa fa-copy"></i>
                </span>
                <div class="el-descripcion">
                               
                    <div class="el-nombre">#prc.reporte.getNombre()#</div>
                    <div class="el-cont-desc small m-t-xs">
                        #prc.reporte.getDescripcion()#
                    </div>
                    <div class="m-t text-right">
                        <a  class="btn btn-md btn-outline btn-primary" href="#event.buildLink('reportesAdhoc.administradorElementos.explorarReporte.idRep.#prc.reporte.getId()#.idCon.#prc.reporte.getConjunto()#')#">
                            Explorar
                        </a>
                        <a  class="btn btn-md btn-outline btn-info" href="#event.buildLink('reportesAdhoc.administradorElementos.editarReporte.idRep.#prc.reporte.getId()#.idCon.#prc.reporte.getConjunto()#')#">
                            Editar
                        </a>

                    </div>
                </div>
            </div>
        </div>
    </div>
</cfoutput>