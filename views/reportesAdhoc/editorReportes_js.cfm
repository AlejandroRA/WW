<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Adhoc
* Sub modulo: Editor de Reportes  
* Fecha 14 de Septiembre  de 2015
* Descripcion: 
* Script para la vista del submodulo de edicion de reportes
* Autor:Arturo Christian Santander Maya 
* ================================
--->

<cfprocessingdirective pageEncoding="utf-8"> 
<cfoutput>
	<script type="text/javascript">

	<!---
		 *Fecha :14 de septiembre de 2015
		 *Descripcion: Define las funciones a ejecturase al cargarse la pagina 
		 * @author Arturo Christian Santander Maya 
	 --->
		$( document ).ready(function() { 
			$('[data-toggle="tooltip"]').tooltip();			
			$('.pageguide').show();
			
	        tl.pg.init({
	        	"custom_open_button": "##showpageguide",
	            "auto_refresh": true,
            	"default_zindex":999           
	        });
	       <!---
		 		Define la configuracion  para el plugin toastr encargado de las alertas para el usuario 
		 	--->
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
		 		Agrega al funcionalidad asociada con el evento de arrastrar para la coleccion de visualizaciones y objetos disponibles
		 		para la edicion del reporte 
		 	--->
			$( ".objetos .ibox-content  a,.visualizaciones .ibox-content  a" ).draggable({
	            revert: "invalid", 
	            containment: ".wrapper-content",
	            cursor: "move",
	      
	            zIndex:200,
	            helper:function(event,ui){
	               var element=$("<div class='fast-animated rollIn'></div>");
	        	   if($(this).has("img").length != 0){
	        	   		element.addClass("img-arrastrada")
	        	   		return  element.append($(this).children("img").clone());
	        	   }
	        	   		
	        	   	else{
	        	   		element.addClass("objeto-arrastrado")
	        	   		return element.append($(this).children("i").clone());
	        	   	}		
	               		
	            }
	        });
 
    		<!---
		 		Carga el contenido del reporte en el editor
		 	--->
        	cargarReporte(#prc.reporte.getContenido()#);
			agregarDroppable();
			agregarResizeable();
	    	
			<!---
		 		Agrega la funcionalidad asociada al evento de enviar el formulario que correponde al nombre del reporte para cambiar su nombre
		 	--->
	        $(".ed-nombre").submit(
	        	function(event){
			        event.preventDefault();
			        var nombreNuevo=$(".ed-nombre input").val();
			        $.post('#event.buildLink("reportesAdhoc.editorReportes.cambiarNombreRep")#', 
			            {idCon:$("[data-con-id]").attr("data-con-id") ,idRep:$("[data-rep-id]").attr("data-rep-id"),nombreNuevo:nombreNuevo},
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
		        }
		    );      

			<!---
		 		Agrega la funcionalidad asociada al evento de click para los botones encargados de cambiara entre la vista de edicion y la de exploracion 
		 	--->
			$("##botonesControl .btn").click(function(){
				
				var elemento=$(this);
				for (var item in FusionCharts.items) {
				    FusionCharts.items[item].lockResize(true);
				}

				
				if(elemento.children(".fa-compass").length){
					$("##controles").attr("hidden","true");
					$(".reporte-content textarea").attr("readonly","true");
					$(".celda").resizable( "option", "disabled",true);
					$( ".fila" ).resizable( "option", "disabled",true);
					$("##contenido").switchClass("col-lg-9","col-lg-12",function(){
						for (var item in FusionCharts.items) {
						    FusionCharts.items[item].lockResize(false);
						}
					});
						
				}
				else{
					
	
					$("##contenido").switchClass("col-lg-12","col-lg-9",function(){
						$(".celda").resizable( "option", "disabled",false);
						$( ".fila" ).resizable( "option", "disabled",false);
						$(".reporte-content textarea").removeAttr("readonly");
						$("##controles").removeAttr("hidden");
						for (var item in FusionCharts.items) {
						    FusionCharts.items[item].lockResize(false);
						}
					});
					
				}
				
				elemento.addClass("btn-outline click-dis");
				elemento.siblings().removeClass("btn-outline click-dis");
				elemento.blur();

			});

			
			
		    $("##modificar-desc").focus(function(event){
		   
		    	event.preventDefault();
		        
		        var el=$(this);
		        var descNueva=el.parent().siblings("textarea").val();
		        if(descNueva.length===0){
		          return;
		        }

		        $.post('#event.buildLink("reportesAdhoc.editorReportes.cambiarDescRep")#', 
		            {idCon:$("[data-con-id]").attr("data-con-id"),idRep:$("[data-rep-id]").attr("data-rep-id"),descNueva:descNueva},
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
		    
		    $(".descripcion textarea").blur(function(event){
		      
		  		setTimeout(function(){   	
		      		$("##modificar-desc").parent().attr("hidden","true");
		  		},10);
		    });

		    
		    $(".descripcion textarea").focus(function(event){
		        
		        $(this).siblings().removeAttr("hidden");

		    });


		    $(".reporte-content").on("blur","textarea",function(){
		    	guardarContenido();	
		    });



		});

		<!---
			 *Fecha :15 de septiembre de 2015
			 *Descripcion: Agrega una visualizacion a un segemento dentro de una celda  
			 * @author Arturo Christian Santander Maya 
	 	--->
		function agregarElementoSegmento(elemento,claseElemento,idEl,tipoEl){
			
			var contenedor=elemento.siblings(".cont");
			
	        var celda=contenedor.closest(".celda");
			
	        var anchoCelda=celda.attr("data-cel-ancho");
	   		
			
	        var nuevoAncho=parseInt(anchoCelda/2);
	        
			contenedor.removeClass(claseElemento);
		
			if( nuevoAncho>0){
				
	          	var contenedorReporte=$(".reporte-content");
	          	var elementoSiguiente=parseInt(contenedorReporte.attr("data-num-elementos"))+1;
	          	var fila=celda.parent();
	          	
	          	
	          	contenedorReporte.attr("data-num-elementos",elementoSiguiente);
	                    	
	          	if(claseElemento==="over-abajo"||claseElemento==="over-arriba"){
	          		
	          		var nuevaFila= crearFilaNueva(6);
	          		var copiaFila=nuevaFila.clone();
	
	          	}
	          	else{

	          		celda.removeClass("cel-col-"+anchoCelda);
	          		celda.addClass(	"cel-col-"+nuevoAncho);	
	          		celda.attr("data-cel-ancho",nuevoAncho);
	          	
	          	}

	         	celda.resizable("destroy");
	          	var nuevaCelda;

	          	if (nuevoAncho*2<anchoCelda)
	          		nuevaCelda=crearCeldaNueva(nuevoAncho+1);
	          	else
	          		nuevaCelda=crearCeldaNueva(nuevoAncho);
	          	
	          	switch(tipoEl){
	          		case "vis":
	          			nuevaCelda.attr("data-vis-id",idEl);
		        		nuevaCelda.attr("data-el-tipo","vis");
	          			nuevaCelda.children(".cont").attr("id","el-"+elementoSiguiente);
	          			break;
	          		case "txt":
	          			nuevaCelda.attr("data-el-tipo","txt");
	          			nuevaCelda.children(".cont").attr("id","el-"+elementoSiguiente);
	          			break;
	          	}
	          	
	          	
	          	
	          	switch(claseElemento){
	          		case "over-izquierda":
	          				celda.before(nuevaCelda);

	          				break;
	          		case "over-derecha":
	          				celda.after(nuevaCelda);
	          				break;
	          		case "over-arriba":

	          				agregarFila(nuevaCelda,celda,nuevaFila,copiaFila,contenedor.clone(),"over-arriba");
	          				break;
	          		case "over-abajo":
	          			    agregarFila(nuevaCelda,celda,nuevaFila,copiaFila,contenedor.clone(),"over-abajo"); 
	          			   	break;						
	          	}

	          	
	          	agregarDroppable();
	         	agregarResizeable();
	          	
	          	switch(tipoEl){
	          		case "vis":
	          			dibujarVisualizacion(idEl,"el-"+elementoSiguiente);
	          			toastr.success('Agregada Exitosamente','Visualización');
	          			break;
	          		case "txt":
	          			agregarCampoTexto("el-"+elementoSiguiente);
	          			toastr.success('Agregada Exitosamente','Visualización');		
	          	}
	          
	          
	        }
	        else{

	        	toastr.error('Espacio muy pequeño','Elemento');
	        
	        }
		}


		<!---
			 *Fecha :15 de septiembre de 2015
			 *Descripcion:Cambia las clases de una celda cuando el cursor se encuentra sobre ella 
			 * @author Arturo Christian Santander Maya 
	 	--->

		function outElemento(elemento,claseElemento){
			
			var el=elemento.siblings(".cont");
			el.removeClass(claseElemento);
			if(!el.hasClass("over-abajo")&&!el.hasClass("over-arriba")&&!el.hasClass("over-izquierda")&&!el.hasClass("over-derecha") ){
				el.addClass("over-cont");
			}
		}

		<!---
			 *Fecha :17 de septiembre de 2015
			 *Descripcion:Solicita al servidor la definicion de una visualizacion y la utiliza para dibujarla
			 * @author Arturo Christian Santander Maya 
	 	--->

		function dibujarVisualizacion(idVis,idDiv){
		    $.post('#event.buildLink("reportesAdhoc.editorReportes.obtenerDefinicionVisualizacion")#', 
		            {	idCon:$("[data-con-id]").attr("data-con-id"),
		            	idRep:$("[data-rep-id]").attr("data-rep-id"),
		            	idVis:idVis}, 
		            function(data){
		            	var celda=$("##"+idDiv).parent();
		            	FusionCharts.ready(function(){
		            		 var chart = new FusionCharts(data);
		                	chart.render(idDiv);
		                	
		            	});
		               
		            }
		    );
	    }	

	    <!---
			 *Fecha :15 de septiembre de 2015
			 *Descripcion:Divide el contenido de una celda en dos filas, una con el contenido actual de la celda y la otra con los elementos a agregarse 
			 * @author Arturo Christian Santander Maya 
	 	--->
	    function agregarFila(nuevaCelda,celda,nuevaFila,copiaFila,contenedor,clase){
			
			var tipoCelda = celda.attr("data-el-tipo");
			nuevaCelda.removeClass("cel-col-"+nuevaCelda.attr("data-cel-ancho"));
	        nuevaCelda.addClass("cel-col-"+24);	
	        nuevaCelda.attr("data-cel-ancho",24);

	         				
	        copiaFila.html(nuevaCelda.clone());
	        copiaFila.find(".cont").attr("id",celda.find(".cont").attr("id"));
	         			
	        nuevaFila.append(nuevaCelda);
	        celda.html("");
	        celda.attr("data-el-tipo","cont");
	        if(clase=="over-abajo"){
	        	celda.append(copiaFila);
	            celda.append(nuevaFila);
	        }
	        else{
	        	celda.append(nuevaFila);
	        	celda.append(copiaFila);
	        }
	    
          				
	        if( contenedor.children().length != 0 ){
	        	switch(tipoCelda){
	        		case "vis":
	        			var clon=FusionCharts(contenedor.children("span").attr("id")).clone();
			        	contenedor.removeAttr("id");
			        	FusionCharts(contenedor.children("span").attr("id")).dispose();
			        	copiaFila.find(".celda").attr("data-el-tipo","vis");
			        	copiaFila.find(".celda").attr("data-vis-id",celda.attr("data-vis-id"));
			        	clon.render(copiaFila.find(".cont").attr("id"));
			        	break;
			        case "txt":
			        	var valor=contenedor.children("textarea").val();
			        	contenedor.removeAttr("id");
			        	copiaFila.find(".celda").attr("data-el-tipo","txt");
			        	agregarCampoTexto(copiaFila.find(".cont").attr("id"));
			        	copiaFila.find("textarea").val(valor);
			        	break;

	        	}
	         	
	        }
	        else{
	        	
	        	copiaFila.find(".celda").attr("data-el-tipo","cont");
	        	copiaFila.find(".celda").removeAttr("data-vis-id");
	        }
	        celda.removeAttr("data-vis-id");
	    }

	    <!---
			 *Fecha :18 de septiembre de 2015
			 *Descripcion:Agrega la propiedad de redimensionarse a las celdas y filas del contenedor del reporte
			 *@author Arturo Christian Santander Maya 
	 	--->
	    function agregarResizeable(){ 
	    	
	    	$(".celda").resizable( {
			    	containment: "parent",
			   		handles:"e",
			   		minWidth: 0,

			   		start:function(event,ui){
			   			var celda=ui.element;
						var celdaSig=celda.next(".celda");
						var ancho=celda.width();

						for (var item in FusionCharts.items) {
								    FusionCharts.items[item].lockResize(true);
								}
						

						if (celdaSig.length){
						
							var anchoSig=celdaSig.width();
							var anchoMax=ancho+anchoSig;
							celda.attr("data-ancho-max",anchoMax-2);
						}
						else{
							
							celda.attr("data-ancho-max",ancho-1);
						}
			   		}, 

			   		resize:function(event,ui){
			   			var celda=ui.element;
						var celdaSig=celda.next(".celda");
						var ancho=ui.originalSize.width;
						var nuevoAncho=ui.size.width;	
						var anchoMax= celda.attr("data-ancho-max");
						
						celda.resizable( "option", "maxWidth", anchoMax );

						if (celdaSig.length){
							if(nuevoAncho<=0){
								celdaSig.css("width",anchoMax+"px");
							}

							if((ancho<nuevoAncho && nuevoAncho<=anchoMax )||(ancho>nuevoAncho && nuevoAncho>0)){
								
								celdaSig.css("width",(anchoMax-nuevoAncho)+"px");

								if(ancho>nuevoAncho){
									
									celdaSig.find(".cont").css("opacity",1);
								}
								
								else{
									
								    celdaSig.find(".cont").css("opacity",0.5);
								}
							
							}

							if(nuevoAncho>=anchoMax){
								celda.css("width",anchoMax+"px");
							}
						}

						if(ancho>nuevoAncho){
						
							celda.find(".cont").css("opacity",0.5);
						
						}
						else{
						
							celda.find(".cont").css("opacity",1);
						
						}
			   		},

			   		stop:function(event,ui){
			   			var celda=ui.element;
						var anchoCelda=celda.parent().width()/24;
						var nuevoAncho=Math.round(ui.size.width/anchoCelda);	
						var ancho=parseInt(celda.attr("data-cel-ancho"));
						var celdaSig=celda.next(".celda");
						
						
						if (!celdaSig.length){
							if( nuevoAncho<ancho && nuevoAncho>0){
													
								celdaSig=crearCeldaNueva(ancho-nuevoAncho);
								
								
								celda.attr("data-cel-ancho",nuevoAncho);
								celda.removeClass("cel-col-"+ancho);
								celda.addClass("cel-col-"+nuevoAncho);
								celda.after(celdaSig);
								
								
							}
							else{
								if(nuevoAncho<=0){
									
									celdaSig=crearCeldaNueva(ancho);
									celda.after(celdaSig);
									if (celda.attr("data-el-tipo")==="cont"){
										celda.find(".celda").each(function(i,el){
											eliminarCelda($(this));
										});

									}
									
									eliminarCelda(celda);
								
								}
							}
							
							agregarDroppable();
							agregarResizeable();
						}
						else{
							var anchoSig=parseInt(celdaSig.attr("data-cel-ancho"));
							anchoMax=ancho+anchoSig;
						
							if ((nuevoAncho>ancho && nuevoAncho<anchoMax)||(nuevoAncho<ancho && nuevoAncho>0)){
								
								
								celda.attr("data-cel-ancho",nuevoAncho);
								celda.removeClass("cel-col-"+ancho);
								celda.addClass("cel-col-"+nuevoAncho);
								
								celdaSig.attr("data-cel-ancho",anchoMax-nuevoAncho);
								celdaSig.removeClass("cel-col-"+anchoSig);
								celdaSig.addClass("cel-col-"+(anchoMax-nuevoAncho));

							}
							else{
								if(nuevoAncho>=anchoMax){
								
									celda.attr("data-cel-ancho",anchoMax);
									celda.removeClass("cel-col-"+ancho);
									celda.addClass("cel-col-"+anchoMax);
									
									if (celdaSig.attr("data-el-tipo")==="cont"){
										celdaSig.find(".celda").each(function(i,el){
											eliminarCelda($(this));
										});

									}
									
									eliminarCelda(celdaSig);
									
									
									
								
								}
								
								else{
									
									if( nuevoAncho<=0){
										
										celdaSig.attr("data-cel-ancho",anchoMax);
										celdaSig.removeClass("cel-col-"+anchoSig);
										celdaSig.addClass("cel-col-"+anchoMax);
										
										if (celda.attr("data-el-tipo")==="cont"){
											celda.find(".celda").each(function(i,el){
												eliminarCelda($(this));
											});
										}
										
										eliminarCelda(celda);
										
									}
								}
						
							}
							
							
						}
						
						for (var item in FusionCharts.items) {
								    FusionCharts.items[item].lockResize(false);
						}
						guardarContenido();
						$(".celda").removeAttr("style");
						$(".celda").find(".cont").removeAttr("style");
					
					}

			   		

			   		



			} );

			$(".fila").resizable({
				containment: "parent",
				handles:"s",
				minHeight: 0,
				start:function(event,ui){
					
					var fila=ui.element;
					var filaSig=fila.next(".fila");
					var alto=fila.height();

					for (var item in FusionCharts.items) {
							    FusionCharts.items[item].lockResize(true);
							}
					
					if (filaSig.length){
						
						var altoSig=filaSig.height();
						var altoMax=alto+altoSig;

						fila.attr("data-alto-max",altoMax);
					}

				},
				resize:function(event,ui){
					var fila=ui.element;
					var filaSig=fila.next(".fila");
					var alto=ui.originalSize.height;
					var nuevoAlto=ui.size.height;	
					var altoMax= fila.attr("data-alto-max");
					
					fila.resizable( "option", "maxHeight", altoMax );

					if (filaSig.length){
						if(nuevoAlto<=0){
							filaSig.css("height",altoMax+"px");
						}
						if((alto<nuevoAlto && nuevoAlto<=altoMax )||(alto>nuevoAlto && nuevoAlto>=0)){
							
							filaSig.css("height",(altoMax-nuevoAlto)+"px");

							if(alto>nuevoAlto){
								
								filaSig.find(".cont").css("opacity",1);
							}
							
							else{
								
							    filaSig.find(".cont").css("opacity",0.5);
							}
						
						}

						if(nuevoAlto>=altoMax){
							fila.css("height",altoMax+"px");
						}
					}

					if(alto>nuevoAlto){
					
						fila.find(".cont").css("opacity",0.5);
					
					}
					else{
					
						fila.find(".cont").css("opacity",1);
					
					}


				},
				stop:function(event,ui){
					
					var fila=ui.element;
					var altoCelda=ui.element.parent().height()/12;
					var nuevoAlto=Math.round(ui.size.height/altoCelda);	
					var alto=parseInt(ui.element.attr("data-fil-alto"));
					var filaSig=ui.element.next(".fila");

					
					if (!filaSig.length && nuevoAlto<alto){
						var celdaNueva=crearCeldaNueva(24);
						
						filaSig=crearFilaNueva(alto-nuevoAlto);	
						filaSig.append(celdaNueva);
						fila.after(filaSig);

						if(nuevoAlto>0){
							
							fila.attr("data-fil-alto",nuevoAlto);
							fila.removeClass("cel-fil-"+alto);
							fila.addClass("cel-fil-"+nuevoAlto);
						
						}

						else{
						
							if(nuevoAlto<=0){
							fila.find(".celda").each(function(i,el){
								eliminarCelda($(this));
							});					
							fila.remove();

							}
						
						}

						agregarDroppable();
						agregarResizeable();	
										
					}
					else{
						var altoSig=parseInt(filaSig.attr("data-fil-alto"));
						var altoMax=alto+altoSig;
					
						if ((nuevoAlto>alto && nuevoAlto<altoMax)||(nuevoAlto<alto && nuevoAlto>0)){
						
							fila.attr("data-fil-alto",nuevoAlto);
							fila.removeClass("cel-fil-"+alto);
							fila.addClass("cel-fil-"+nuevoAlto);
							
							filaSig.attr("data-fil-alto",altoMax-nuevoAlto);
							filaSig.removeClass("cel-fil-"+altoSig);
							filaSig.addClass("cel-fil-"+(altoMax-nuevoAlto));

						}
						else{
							if(nuevoAlto===altoMax || nuevoAlto<=0){
							
								if (nuevoAlto<=0){

									var celdasFila=filaSig.children(".celda");
										
								}
								else{
									var celdasFila=fila.children(".celda");
								}
								var celdaPadre=fila.parents(".celda").first();
								var anchoPadre=parseInt(celdaPadre.attr("data-cel-ancho"));
								if(celdaPadre.length&&altoMax===12){

									if (celdasFila.length<=anchoPadre){
										
										
										
																					
											if(combinarFilas(celdasFila,anchoPadre,0)>anchoPadre){
												combinarFilas(celdasFila,anchoPadre,1);
											}
											

											celdaPadre.after(celdasFila);
											celdaPadre.find(".celda").each(function(i,el){
												eliminarCelda($(this));
											});
											
											celdaPadre.remove();	
											
										
									}
									else{
										toastr.error('Espacio muy pequeño','Visualización');
									}
								}
								else{
									if (nuevoAlto<=0){
									

										filaSig.attr("data-fil-alto",altoMax);
										filaSig.removeClass("cel-fil-"+altoSig);
										filaSig.addClass("cel-fil-"+altoMax);
										
										fila.find(".celda").each(function(i,el){
											eliminarCelda($(this));
										});
										
										fila.remove();
									}
									else{

										

										fila.attr("data-fil-alto",nuevoAlto);
										fila.removeClass("cel-fil-"+alto);
										fila.addClass("cel-fil-"+nuevoAlto);

										filaSig.find(".celda").each(function(i,el){
											eliminarCelda($(this));
										});

										filaSig.remove();
									}
									
								}
								
								
							}
							
					
						}
						
						
					}
					
					for (var item in FusionCharts.items) {
						FusionCharts.items[item].lockResize(false);
					}
					

					$(".fila").removeAttr("style");
					$(".fila").find(".cont").removeAttr("style");

					guardarContenido();
				
				}



			});

			
		}
		<!---
		 	*Fecha :14 de septiembre de 2015
			*Descripcion:Agrega la propiedad de ser contenedores para los elementos arrastrables a los elementos auxiliares de las celdas 
			*@author Arturo Christian Santander Maya 
	 	--->
	    function agregarDroppable(){
	    	
	    	$(".celda .derecha").droppable({
	        	accept: " .list-group > a",
	          	over: function(){
		          	var el=	$(this).siblings(".cont");
		          	el.addClass("over-derecha");
		          	el.removeClass("over-cont");
	          	}, 
	          	out:function(){
	          		outElemento($(this),"over-derecha");
	          	},
	          	drop:function(event,ui){
	          		var elemento=$(this);
	          		if(ui.draggable.parents(".visualizaciones").length){

		          		$.when(	agregarReferenciaVis(ui.draggable.attr("data-vis-id"))).done(function(data1){
		          			if (data1===true || data1=== undefined){
			        			agregarElementoSegmento(elemento,"over-derecha",ui.draggable.attr("data-vis-id"),"vis");
			        			guardarContenido();
			        		}	
		        		});	
	            	}
	            	else{
		           		agregarElementoSegmento(elemento,"over-derecha",0,"txt");
		           		guardarContenido();
		            }

	            } 
	      	});

	    	
	    	$(".celda .izquierda").droppable({
	        	accept: " .list-group > a",
	          	over: function(){
		        	var el=	$(this).siblings(".cont");
		          	el.addClass("over-izquierda");
		         	el.removeClass("over-cont");
		        }, 
	            out:function(){
	           		outElemento($(this),"over-izquierda");
	           	},
	      	   drop:function(event,ui){
	      	   		var elemento=$(this);
		        	if(ui.draggable.parents(".visualizaciones").length){
		        		$.when(agregarReferenciaVis(ui.draggable.attr("data-vis-id"))).done(function(data1){
		        			if (data1===true || data1=== undefined){
				        		agregarElementoSegmento(elemento,"over-izquierda",ui.draggable.attr("data-vis-id"),"vis");
				        		guardarContenido();
		        			}
		        		});
		           	}
		           	else{
		           		agregarElementoSegmento(elemento,"over-izquierda",0,"txt");
		           		guardarContenido();
		            }
	           }  	
	      	});
	    	

	    	$(".celda .arriba").droppable({
	        	accept: " .list-group > a",
	          	over: function(){
	          		var el=	$(this).siblings(".cont");
	        		el.addClass("over-arriba");
	          		el.removeClass("over-cont");
	          	}, 
	          	out:function(){
	          		outElemento($(this),"over-arriba");
	          	},
	            drop:function(event,ui){
	            	var elemento=$(this);
		          	if(ui.draggable.parents(".visualizaciones").length){
		          		$.when(agregarReferenciaVis(ui.draggable.attr("data-vis-id"))).done(function(data1){
		          			if (data1===true || data1=== undefined){
			          			agregarElementoSegmento(elemento,"over-arriba",ui.draggable.attr("data-vis-id"),"vis");
			          			guardarContenido();
			          		}
		          		});
		        	
		            }
		            else{
		           		agregarElementoSegmento(elemento,"over-arriba",0,"txt");
		           		guardarContenido();
		            }
	            } 
	      	});

	    	
	    	$(".celda .abajo").droppable({
	       		accept: " .list-group > a",
	          	over: function(){
		          	var el=	$(this).siblings(".cont");
		          	el.addClass("over-abajo");
		            el.removeClass("over-cont");
		        }, 
	            out:function(){
	            	outElemento($(this),"over-abajo");
	            },
	            drop:function(event,ui){
	            	var elemento=$(this);
		          	if(ui.draggable.parents(".visualizaciones").length){
		          		
		          		$.when(agregarReferenciaVis(ui.draggable.attr("data-vis-id"))).done(function(data1){
			        			if (data1===true || data1=== undefined){	
				        			agregarElementoSegmento(elemento,"over-abajo",ui.draggable.attr("data-vis-id"),"vis");
				        			guardarContenido();
				        		}

		        		});

		          	}
		          	else{
		           		agregarElementoSegmento(elemento,"over-abajo",0,"txt");
		           		guardarContenido();
		            }
		        } 
	        });	

	    	
	    	
	    	$(".celda .cont").droppable({
	        	accept: " .list-group > a",
	        	out:function(event,ui){
		          	$(this).removeClass("over-cont");
		        },
	          	drop:function(event,ui){
		          	if($(this).hasClass("over-cont")){
		          		if(ui.draggable.parents(".visualizaciones").length&&(ui.draggable.attr("data-vis-id")!=$(this).parent().attr("data-vis-id"))){
			          		var contenedor=$(this);
			          		var celda=contenedor.parent();
			          		if(celda.attr("data-el-tipo")==="vis"){
			          			eliminarReferenciaVis(celda.attr("data-vis-id"));
			          		}
			          		contenedor.removeClass("over-cont");
			          		$.when(agregarReferenciaVis(ui.draggable.attr("data-vis-id"))).done(function(data1){

			          			if (data1===true || data1=== undefined ){
				          			celda.attr("data-vis-id",ui.draggable.attr("data-vis-id"));
			            			celda.attr("data-el-tipo","vis");
				          			dibujarVisualizacion(ui.draggable.attr("data-vis-id"),contenedor.attr("id"));
				          			guardarContenido();
				          			toastr.success('Agregada Exitosamente','Visualización');
				          		}


				          		
			          		});
		          		}
		          		else{
		          			$(this).removeClass("over-cont");
		          			if(ui.draggable.attr("data-tipo-obj")==="texto" && $(this).parent().attr("data-el-tipo") != "txt" ){
		          				var contenedor=$(this);
			          			var celda=contenedor.parent();
			          			var tipoCelda=celda.attr("data-el-tipo");
			          			switch(tipoCelda){
			          			case "vis":
			          				celda.removeAttr("data-vis-id");
			          				FusionCharts(contenedor.children("span").attr("id")).dispose();
			          				break;
			          			}
			          			celda.attr("data-el-tipo","txt");
			          			agregarCampoTexto(contenedor.attr("id"));
			          			guardarContenido();

		          			}
		          			
		          		}
		          	}
		        }  
	      	});	
	    }

	    
	    <!---
		 	*Fecha :14 de septiembre de 2015
			*Descripcion:Crea una celda nueva con los elementos auxiliares correspondientes  
			*@author Arturo Christian Santander Maya 
	 	--->

	    function crearCeldaNueva(ancho){
	    	var contenedorReporte=$(".reporte-content");
	    	var elementoSiguiente=parseInt(contenedorReporte.attr("data-num-elementos"))+1;
	    	var celda=$( '<div class="celda cel-col-'+ancho+'"  data-cel-ancho="'+ancho+'" data-el-tipo="cont"><div class="arriba"></div><div class="izquierda"></div><div class="derecha"></div><div class="abajo"></div><div id="el-'+elementoSiguiente+'"  class="cont"></div></div>');
	    	
	    	contenedorReporte.attr("data-num-elementos",elementoSiguiente);
	    	return celda;
	    }


	    <!---
		 	*Fecha :14 de septiembre de 2015
			*Descripcion:Crea una fila nueva  
			*@author Arturo Christian Santander Maya 
	 	--->
	    function crearFilaNueva(alto){
	    	
	    	var fila=$( '<div class="fila cel-fil-'+alto+'" data-fil-alto="'+alto+'" ></div>');
	    	
	    	
	    	return fila;
	    }




	    <!---
		 	*Fecha :18 de septiembre de 2015
			*Descripcion:Combina una fila con la fila de la celda padre si es la unica fila dentro de una celda y si el numero de  celdas hijas  menor o igual al ancho de la celda padre y regresa el ancho total de las celdas   
			*@author Arturo Christian Santander Maya 
	 	--->

	    function combinarFilas(celdasFila,anchoPadre,anchoMayor){
	    	var res=0;
	    	var anchoTotal=0;
			celdasFila.each(function(i,el){
				var ancho=parseInt($(this).attr("data-cel-ancho"));
				
				if (anchoMayor){
					var nuevoAncho=anchoPadre/celdasFila.length;
				}
				else{
					var anchoPor=ancho/24;
					var nuevoAncho=(anchoPadre*anchoPor)+res;
				}
				
				res=(nuevoAncho-parseInt(nuevoAncho));
		
				if (i===celdasFila.length-1){
					nuevoAncho=Math.round(nuevoAncho);	
				}
				else{
					nuevoAncho=parseInt(nuevoAncho);
					if (nuevoAncho===0){
						nuevoAncho=1;
					}
				}
												
				anchoTotal+=nuevoAncho;
					
								
				$(this).attr("data-cel-ancho",nuevoAncho);
				$(this).removeClass("cel-col-"+ancho);
				$(this).addClass("cel-col-"+nuevoAncho);
			});
	    	
	    	return anchoTotal;
	    
	    }




 		<!---
		 	*Fecha :21 de septiembre de 2015
			*Descripcion:Obtiene el objeto en JSON correspondiente a la estructura del contenido del reporte   
			*@author Arturo Christian Santander Maya 
	 	--->
	   
	    function obtenerContenido(){
	    	
	    	var filas=$(".reporte-content").children(".fila");
	    	var filasArr=[];
	    	
	    	filas.each(function(i,el){
	    		var fila={};
	    		var celdas=$(this).children(".celda");
	    		fila["celdas"]=[];
	    		fila["alto"]=$(this).attr("data-fil-alto");

	    		celdas.each(function(j,el){
		    		
		    		fila["celdas"].push(obtenerContCelda($(this)));	

	    		});

	    		filasArr.push(fila);	
	    	});

	    

	    	return filasArr;
	    }

	    <!---
		 	*Fecha :21 de septiembre de 2015
			*Descripcion:Obtiene el objeto en JSON correspondiente a una celda del contenido del reporte  
			*@author Arturo Christian Santander Maya 
	 	--->

	    function obtenerContCelda(celda){
	    	var filas=celda.children(".fila");
	    	var celdaObj={};
	    	
	    	celdaObj["tipo"]=celda.attr("data-el-tipo");
		    celdaObj["ancho"]=celda.attr("data-cel-ancho");
	    	celdaObj["valor"]="";
	    	celdaObj["filas"]=[];
	    	
	    	if(!filas.length){
	    		
	    		switch(celdaObj["tipo"]){
		    			
		    			case "vis":
		    				celdaObj["valor"]=celda.attr("data-vis-id");
		    				break;
		    			case "txt":
		    				celdaObj["valor"]=celda.find("textarea").val();
		    				break;
		    			case "img":
		    				break;
		    	}
		    	return celdaObj; 
	    	}

	    	filas.each(function(i,el){
	    		var fila={}
	    		
	    		fila["alto"]=$(this).attr("data-fil-alto");
	    		fila["celdas"]=[];
	    		
	    		$(this).children(".celda").each(function(i,el){
	    		
	    			fila["celdas"].push(obtenerContCelda($(this)));
	    		});
	    		
	    		celdaObj["filas"].push(fila);
	    	});

	    	return celdaObj; 
	    }

	    <!---
		 	*Fecha :22 de septiembre de 2015
			*Descripcion:Envia una peticion para agregar una nueva visualizacion a un reporte si es que no se tienen instancias de esta visualizacion 
			*@author Arturo Christian Santander Maya 
	 	--->

	    function agregarReferenciaVis(idVis){

	    	var elementosRepetidos=$(".reporte-content [data-vis-id="+idVis+"]");
	    	
	    	if (elementosRepetidos.length>0){
	    		return;
	    	}

	    	return $.post('#event.buildLink("reportesAdhoc.editorReportes.agregarVisualizacionRep")#', 
		            { idCon:$("[data-con-id]").attr("data-con-id"),
		              idVis:idVis,
		              idRep:$("[data-rep-id]").attr("data-rep-id")}
		    );

	    }

	    <!---
		 	*Fecha :22 de septiembre de 2015
			*Descripcion:Envia una peticion para eliminar una visualizacion de un  reporte si es que no se tienen instancias de esta visualizacion 
			*@author Arturo Christian Santander Maya 
	 	--->

	    function eliminarReferenciaVis(idVis){
	    	var elementosRepetidos=$(".reporte-content [data-vis-id="+idVis+"]");
	    	if (elementosRepetidos.length>1){
	    		return;
	    	}

	    	return $.post('#event.buildLink("reportesAdhoc.editorReportes.eliminarVisualizacionRep")#', 
		            { 	idCon:$("[data-con-id]").attr("data-con-id"),
		            	idVis:idVis,
		              	idRep:$("[data-rep-id]").attr("data-rep-id")}
		    );	

	    }

	    <!---
		 	*Fecha :22 de septiembre de 2015
			*Descripcion:Elimina una celda de una fila
			*@author Arturo Christian Santander Maya 
	 	--->

	    function eliminarCelda(celda){
	    	
	    	if(celda.attr("data-el-tipo")==="vis"){
				eliminarReferenciaVis(celda.attr("data-vis-id"));
			}
			celda.remove();
	    }

	    <!---
		 	*Fecha :22 de septiembre de 2015
			*Descripcion:Obtiene el contenido del reporte y envia una peticion para almacenarlo
			*@author Arturo Christian Santander Maya 
	 	--->


	    function guardarContenido(){
	    
	    	var contenido=obtenerContenido();
	    	
			
		
	    	$.post('#event.buildLink("reportesAdhoc.editorReportes.guardarContenidoRep")#', 
		            {idCon:$("[data-con-id]").attr("data-con-id"),idRep:$("[data-rep-id]").attr("data-rep-id"),cont:JSON.stringify(contenido)}
		    );	

	    }

	    <!---
		 	*Fecha :25 de septiembre de 2015
			*Descripcion:Carga el reporte partir de un objeto definido en JSON y dibuja las visualizaciones correspondientes
			*@author Arturo Christian Santander Maya 
	 	--->

	    function cargarReporte(arrFilas){
	    	
	    	for (var i=0;i<arrFilas.length;i++){
	    		
	    		var nuevaFila=crearFilaNueva(arrFilas[i].alto);
	    	
	    		for(var j=0;j<arrFilas[i].celdas.length;j++){
	    			
	    			nuevaFila.append(cargarCelda(arrFilas[i].celdas[j]));
	    		}
	    		$(".reporte-content").append(nuevaFila);
	    	}
	    	
	    	
	       #toScript(prc.reporte.obtenerDefinicionesVis(),"visualizaciones")# 
	    	FusionCharts.ready(
                function(){
                	var chartsNombres={}
			       for (var vis in visualizaciones){
						$(".reporte-content [data-vis-id="+visualizaciones[vis]["id"]+"]").each(
							function(){
								
							    		var idDiv=$(this).children(".cont").attr("id");
							    								    	
							    		chartsNombres["graf_"+visualizaciones[vis]["id"]] = new FusionCharts(JSON.parse(visualizaciones[vis]["definicion"]));
							    		chartsNombres["graf_"+visualizaciones[vis]["id"]].render(idDiv);
							    		
								
							}
						);
					}
				}
			);		
	    	
	    	
	    	
	    	



	    }

	    <!---
		 	*Fecha :25 de septiembre de 2015
			*Descripcion:Carga una celda a partir de un objeto definido en JSON 
			*@author Arturo Christian Santander Maya 
	 	--->

		 function cargarCelda(celda){
		 	
	 		var celdaNueva=crearCeldaNueva(celda.ancho);
	       	celdaNueva.attr("data-el-tipo",celda.tipo);
	       
	       	if(!celda.filas.length){
	    
	    		

	    		switch(celda.tipo){
		    			
		    			case "vis":
		    				celdaNueva.attr("data-vis-id",celda.valor);
		    				break;
		    			case "txt":
		    				celdaNueva.find(".cont").append($( '<textarea spellcheck="false" >'+celda.valor+'</textarea>'));
		    				break;
		    			case "img":
		    				break;
		    			case "cont":
		    				break;
		    				
		    	}
		    	return celdaNueva; 
	    	}

	    	if (celda.tipo==="cont"){
	       		celdaNueva.empty();
	       	
	       	}
	    	for (var i=0;i<celda.filas.length;i++){
	    		
	    		var nuevaFila=crearFilaNueva(celda.filas[i].alto);
	    		for(var j=0;j<celda.filas[i].celdas.length;j++){

	    			nuevaFila.append(cargarCelda(celda.filas[i].celdas[j]));
	    		}
	    		celdaNueva.append(nuevaFila);
	    	}

	    	

	    	return celdaNueva; 
	    }


	     function agregarCampoTexto(idDiv){
	    	var contenedor=$("##"+idDiv);
	    	var celda=$( '<textarea spellcheck="false" ></textarea>');
	    	contenedor.append(celda);
	    	
	       	return;
	    }



	</script>
</cfoutput>