<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Adhoc
* Sub modulo:  Editor de Visualizaciones
* Fecha :24 de agosto de 2015
* Descripcion: 
* Script correspondiente a la funcionalidad de la vista del editor de visualizaciones
* Autor:Arturo Christian Santander Maya 
* ================================
--->
<cfprocessingdirective pageEncoding="utf-8"> 
<cfoutput>
  <script type="text/javascript">
    
    $( document ).ready(function() { 

        $('[data-toggle="tooltip"]').tooltip();
        $('.pageguide').show();
        
        tl.pg.init({
            "custom_open_button": "##showpageguide",
            "auto_refresh": true ,
            "default_zindex":999        
        });        

       toastr.options = {
                "closeButton": true,
                "debug": false,
                "progressBar": true,
                "preventDuplicates": false,
                "newestOnTop": true,
                "positionClass": "toast-bottom-right",
                "onclick": null,
                "showDuration": "400",
                "hideDuration": "1000",
                "timeOut": "4000",
                "extendedTimeOut": "2000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
              };
      <!---
         *Fecha :24 de agosto de 2015
         *Descripcion: Agrega a la representacion de las visualizaciones la propiedad de ser arrastradas.
         * @author Arturo Christian Santander Maya 
      --->
         
  
    	$(".ibox-content img.vis-tipo").draggable({
          revert: "invalid", 
          containment: ".wrapper-content",
          cursor: "move",
         
          zIndex:200,
          helper:function(event,ui){
               var element=$("<div style='background:none'></div>");
              
               return element.append($(this).clone());
            }
      
      });

      <!---
         *Fecha :24 de agosto de 2015
         *Descripcion: Agrega a la representacion de las dimensiones y las metricas la propiedad de ser arrastradas.
         * @author Arturo Christian Santander Maya 
      --->
        
   
      $( ".dimension .ibox-content a, .metrica .ibox-content a" ).draggable({
            revert: "invalid", 
            containment: ".wrapper-content",
            cursor: "move",
      
            zIndex:200,
            helper:function(event,ui){
               var element=$("<div></div>");
        
               return element.append($(this).html());
            }
        });
 
      <!---
         *Fecha :24 de agosto de 2015
         *Descripcion: Permite que los elementos arrastrados puedan ser depositados en el contenedor de las graficas y de acuerdo al tipo al que pertenezcan realiza la funcion correspondiente.
         * @author Arturo Christian Santander Maya 
      --->
        

    	$(".chart-canvas").droppable({
          accept: " .list-group > a, .ibox-content > img ",
          activeClass: "canvas-highlight",

          drop: function( event, ui ) {
            if(ui.draggable.parents(".dimension").length){
              agregarColumna(ui.draggable);
            }
            else{
              if(ui.draggable.parents(".metrica").length){
                agregarFila(ui.draggable);
              }
              else{
                  agregarTipoVis(ui.draggable);
              }
            }
          }
      });

     
      cargarVisualizacion();
    
     <!---
        *Fecha :25 de agosto de 2015
         *Descripcion: Agrega la funcionalidad para el evento "click" del elemento encargado de remover una columna o fila de una visualizacion
         * @author Arturo Christian Santander Maya 

      --->

     $(".ibox-content .btn-toolbar").on("click", ".close-param",function(){
        removerElemento($(this));
      });
      <!---
        *Fecha :25 de agosto de 2015
         *Descripcion: Agrega la funcionalidad para el evento "click" del elemento encargado de asignar un tipo de agregacion a una columna o una fila
         * @author Arturo Christian Santander Maya 
        
      --->
     
      $(".ibox-content .btn-toolbar").on("click", ".agr ",function(){
      
        if(!$(this).hasClass("disabled")){
          var elemento=$(this);
          var padre=$(this).parents(".btn-group").first()
          $.post('#event.buildLink("reportesAdhoc.editorVisualizaciones.modificarAgrCol")#', 
            {idCon:$("[data-con-id]").attr("data-con-id") ,idVis:$("[data-vis-id]").attr("data-vis-id"),idAgrColVis:padre.attr("data-agr-idagrcolvis"),idAgr:elemento.children("a").attr("data-agr-id"),idCol:padre.attr("data-col-id")},
            function(data){
              if(data===true){
                toastr.success('Modificada Exitosamente','Agregación');
                var elementoNombre=elemento.parent().siblings(".nombre-col");
                var nombre=padre.attr("data-col-nombre");
                var exp=elemento.text();
                elementoNombre.html(exp+"("+nombre+")"); 
                elemento.siblings().removeClass("disabled");
                elemento.addClass("disabled");
              }
            }  
          ).done( 
            function(){
              if(validarTipoVis()){
                    dibujarVisualizacion();
              }
            });  



            
        }
      


      });
     
     <!---
        *Fecha : 26 de agosto de 2015
         *Descripcion: Agrega la funcionalidad para el evento "click" del icono de cada tipo de visualizacion y que presenta la descripcion de dicho tipo.
         * @author Arturo Christian Santander Maya 
        
      --->


      $(".vis-tipo").click(function(){
        var otrosElementos=$(this).siblings("img");
        var elementoSel=$(this); 

        $(".visualizaciones img").switchClass("fadeIn","fadeOut");

        otrosElementos.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
          function(e) {
            elementoSel.nextUntil("img").off('webkitAnimationEnd oanimationend msAnimationEnd animationend');
            elementoSel.switchClass("fadeOut","fadeIn click-dis");
            otrosElementos.hide();
            elementoSel.nextUntil("img").switchClass("fadeOutUp","fadeInDown");
            elementoSel.nextUntil("img").css("display", "inline-block");
           
          });
       
      });

      <!---
        *Fecha : 26 de agosto de 2015
         *Descripcion: Agrega la funcionalidad para el evento "click" del elemento que cierra la descripcion de un tipo de visualizacion.
         * @author Arturo Christian Santander Maya 
        
      --->

      $(".cerrar-desc").click(function(){

           var elNombre=$(this).closest(".fast-animated");
           var elIco=elNombre.prev();
          
           elNombre.switchClass("fadeInDown","fadeOutUp");
           elIco.switchClass("fadeIn","fadeOut");
           elIco.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
              function(e) {
                elIco.siblings("img").off('webkitAnimationEnd oanimationend msAnimationEnd animationend');
                $(".visualizaciones img").switchClass("fadeOut click-dis","fadeIn");
                elIco.siblings("img").show();
                
                elNombre.hide();
              });
      });


      
      $(".ed-nombre").submit(function(event){
      
        event.preventDefault();
        var nombreNuevo=$(".ed-nombre input").val();
        $.post('#event.buildLink("reportesAdhoc.editorVisualizaciones.cambiarNombreVis")#', 
            {idCon:$("[data-con-id]").attr("data-con-id"),idVis:$("[data-vis-id]").attr("data-vis-id"),nombreNuevo:nombreNuevo},
            function(data){
                if(data===true){
                  toastr.success('Modificado Exitosamente','Nombre');
                  var campoNombre= $(".ed-nombre input");
                  var nombreRuta=$(".breadcrumb .active strong")
                  campoNombre.blur();
                  campoNombre.attr("placeholder",nombreNuevo);
                  campoNombre.val("");
                  nombreRuta.html(nombreNuevo);
                  nombreRuta.addClass("animated fadeInDown");
                  nombreRuta.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
                        function(e) {
                            nombreRuta.removeClass("animated fadeInDown");
                        }
                  );
                }
                
                
                
            }
        );
      });
       
      



      $("##modificar-desc").focus(function(event){
        event.preventDefault();
        var el=$(this);
        var descNueva=el.parent().siblings("textarea").val();
        if(descNueva.length===0){
          return;
        }

        $.post('#event.buildLink("reportesAdhoc.editorVisualizaciones.cambiarDescVis")#', 
            {idCon:$("[data-con-id]").attr("data-con-id"),idVis:$("[data-vis-id]").attr("data-vis-id"),descNueva:descNueva},
            function(data){
                if(data===true){
                  toastr.success('Modificada Exitosamente','Descripción');
                  var campoDesc= el.parent().siblings("textarea");
                  
               
                  campoDesc.attr("placeholder",descNueva);
                  campoDesc.val("");
                  campoDesc.blur();
              
                }
            }
        );
      });
    
      $(".descripcion textarea").blur(function(){
          setTimeout(function(){                       
            $("##modificar-desc").parent().attr("hidden","true");
          },10);
      });

      $(".descripcion textarea").focus(function(){
        
        $(this).siblings().removeAttr("hidden");

      });

    


      $(".modal-body ##comboColumnas li a").click(function(event){
        var contenedor= $(this).closest(".btn-toolbar");
        var comboPadre=$(this).closest(".btn-group").first();
        var elemento=$(this);

        actualizarComboSeleccion(comboPadre,elemento,"data-col-id");
       
        $.post('#event.buildLink("reportesAdhoc.editorVisualizaciones.obtenerFiltrosColumna")#', 
            { idCol:$(this).attr("data-col-id") , idCon:$("[data-con-id]").attr("data-con-id")},
            function(data){
                 
                  if(comboPadre.siblings().length){
                     comboPadre.siblings().remove(); 
                  }

                  var comboFiltros=$('<div id="filtrosCol" class="btn-group animated fadeInUp "><button type="button" class="btn nombre-combo btn-success btn-outline">Filtros</button><button type="button" class="btn btn-success btn-outline dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button><ul class="dropdown-menu menu-combo-filtro" role="menu"></ul></div>');
                  var lista=comboFiltros.find("ul");
                  for ( var i=0; i<data["filtros"].length ;i++ ){
                      var elementoList=$('<li ><a data-flt-id="'+data["filtros"][i]["id"]+'">'+data["filtros"][i]["representacion"]+'</a></li>');
                      lista.append(elementoList);
                  }
                   
                 contenedor.append(comboFiltros);

                  var comboValores=$('<div id="valoresCol" class="btn-group animated fadeInUp "><button type="button" class="btn nombre-combo btn-primary btn-outline">Valores</button><button type="button" class="btn btn-primary btn-outline dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button><ul class="dropdown-menu menu-combo-filtro" role="menu"></ul></div>');
                  var lista=comboValores.find("ul");
                  for ( var i=0; i<data["valores"]["DATA"]["VALORES"].length ;i++){
                      var elementoList=$('<li  ><a data-flt-val="'+data["valores"]["DATA"]["VALORES"][i]+'">'+data["valores"]["DATA"]["VALORES"][i]+'</a></li>');
                      lista.append(elementoList);
                  }
                   
                 contenedor.append(comboValores);
               
            }
        );

      });

      
      $(".modal-body").on("click", "##filtrosCol li a, ##valoresCol li a",function(){
            var comboPadre=$(this).closest(".btn-group").first();
            var elemento=$(this);
            if (comboPadre.attr("id")==="filtrosCol"){
              var tipoVal="data-flt-id";    
            }
            else{
              var tipoVal="data-flt-val";   
            }
              
            actualizarComboSeleccion(comboPadre,elemento,tipoVal);
      });


      

      $("##agregarFiltro").on("click",function(){
        var idCol=$("##comboColumnas").attr("data-col-id");            
        var idFlt=$("##filtrosCol").attr("data-flt-id");
        var val=$("##valoresCol").attr("data-flt-val");

        if ((typeof idCol !== typeof undefined )&&(typeof idFlt!== typeof undefined  )&&(typeof val !== typeof undefined )) {
          
          $.post('#event.buildLink("reportesAdhoc.editorVisualizaciones.agregarFiltroVis")#', 
            {idCon:$("[data-con-id]").attr("data-con-id") ,idVis:$("[data-vis-id]").attr("data-vis-id"),idCol:idCol,idFlt:idFlt,valFlt:val},
            function(data){
                
                $('##filtrosModal').modal('toggle');
                $(".filtros .btn-toolbar").append( data );
                toastr.success('Agregado exitosamente','Filtro');
               
            }
          ).done( 
            function(){
              if(validarTipoVis()){
                    dibujarVisualizacion();
              }
            });
        }
        
      });


      $('##filtrosModal').on('hidden.bs.modal', function () {
       
        reiniciarFiltrosModal($(this));
       
      });


      $('.configuraciones .ibox-content').on( "click",".propiedad-ico",function(){
        var elemento=$(this);
        var contenedor=$('##configuracionesModal .propiedades');
        $('##configuracionesModal .modal-title').html(elemento.attr("data-original-title"));
        contenedor.attr("data-prop-id",elemento.attr("data-prop-id"));   
        $.post('#event.buildLink("reportesAdhoc.editorVisualizaciones.obtenerEditorPropiedad")#', 
            {idCon:$("[data-con-id]").attr("data-con-id") ,idVis:$("[data-vis-id]").attr("data-vis-id"),idProp:elemento.attr("data-prop-id")},
            function(data){
                
                $('##configuracionesModal').modal('toggle');
                $("##configuracionesModal .propiedades").append( data );
               
               
            }
        );



      });


      $('##modificarConfig').click(function(){
        var valor=$('##valorProp').val();
        var contenedor=$('##configuracionesModal .propiedades');
        $.post('#event.buildLink("reportesAdhoc.editorVisualizaciones.modificarValorPropiedadVis")#', 
            {idCon:$("[data-con-id]").attr("data-con-id") ,idVis:$("[data-vis-id]").attr("data-vis-id"),idProp:contenedor.attr("data-prop-id"),valor:valor},
            function(data){
                
              if(data === true){
                 $('##configuracionesModal').modal('hide');    
              }
                          
            }
        ).done( 
            function(){
              if(validarTipoVis()){
                    dibujarVisualizacion();
              }
            }
        );
       
      });


      $('##configuracionesModal').on('hidden.bs.modal', function () {
       
        $("##configuracionesModal .propiedades").html('');
       
      });




    });
      <!---
        *Fecha :25 de agosto de 2015
         *Descripcion: Funcion encargadada de realizar una peticion AJAX para agregar una columna a la visualizacion activa
         * @author Arturo Christian Santander Maya 
        
      --->

      


    function agregarColumna($item){
    	  $.post('#event.buildLink("reportesAdhoc.editorVisualizaciones.agregarDimensionVis")#', 
            {idCon:$("[data-con-id]").attr("data-con-id") ,idVis:$("[data-vis-id]").attr("data-vis-id"),idCol:$item.attr("data-col-id")},
            function(data){
             
                $(".columnas .btn-toolbar").append( data );
                toastr.success('Agregada exitosamente','Columna');
                $item.addClass("disabled");
                $item.draggable('disable');
                
            }
        ).done( 
            function(){
              if(validarTipoVis()){
                    dibujarVisualizacion();
              }
            });
    }

    <!---
      *Fecha :25 de agosto de 2015
      *Descripcion: Funcion encargadada de realizar una peticion AJAX para agregar una fila a la visualizacion activa
      * @author Arturo Christian Santander Maya 
      
    --->

    function agregarFila($item){
        $.post('#event.buildLink("reportesAdhoc.editorVisualizaciones.agregarMetricaVis")#', 
            {idCon:$("[data-con-id]").attr("data-con-id") ,idVis:$("[data-vis-id]").attr("data-vis-id"),idCol:$item.attr("data-col-id")}, 
            function(data){
                
                $(".filas .btn-toolbar").append( data );
                $(".filas .btn-toolbar .btn-group").children("span").switchClass("btn-primary","btn-info");
                toastr.success('Agregada exitosamente','Fila');
                $item.addClass("disabled");
                $item.draggable('disable');
                
            }
        ).done( 
            function(){
              if(validarTipoVis()){
                    dibujarVisualizacion();
              }
            });
    }
     
    <!---
      *Fecha :25 de agosto de 2015
      *Descripcion: Funcion encargadada de realizar una peticion AJAX para modificar el tipo a la visualizacion activa
      * @author Arturo Christian Santander Maya 
      
    --->

    function agregarTipoVis($item){
    
        $.post('#event.buildLink("reportesAdhoc.editorVisualizaciones.cambiarTipoVisualizacion")#', 
            {idCon:$("[data-con-id]").attr("data-con-id") ,idVis:$("[data-vis-id]").attr("data-vis-id"),idTipoNuevo:$item.attr("data-tipo-vis-id")}, 
            function(data){
               
                  var activa=$(".chart-canvas .chart-title img");
                  var activaIcono= $(".visualizaciones [data-tipo-vis-id='"+activa.attr("data-tipo-vis-id")+"']");

                  activaIcono.draggable("enable");
                  activaIcono.removeClass("vis-tipo-activa");
                  $(".chart-canvas .chart-title").html($item.clone());
                 
                  $(".configuraciones .ibox-content").html(data);

                  $('[data-toggle="tooltip"]').tooltip();
                  $item.addClass("vis-tipo-activa");
                  toastr.success('Modificada exitosamente','Tipo de visualización');
                      
                  $item.addClass("disabled");
                  $item.draggable('disable');


                 
            } 
        ).done( 
            function(){
              if(validarTipoVis()){
                   dibujarVisualizacion();
              }
            });

   
     

    }

     <!---
      *Fecha :27 de agosto de 2015
      *Descripcion: Funcion encargadada de realizar una peticion AJAX para obtener la estructura de la visualizacion y dibujarla.
      * @author Arturo Christian Santander Maya 
      
    --->

    function dibujarVisualizacion(){
      $.post('#event.buildLink("reportesAdhoc.editorVisualizaciones.obtenerDefinicionVisualizacion")#', 
            {idVis:$("[data-vis-id]").attr("data-vis-id"),idCon:$("[data-con-id]").attr("data-con-id") }, 
            function(data){
               $(".chart-cont").removeClass("fast-animated fadeOutDown");
              FusionCharts.ready(
                      function(){
                        data["events"]={
                              "rendered": function (eventObj, dataObj) {
                                    setTimeout(
                                      function(){  
                                        $.post('#event.buildLink("reportesAdhoc.editorVisualizaciones.guardarImagenVis")#',
                                          { idCon:$("[data-con-id]").attr("data-con-id") ,svg : $(".chart-cont span").html(),idVis:$("[data-vis-id]").attr("data-vis-id")});
                                      },1500
                                    );
                              }
                        }
                            
                        var chart = new FusionCharts(data);
              
                        chart.render("chartCont");
                      }
              );
            }
      );
    }
            
    
    <!---
      *Fecha :27 de agosto de 2015
      *Descripcion: Funcion encargadada de verificar si el numero de columnas y filas para una visualizacion son suficientes para satisfacer los requerimientos del tipo de visualizacion activo 
      * @author Arturo Christian Santander Maya 
      
    --->

    function validarTipoVis(){
      var colsAgregadas=$(".columnas .btn-toolbar .btn-group").length;
      var filasAgregadas=$(".filas .btn-toolbar .btn-group").length;
      var activa=$(".vis-tipo-activa");
      var validado=1;
      
      if (colsAgregadas > activa.attr("data-max-col")){
       
        toastr.error('La visualización activa soporta máximo: '+activa.attr("data-max-col")+'columna(s)','Modifique el número de columnas');   
        validado=0;
      }

      if (colsAgregadas < activa.attr("data-min-col")){
       
        toastr.error('La visualización activa necesita al menos: '+activa.attr("data-min-col")+'columna(s)','Modifique el número de columnas');   
        validado=0;
      }
     
      if(filasAgregadas > activa.attr("data-max-fil")){
        
         toastr.error('La visualización activa soporta máximo: '+activa.attr("data-max-fil")+'fila(s)','Modifique el número de filas');
        validado=0;
      }

      if(filasAgregadas < activa.attr("data-min-fil")){
        
         toastr.error('La visualización activa  necesita al menos: '+activa.attr("data-min-fil")+'fila(s)','Modifique el número de filas');
        validado=0;
      }
      
      if (!validado){
        $.post('#event.buildLink("reportesAdhoc.editorVisualizaciones.eliminarDefinicionVis")#', 
            {idVis:$("[data-vis-id]").attr("data-vis-id"),idCon:$("[data-con-id]").attr("data-con-id") },
             function(data){
              if (data==true){
                $(".chart-cont").addClass("fast-animated fadeOutDown");
                $(".chart-cont").one('webkitAnimationEnd oanimationend msAnimationEnd animationend', 
                          function(){
                                 $(".chart-cont").html("");
                            }
                );
              }
                
            }
        );

        
      }
      
      return validado;        

    }

    <!---
      *Fecha :27 de agosto de 2015
      *Descripcion: Funcion encargadada de realizar una peticion AJAX para eliminar un elemento(columna o fila )de una visualizacion.
      * @author Arturo Christian Santander Maya 
      
    --->
    function removerElemento($item){

     
      var elemento=$item;
      var padre=elemento.parents(".btn-group").first();
      if (elemento.parents(".filtros").length){
        $.post('#event.buildLink("reportesAdhoc.editorVisualizaciones.eliminarComponenteFltVis")#', 
            {idCon:$("[data-con-id]").attr("data-con-id") ,idVis:$("[data-vis-id]").attr("data-vis-id"),idCol:padre.attr("data-col-id"),idFiltColVis:padre.attr("data-filt-idfiltcolvis")},
             function(data){
              if (data==true){
                padre.switchClass("fadeInLeft","fadeOutLeft");
                padre.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
                    function(e) {
                   
                      padre.remove(); 
                    
                      toastr.success('Eliminado exitosamente','Filtro');
                      
                      if(validarTipoVis()){
                        dibujarVisualizacion();
                      }
                    }
                );  
              }
                  
            }
        );
      
      }
      else{
        var elementoOriginal= $(".dimension .ibox-content  [data-col-id='"+$item.parent().attr("data-col-id")+"'],.metrica .ibox-content [data-col-id='"+$item.parent().attr("data-col-id")+"']");
        
        $.post('#event.buildLink("reportesAdhoc.editorVisualizaciones.eliminarComponenteAgrVis")#', 
            {idCon:$("[data-con-id]").attr("data-con-id") ,idVis:$("[data-vis-id]").attr("data-vis-id"),idCol:padre.attr("data-col-id"),idAgrColVis:padre.attr("data-agr-idagrcolvis")},
             function(data){
              if (data==true){
                padre.switchClass("fadeInLeft","fadeOutLeft");
                padre.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
                    function(e) {
                      elementoOriginal.removeClass("disabled");
                      elementoOriginal.draggable("enable"); 
                      padre.remove(); 
                    
                      toastr.success('Eliminada exitosamente','Columna');
                      
                      if(validarTipoVis()){
                        dibujarVisualizacion();
                      }
                    }
                );  
              }
                  
            }
        );
      }

    

    }

    <!---
         *Fecha :25 de agosto de 2015
         *Descripcion: Deshabilita todos los elementos(dimensiones , metricas,visualizaciones,configuraciones) que se encuentren ya activos para la visualizacion cargada
         * @author Arturo Christian Santander Maya 
      --->

    function cargarVisualizacion(){

      $(".columnas .ibox-content .btn-group,.filas .ibox-content .btn-group").each(function(i){
          var id=$(this).attr("data-col-id");
          var elemento=$(".dimension .ibox-content [data-col-id='"+id+"'],.metrica .ibox-content [data-col-id='"+id+"']");
          elemento.addClass("disabled"); 
          elemento.draggable('disable');

      });

      var elementoVis=$(".visualizaciones [data-tipo-vis-id='"+$(".chart-title img").attr("data-tipo-vis-id")+"']");
      elementoVis.draggable('disable');
      elementoVis.addClass("vis-tipo-activa");


      $(".vis-tipo ~ div").hide();
      
      if(validarTipoVis()){
        dibujarVisualizacion();
      }

    }


    function crearCombo(data,claseColor,id,columna){
      var comboNuevo=$('<div id="'+id+'" class="btn-group animated fadeInUp "><button type="button" class="btn '+claseColor+' btn-outline">'+columna+'</button><button type="button" class="btn '+claseColor+' btn-outline dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button><ul class="dropdown-menu" role="menu"></ul></div>');
      var lista=comboNuevo.find("ul");
      for (el in data){
        var elementoList=$('<li><a>'+data[el]+'</a></li>');
        lista.append(elementoList);
      }

      return comboNuevo;
    }


    function reiniciarFiltrosModal(modal){
      var contenedor=modal.find(".modal-body");
      var comboCols=contenedor.find("##comboColumnas");
      if(comboCols.siblings().length){
        comboCols.siblings().remove(); 
      }

      var nombre=comboCols.children("##nombre-col");
      nombre.html("Columnas");
      comboCols.removeAttr("data-col-id");


    }


    function actualizarComboSeleccion(combo,elementoSel,tipoValor){
        
        combo.find(".nombre-combo").html(elementoSel.html());
        combo.attr(tipoValor,elementoSel.attr(tipoValor));

    }



  </script>
</cfoutput>