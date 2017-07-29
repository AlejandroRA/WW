<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Adhoc
* Sub modulo: Editor de Reportes
* Fecha 14 de Septiembre  de 2015
* Descripcion:
* Vista  para el submodulo de edicion de reportes
* Autor:Arturo Christian Santander Maya
* ================================
--->


<cfprocessingdirective pageEncoding="utf-8">


<style>


#overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: #fff;
    filter:alpha(opacity=50);
    -moz-opacity:1;
    -khtml-opacity: 1;
    opacity: 1;
    z-index: 10000;
}
</style>


<cfinclude template="exploradorReportes_js.cfm">
<cfoutput>
    <div class="row wrapper border-bottom white-bg page-heading" data-rep-id="#prc.reporte.getId()#" data-con-id="#prc.conjunto.getId()#">

        <div class="col-lg-10">
            <h2>#prc.reporte.getNombre()#</h2>
            <ol class="breadcrumb">
                <li>
                    <a href="/index.cfm">Inicio</a>
                </li>

                <li>
                    <a>Reportes Personalizables</a>
                </li>

                <li >
                    <a href="#event.buildLink('reportesAdhoc/conjuntosDatos/index')#">Conjuntos de Datos</a>
                </li>

                <li>
                  <a href="#event.buildLink('reportesAdhoc.conjuntosDatos.cargarConjunto.idCon.#prc.reporte.getConjunto()#')#">
                    #prc.conjunto.getNombre()#
                    </a>
                </li>

                <li class="active">
                  <strong>#prc.reporte.getNombre()#</strong>
                </li>

            </ol>

        </div>
		<div style="float:rigth">
        	<button id="btn-pdf" type="button" class="btn  btn-primary" style="visibility:hidden" Onclick="crepdf(false)">
                   PDF
                    <i class="fa fa-file-pdf-o"></i>
                </button>
        	<button id="btn-email" type="button" class="btn  btn-primary" style="visibility:hidden" Onclick="email()">
                   E-Mail
                    <i class="fa fa-envelope"></i>
            </button>
        	<button id="btn-export" type="button" class="btn  btn-primary" Onclick="exportar()">
                   Exportar
                    <i class="fa fa-clipboard"></i>
            </button>
		</div>
    </div>
</cfoutput>

<div class="wrapper wrapper-content animated fadeInRight" >
<!---
    Seccion correspondiente al contenido del submodulo
--->
    <cfoutput>
        <div class="row">

            <div id="contenido" class="col-lg-12">
                <div  class="reporte-canvas" >
                    <div class="reporte-title" >

                    </div><div class="ocultando"></div>
                    <div class="reporte-content" data-num-elementos="1">
                    </div>
                </div>
            </div>
        </div>
<div class="row">
   <div id="listaUsuarios" class="modal fade" role="dialog">
     <div class="modal-dialog">


       <div class="modal-content">
          <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal">&times;</button>
               <h4 class="modal-title">Usuarios autorizados</h4>
           </div>
           <div class="modal-body">


           </div>
           <div class="modal-footer">
               <button id="btnCompartir" type="button" class="btn btn-default btn-outline" >Aceptar</button>
           </div>
       </div>

     </div>
   </div>
</div>

<div id="Div_qr" style="visibility:hidden" ></div>
    </cfoutput>
</div>
