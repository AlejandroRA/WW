<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Adhoc
* Sub modulo: Editor de Visualizaciones
* Fecha 21 de agosto de 2015
* Descripcion:
* Vista correspondiente al submodulo del editor de visualizaciones
* Autor:Arturo Christian Santander Maya
* ================================
--->



<cfprocessingdirective pageEncoding="utf-8">
 <cfinclude template="editorVisualizaciones_js.cfm">

<!---
    Seccion correspondiente a la barra de navegacion del modulo
--->
<cfoutput>
<div class="row wrapper border-bottom white-bg page-heading" data-vis-id="#prc.visualizacion.getId()#" data-con-id="#prc.conjunto.getId()#">

    <div class="col-lg-10">
       <form  class="ed-nombre" data-toggle="tooltip" data-placement="right" title="Cambiar Nombre">
            <div class="form-group">
                <input type="text" placeholder="#prc.visualizacion.getNombre()#" class="form-control">
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
              <a href="#event.buildLink('reportesAdhoc.conjuntosDatos.cargarConjunto.idCon.#prc.conjunto.getId()#')#">
                #prc.conjunto.getNombre()#</a>
            </li>

            <li class="active">
               <strong>#prc.visualizacion.getNombre()#</strong>
            </li>

        </ol>
    </div>
    </cfoutput>



</div>

<div class="wrapper wrapper-content animated fadeInRight" >
<!---
    Seccion correspondiente al contenido del submodulo
--->
<cfoutput>
    <div class="row">
        <div class="col-lg-3">
            <div class="ibox dimension ">
                <div class="ibox-title">
                    <h5>Dimensiones</h5>
                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                    </div>
                </div>

                <div class="ibox-content no-padding" >
                    <div class="list-group">

                            <cfloop array="#prc.conjunto.getColumnas()#" index="columna" >
                                <cfif columna.getTipo() eq 'D'>
                                    <a data-col-id="#columna.getId()#" class="list-group-item ">
                                        #columna.getNombre()#
                                    </a>
                                </cfif>

                            </cfloop>

                    </div>
                </div>
            </div>

            <div class="ibox float-e-margins metrica ">
                <div class="ibox-title">
                    <h5>Métricas</h5>
                    <div class="ibox-tools">
                       <a class="collapse-link">
                           <i class="fa fa-chevron-up"></i>
                        </a>
                    </div>
                </div>

                 <div class="ibox-content no-padding" >
                    <div class="list-group">


                            <cfloop array="#prc.conjunto.getColumnas()#" index="columna" >
                                <cfif columna.getTipo() eq 'M'>
                                    <a data-col-id="#columna.getId()#" class="list-group-item ">
                                        #columna.getNombre()#
                                    </a>
                                </cfif>
                            </cfloop>

                    </div>
                </div>
            </div>

            <div class="ibox  visualizaciones">
                <div class="ibox-title">
                    <h5>Visualizaciones</h5>
                    <div class="ibox-tools">
                       <a class="collapse-link">
                           <i class="fa fa-chevron-up"></i>
                        </a>
                    </div>
                </div>

                <div class="ibox-content" >
                    <cfloop array="#prc.tiposVis#" index="tipoVis">
                        <img class="vis-tipo no-drag-img img-thumbnail fast-animated fadeIn " src="#tipoVis.getIcono()#" data-toggle="tooltip" data-placement="top" data-tipo-vis-id="#tipoVis.getId()#" title="#tipoVis.getNombre()#" data-max-col="#tipoVis.getMaxCol()#" data-min-col="#tipoVis.getMinCol()#" data-max-fil="#tipoVis.getMaxFil()#" data-min-fil="#tipoVis.getMinFil()#">
                       <div class="fast-animated fadeInDown">
                            <div>
                                <b>#tipoVis.getNombre()#</b>
                                <div class="ibox-tools">
                                    <a class="cerrar-desc"><i class='fa fa-times '></i></a>
                                </div>
                            </div>
                            <div>
                                #tipoVis.getDescripcion()#
                                <br>
                                <span class="label label-primary">#tipoVis.getMaxCol()# Columna(s)</span>
                                <span class="label label-info">#tipoVis.getMaxFil()# Fila(s)</span>
                            </div>
                        </div>
                    </cfloop>


                </div>
            </div>
            <div class="ibox configuraciones">
                <div class="ibox-title">
                    <h5>Configuración</h5>
                    <div class="ibox-tools">
                       <a class="collapse-link">
                           <i class="fa fa-chevron-up"></i>
                        </a>
                    </div>
                </div>

                <div class="ibox-content" >
                    <cfloop array="#prc.visualizacion.getPropiedades()#" index="propiedad">

                        <cfif propiedad.getEditable() eq 1>
                            <img class="propiedad-ico no-drag-img img-thumbnail animated fadeIn " src="#propiedad.getIcono()#" data-toggle="tooltip" data-prop-id="#propiedad.getId()#" data-placement="top"  title="#propiedad.getNombre()#">

                        </cfif>

                    </cfloop>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div  class="chart-canvas" >
                <div class="chart-title click-dis text-right" >

                            <cfset tipoVis=prc.visualizacion.getTipo()>
                                 <img class="vis-tipo no-drag-img img-thumbnail" src="#tipoVis.getIcono()#"   data-tipo-vis-id="#tipoVis.getId()#"
                                data-max-col="#tipoVis.getMaxCol()#" data-min-col="#tipoVis.getMinCol()#" data-max-fil="#tipoVis.getMaxFil()#" data-min-fil="#tipoVis.getMinFil()#">

                </div>
                <div class="chart-cont" id="chartCont"></div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="ibox columnas">
                <div class="ibox-title">
                    <h5>Columnas</h5>
                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                    </div>
                </div>

                <div class="ibox-content " >
                    <div class="btn-toolbar">
                        <cfset columnasOrd=prc.visualizacion.obtenerColumnasOrdPorAgr() >
                        <cfloop array="#columnasOrd#" index="columna">

                            <cfif columna.getTipo() eq "D" and not arrayIsEmpty(columna.getAgregaciones()) >

                                <div  data-col-id='#columna.getId()#' data-col-nombre='#columna.getNombre()#' data-agr-idagrcolvis='#columna.getAgregaciones()[1].getIdAgrColVis()#'class='btn-group fast-animated fadeInLeft' >
                                    <span class='btn btn-primary btn-outline dropdown-toggle nombre-col'  >
                                        #columna.getNombre()#
                                    </span>
                                    <span class=' btn btn-primary btn-outline close-param '>
                                        <i class='fa fa-times '></i>
                                    </span>
                                </div>

                            </cfif>
                        </cfloop>
                    </div>
                </div>
            </div>

            <div class="ibox filas">
                <div class="ibox-title">
                    <h5>Filas</h5>
                    <div class="ibox-tools">
                       <a class="collapse-link">
                           <i class="fa fa-chevron-up"></i>
                        </a>
                    </div>
                </div>

                <div class="ibox-content" >
                    <div class="btn-toolbar">

                        <cfloop array="#prc.visualizacion.getColumnas()#" index="columna">
                            <cfif columna.getTipo() eq "M">
                                <cfloop array="#columna.getAgregaciones()#" index="agregacion">
                                    <div  data-col-id='#columna.getId()#' data-col-nombre='#columna.getNombre()#' data-agr-idagrcolvis='#columna.getAgregaciones()[1].getIdAgrColVis()#' class='btn-group fast-animated fadeInLeft'>
                                        <span class='btn btn-info btn-outline dropdown-toggle nombre-col' data-toggle='dropdown' >
                                            #agregacion.getRepresentacion()# (#columna.getNombre()#)
                                        </span>
                                        <span class=' btn btn-info btn-outline close-param '>
                                            <i class='fa fa-times '></i>
                                        </span>
                                        <ul class='dropdown-menu dropdown-menu-left'  role='menu'>
                                            <li class='dropdown-header'>Agregaciones</li>
                                            <li class='divider'></li>
                                            <cfloop array="#prc.conjunto.obtenerColumnaPorId(columna.getId()).getAgregaciones()#" index="agr">
                                                <cfif agr.getId() eq agregacion.getId()>
                                                    <li class='agr disabled'><a data-agr-id="#agr.getId()#">#agr.getRepresentacion()#</a></li>
                                                <cfelse>
                                                    <li class='agr'><a data-agr-id="#agr.getId()#">#agr.getRepresentacion()#</a></li>
                                                </cfif>

                                            </cfloop>
                                        </ul>
                                    </div>
                                </cfloop>
                            </cfif>
                        </cfloop>

                    </div>
                </div>
            </div>

            <div class="ibox filtros">
                <div class="ibox-title">
                    <h5>Filtros</h5>
                    <div class="ibox-tools">
                        <a>
                            <i class="fa fa-plus" data-toggle="modal" data-target="##filtrosModal"></i>
                        </a>
                        <a class="collapse-link">
                           <i class="fa fa-chevron-up"></i>
                        </a>

                    </div>
                </div>

                <div class="ibox-content" >
                     <div class="btn-toolbar">

                        <cfloop array="#prc.visualizacion.getColumnas()#" index="columna">
                            <cfif columna.getTipo() eq "D" and not arrayIsEmpty(columna.getFiltros())>
                                <cfloop array="#columna.getFiltros()#" index="filtro">
                                    <div  data-col-id='#columna.getId()#' data-col-nombre='#columna.getNombre()#' data-filt-idfiltcolvis='#filtro.getIdFiltColVis()#' class='btn-group fast-animated fadeInLeft'>
                                            <span class='btn btn-warning btn-outline dropdown-toggle nombre-col'  >
                                               #columna.getNombre()# #filtro.getRepresentacion()# #filtro.getValor()#
                                            </span>
                                            <span class=' btn btn-warning btn-outline close-param '>
                                                <i class='fa fa-times '></i>
                                            </span>
                                    </div>
                                </cfloop>
                            </cfif>
                        </cfloop>

                    </div>
                </div>
            </div>
            <div class="ibox descripcion ">
                <div class="ibox-title">
                    <h5>Descripción</h5>
                    <div class="ibox-tools">
                       <a class="collapse-link">
                           <i class="fa fa-chevron-up"></i>
                        </a>
                    </div>
                </div>

                <div class="ibox-content" >


                        <textarea rows="4" cols="50" placeholder="#prc.visualizacion.getDescripcion()#"  data-toggle="tooltip" data-placement="top" title="Cambiar Descripción"></textarea>
                        <div class="text-right" hidden>
                            <button id="modificar-desc" class="btn btn-default btn-outline" TYPE="button">Agregar</button>
                        </div>

                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div id="filtrosModal" class="modal fade" role="dialog">
          <div class="modal-dialog">


            <div class="modal-content">
               <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Filtros</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="btn-toolbar">
                            <div id="comboColumnas" class="btn-group animated fadeInUp ">
                                <button id="nombre-col"type="button" class="btn btn-primary nombre-combo btn-outline">Columnas</button>
                                <button type="button" class="btn btn-primary btn-outline dropdown-toggle" data-toggle="dropdown">
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu menu-combo-filtro" role="menu">
                                    <cfloop array="#prc.conjunto.getColumnas()#" index="columna" >
                                        <cfif columna.getTipo() eq 'D'>
                                            <li>
                                                <a data-col-id="#columna.getId()#" >
                                                    #columna.getNombre()#
                                                </a>
                                            </li>
                                        </cfif>
                                    </cfloop>
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button id="agregarFiltro" type="button" class="btn btn-default btn-outline" >Agregar</button>
                </div>
            </div>

          </div>
        </div>

    </div>


    <div class="row">
        <div id="configuracionesModal" class="modal fade" role="dialog">
          <div class="modal-dialog">


            <div class="modal-content">
               <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="propiedades" data-prop-id="" data-prop-val="">

                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button id="modificarConfig" type="button" class="btn btn-default btn-outline" >Aceptar</button>
                </div>
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


      <li class="tlypageguide_right" data-tourtarget=".dimension">
        <div>
          Arrastrar una o más dimensiones para agregarlas como columnas en la visualización.
        </div>
      </li>

       <li class="tlypageguide_right" data-tourtarget=".metrica">
        <div>
             Arrastrar una o más metricas para agregarlas como filas en la visualización.
        </div>
      </li>

      <li class="tlypageguide_right" data-tourtarget=".visualizaciones">
        <div>
             Arrastrar una visualización para cambiar el tipo activo o dar click para ver su descripción y el número de columnas y filas máximo para ese tipo.
        </div>
      </li>

      <li class="tlypageguide_right" data-tourtarget=".configuraciones">
        <div>
            Dar click para modificar la opción de configuración seleccionada.
        </div>
      </li>

      <li class="tlypageguide_left" data-tourtarget=".columnas">
        <div>
            Dar click en la X de  una de las columnas agregadas para eliminarla de la visualización.
        </div>
      </li>

      <li class="tlypageguide_left" data-tourtarget=".filas">
        <div>
            Dar click en la X de  una de las filas agregadas para eliminarla de la visualización o dar click en el nombre para cambiar el tipo de agregación de la fila.
        </div>
      </li>


       <li class="tlypageguide_left" data-tourtarget=".filtros">
        <div>
            Dar click en el simbolo de + para agregar un nuevo filtro o dar click en la X de uno de los filtros agregados para eliminarlo de la visualización .
        </div>
      </li>

      <li class="tlypageguide_left" data-tourtarget=".descripcion">
        <div>
          Dar click en el área de la descripción para editarla y una vez finalizada dar click en el botón de agregar para guardar la modificación.
        </div>
      </li>



    </ul>




  </cfoutput>

</div>

