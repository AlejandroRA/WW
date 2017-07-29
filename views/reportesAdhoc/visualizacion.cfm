<cfprocessingdirective pageEncoding="utf-8"> 
<cfoutput>

    <div class="col-md-3 animated fadeInDown" >
        <div class="ibox" data-vis-id="#prc.visualizacion.getId()#">
            <div class="ibox-content el-contenido">
                <div class="el-vista-previa">
                    <cfif fileExists(expandPath(prc.visualizacion.getVistaPrevia()))>
                        <img src="#prc.visualizacion.getVistaPrevia()#" >
                    <cfelse>
                        <img src="/includes/img/reportesAdhoc/vistasVis/default2.png" height="200" width="200">   
                    </cfif>
                </div>
                <span class="el-eliminar">
                    <i class="glyphicon glyphicon-remove"></i>
                </span>
                <span class="el-copiar-vis">
                    <i class="fa fa-copy"></i>
                </span>
                <div class="el-descripcion">
                               
                    <div  class="el-nombre">
                        #prc.visualizacion.getNombre()#
                    </div>
                    <div class="el-cont-desc small m-t-xs">
                        #prc.visualizacion.getDescripcion()#
                    </div>
                    <div class="m-t text-right">
                                   
                        <a  class="btn btn-md btn-outline btn-primary" href="#event.buildLink('reportesAdhoc.administradorElementos.editarVisualizacion.idVis.#prc.visualizacion.getId()#.idCon.#prc.visualizacion.getConjunto()#')#">
                            Editar
                        </a>

                    </div>
                </div>
            </div>
        </div>
    </div>   
</cfoutput>                