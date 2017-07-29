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

<cfinclude template="editorReportes_js.cfm">
<cfoutput>
    <div class="row wrapper border-bottom white-bg page-heading" data-rep-id="#prc.reporte.getId()#" data-con-id="#prc.conjunto.getId()#">

        <div class="col-lg-10">
            <form  class="ed-nombre" data-toggle="tooltip" data-placement="right" title="Cambiar Nombre">
                <div class="form-group">
                    <input type="text" placeholder="#prc.reporte.getNombre()#" class="form-control">
                </div>
            </form>
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
        <div class="col-lg-2">
            <div id="botonesControl" class="btn-group">
                <button type="button" class="btn btn-outline click-dis btn-primary ">
                    <i class="fa fa-edit"></i>
                    Editar
                </button>
                <button type="button" class="btn  btn-primary">
                    Explorar
                    <i class="fa fa-compass"></i>
                </button>
            </div>

        </div>
    </div>
</cfoutput>

<div class="wrapper wrapper-content animated fadeInRight" >
<!---
    Seccion correspondiente al contenido del submodulo
--->
    <cfoutput>
        <div class="row">
                <div id="controles" class="col-lg-3">
                    <div class="ibox float-e-margins descripcion ">
                        <div class="ibox-title">
                            <h5>Descripción</h5>
                            <div class="ibox-tools">
                               <a class="collapse-link">
                                   <i class="fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>

                         <div class="ibox-content" >

                            <textarea  placeholder="#prc.reporte.getDescripcion()#" data-toggle="tooltip" data-placement="top" title="Cambiar Descripción"></textarea>
                            <div class="text-right" hidden>
                                <button id="modificar-desc" class="btn btn-default btn-outline" TYPE="button">Agregar</button>
                            </div>
                        </div>
                </div>


                <div class="ibox float-e-margins visualizaciones" >
                    <div class="ibox-title">
                        <h5>Visualizaciones</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                        </div>
                    </div>

                    <div class="ibox-content no-padding" >
                        <div id="rep-visualizaciones" class="list-group">
                          <cfloop array="#prc.visualizaciones#" index="vis">
                                <cfif vis.tieneDefinicion()>
                                     <a data-vis-id="#vis.getId()#" class="list-group-item ">
                                        <img src="#vis.getTipo().getIcono()#" class="icono-vis no-drag-img">
                                        #vis.getNombre()#
                                    </a>
                                </cfif>

                          </cfloop>
                        </div>
                    </div>
                </div>

                <div class="ibox float-e-margins objetos ">
                    <div class="ibox-title">
                        <h5>Objetos</h5>
                        <div class="ibox-tools">
                           <a class="collapse-link">
                               <i class="fa fa-chevron-up"></i>
                            </a>
                        </div>
                    </div>

                     <div class="ibox-content no-padding" >
                        <div class="list-group">
                            <a data-tipo-obj="texto" class="list-group-item ">
                                <i class="fa fa-font"></i>
                                Texto
                            </a>
                           <!--- <a data-tipo-obj="imagen" class="list-group-item">
                                <i class="fa fa-picture-o"></i>
                                Imagen
                            </a> --->
                        </div>
                    </div>
                </div>



            </div>
            <div id="contenido" class="col-lg-9">
                <div  class="reporte-canvas" >
                    <div class="reporte-title" >

                    </div>
                    <div class="reporte-content" data-num-elementos="1">


                    </div>
                </div>
            </div>




        </div>

        <ul id="tlyPageGuide" data-tourtitle="Como usar el editor de Visualizaciones">

          <li class="tlypageguide_right" data-tourtarget=".ed-nombre input">
            <div>
              Dar click en el título para comenzar su edición y una vez finalizada presionar ENTER(INTRO) para guardar la modificación.
            </div>
          </li>

          <li class="tlypageguide_right" data-tourtarget=".descripcion">
            <div>
              Dar click en el área de la descripción para editarla y una vez finalizada dar click en el botón de agregar para guardar la modificación.
            </div>
          </li>


          <li class="tlypageguide_right" data-tourtarget=".visualizaciones">
            <div>
                 Arrastrar una visualización para agregarla al reporte en el área seleccionada.
            </div>
          </li>

          <li class="tlypageguide_right" data-tourtarget=".objetos">
            <div>
                Arrastrar un objeto para agregarlo al reporte en el área seleccionada..
            </div>
          </li>


        </ul>




    </cfoutput>
</div>



