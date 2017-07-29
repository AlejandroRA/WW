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

		var ajusteImagenes = 7;
		var imagenes =  new Array();
		var logoCsii = new Image();
		logoCsii.src = "/includes/img/logo/LogoSII_mini.png";
		var logoIPN = new Image();
		logoIPN.src = "/includes/img/logo/IPN.png";
		var imageTotal=0;
		var graficasTotal=0;

	<!---
		 *Fecha :13 de noviembre de 2015
		 *Descripcion: Define las funciones a ejecturase al cargarse la pagina
		 * @author Arturo Christian Santander Maya
	 --->
		$( document ).ready(function() {

    		<!---
		 		Carga el contenido del reporte en el editor
		 	--->
        	cargarReporte(#prc.reporte.getContenido()#);

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

			$("##btnCompartir").click(
				function(event){
					var compartidos="";
					$("##listaUsuarios input:checked").each(function(i,el){
						var idUsr=$(this).parents("tr").first().attr("data-email-usr");
						if(i){
							compartidos=compartidos+";";
						}
						compartidos=compartidos+idUsr;
					});
					if (compartidos != ""){
						rep = crepdf(true);
						$.ajax({
						    type: "POST",
						    url: "/index.cfm/reportesAdhoc/administradorElementos/sendEmail",
						    data: { repPDF:rep,
						    		idrep:#prc.reporte.getId()#,
						    		idconjunto:#prc.conjunto.getId()#,
						    		destinatarios:compartidos},
						    success: function(r) {
						    	if (r == 1){
						    	 	toastr.success('El correo fue enviado con \u00E9xito.','Correo');
				        			$('##listaUsuarios').modal('toggle');
				        		}
								else
						    	 	toastr.error('Hubo un problema en el envio del correo');
							}
						});
					} else {
						toastr.error('Favor de seleccionar al menos un usuario');
					}
				}
			);
		});


	    <!---
		 	*Fecha :13 de noviembre de 2015
			*Descripcion:Crea una celda nueva con los elementos auxiliares correspondientes
			*@author Arturo Christian Santander Maya
	 	--->

	    function crearCeldaNueva(ancho){
	    	var contenedorReporte=$(".reporte-content");
	    	var elementoSiguiente=parseInt(contenedorReporte.attr("data-num-elementos"))+1;
	    	var celda=$( '<div class="celda cel-col-'+ancho+'"  data-cel-ancho="'+ancho+'" data-el-tipo="cont"><div id="el-'+elementoSiguiente+'"  class="cont"></div></div>');

	    	contenedorReporte.attr("data-num-elementos",elementoSiguiente);
	    	return celda;
	    }

	    <!---
		 	*Fecha :13 de noviembre de 2015
			*Descripcion:Crea una fila nueva
			*@author Arturo Christian Santander Maya
	 	--->
	    function crearFilaNueva(alto){
	    	var fila=$( '<div class="fila cel-fil-'+alto+'" data-fil-alto="'+alto+'" ></div>');
	    	return fila;
	    }

	    <!---
		 	*Fecha :13 de noviembre de 2015
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
							    		graficasTotal++;
							}
						);
					}
				}

			);
	    }

	    <!---
		 	*Fecha :13 de noviembre de 2015
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
		    				celdaNueva.find(".cont").append($( '<textarea spellcheck="false" readonly >'+celda.valor+'</textarea>'));
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

		function exportar(){

		    $("<div id='overlay' class='progress progress-striped active'>Exportando...<div style='width: 100%' class='progress-bar'></div></div>").css({
		        "position": "fixed",
		        "top": "0px",
		        "left": "0px",
		        "width": "100%",
		        "height": "100%",
		        "background-color": "rgba(255,255,255,.9)",
		        "z-index": "10000",
		        "vertical-align": "middle",
		        "text-align": "center",
		        "color": "##555",
		        "font-size": "40px",
		        "font-weight": "bold",
		        "cursor": "wait"
		    }).appendTo('.reporte-content');
			$('.reporte-content').css('width','2000px');
			$('.reporte-content').css('height','1000px');
			setTimeout(function(){getImages();},1500);
		}

		function habilitarOpciones(){
			$('##btn-export').css('visibility','hidden');
			$('##btn-pdf').css('visibility','visible');
			$('##btn-email').css('visibility','visible');
			$('.reporte-content').css('width','100%');
			$('.reporte-content').css('height','100%');
			setTimeout(function(){  $("##overlay").remove();},500);
		}
		<!---
		 	*Fecha :26/01/2016
			*Descripcion:crea la pagina con footer y header
			*@author Marco Torres
	 	--->
		function  getImages2( idvis){
			var svgString = $('div[data-vis-id="' +  idvis + '"] span').html();
			imagenesSVG = "data:image/svg+xml;base64,"+ window.btoa(unescape(encodeURIComponent( svgString)));

			var ajusteImg = 1.00;
			var ajusteImg2 = 1.00;

			if (svgString === undefined){
				return false;
			}

			var img = new Image();
			var imagen = new Image();
			//imagen.src = "data:image/png;utf-8,"( svgString);
			imagen.src = "data:image/svg+xml;base64,"+ window.btoa(unescape(encodeURIComponent( svgString)));
			imagen.onload = function() {
				var canvas = document.createElement( "canvas" );
				var ctx = canvas.getContext( "2d" );

				canvas.width = imagen.width*ajusteImg;
				canvas.height = imagen.height*ajusteImg;
				ctx.drawImage( imagen, 0, 0,imagen.width*ajusteImg2,imagen.height *ajusteImg2);
				img.src = canvas.toDataURL( "image/png" );
				imageTotal++;
				if ( graficasTotal == imageTotal){
					habilitarOpciones();
				}
			};
			imagen.onerror = function() {

				imageTotal++;
				if ( graficasTotal == imageTotal){
					habilitarOpciones();
				}
/*
				$.post('#event.buildLink("reportesAdhoc.administradorElementos.saveImg")#',
			            {idconjunto:#prc.conjunto.getId()#,idVis:idvis,svg:svgString},
			            function(data){
			            	alert(data);
				        	img.src = data;
				        	img.onload = function() {
					        	imageTotal++;
								if ( graficasTotal == imageTotal){
									habilitarOpciones();
								}
				        	}
				        	img.onerror= function(){

				        	alert("error");
				        	}
				        }
			    );


*/

			}
			imagenes[idvis]= '';
			imagenes[idvis]  = img;
		}

		function  getImages( ){
			$('[data-el-tipo="vis"]').each(function(){
				getImages2($(this).attr("data-vis-id"));
		    });
		}

		<!---
		 	*Fecha :26/01/2016
			*Descripcion:crea la pagina con footer y header
			*@author Marco Torres
	 	--->
		function crepdf(email){
			var arrFilas = #prc.reporte.getContenido()#;
			var doc = new jsPDF('landscape');
			var x = 27,y = 68;

			crearPaginaHorizontal(doc);

			/**Body**/
			doc.setFillColor(235, 235, 235);
			doc.roundedRect(20, 45, 260, 18, 5, 5, 'FD');

			doc.setFontSize(10);
			doc.setTextColor(70);
			doc.text(30, 55, 'Secci\u00f3n:');
			doc.text(80, 55, 'Titulo:');
			doc.text(135, 55, 'Descripci\u00f3n: ');

			doc.setFontSize(10);
			doc.setTextColor(0);
			//doc.setFontType("bold");
			doc.text(45, 55, '#prc.conjunto.getNombre()#');
			doc.text(91, 55, '#prc.reporte.getNombre()#');
			doc.text(156, 55, '#prc.reporte.getDescripcion()#');
			doc.setFontType("normal");

			cargarImagenes(doc,arrFilas,x,y,250,120);

			if(email)
				return doc.output();
			else
				doc.save('#prc.reporte.getNombre()#.pdf');
		}

		<!---
		 	*Fecha :26/01/2016
			*Descripcion:crea la pagina con footer y header
			*@author Marco Torres
	 	--->
		function crearPaginaHorizontal(doc){
					doc.setLineWidth(0.3);
			doc.setDrawColor(0);
			doc.setFillColor(255, 255, 255);
			doc.roundedRect(12, 12, 275, 185, 7, 7, 'FD');

			/*header*/
			doc.line(15, 40, 285, 40);
		    doc.addImage(logoCsii,'png', 30, 20, 30, 15, 'CSII');
			doc.addImage(logoIPN,'png', 160, 20, 45, 15, 'CSII2');

			doc.setFontSize(15);
			doc.setTextColor(150);
			doc.text(85, 25, 'Instituto Polit\u00e9cnico Nacional');

			doc.setFontSize(10);
			doc.text(90, 30, 'Sistema Institucional de Informaci\u00f3n.');
			/*********************/

			var divqr = document.getElementById('Div_qr');

			var qrcode = new QRCode(divqr, {width : 100,height : 100});
			//qrcode.makeCode('#Session.cbstorage.usuario.NOMBRE# #Session.cbstorage.usuario.AP_PAT# #Session.cbstorage.usuario.AP_MAT# #DateFormat(Now(),"medium")#');
			qrcode.makeCode('#Session.cbstorage.usuario.NOMBRE#  #DateFormat(Now(),"medium")#');

			var canvas = $('##Div_qr canvas');
    		var imgqr = new Image();
    		imgqr.src = canvas.get(0).toDataURL("image/png");

			/*footer*/

			doc.setFontSize(6);
			doc.line(15, 190, 285, 190);
			doc.text(60, 195, 'Imprimi\u00f3: #Session.cbstorage.usuario.NOMBRE# #Session.cbstorage.usuario.AP_PAT# #Session.cbstorage.usuario.AP_MAT#');
			doc.text(160, 195, 'Fecha de Impresi\u00f3n: #DateFormat(Now(),"medium")#');
			doc.text(260, 205, 'Pagina 1 de 1');
			doc.addImage(imgqr,'png', 260, 18, 20, 20, '');

			/* ***********/

		}

		<!---
		 	*Fecha :26/01/2016
			*Descripcion:Funcion que recorre ell json para cargar las imagenes de las graficas
			*@author Marco Torres
	 	--->
		function cargarImagenes(doc,arrFilas,xini, yini , anchoMax ,altoMax){
			var coefY=calculaCoeficienteY(arrFilas,altoMax);
			var y = yini;
			for (var i=0;i<arrFilas.length;i++){
				var x = xini;
				var alto = arrFilas[i].alto*ajusteImagenes*coefY;
				var coefx=calculaCoeficienteX(arrFilas[i],anchoMax);
				for(var j=0;j<arrFilas[i].celdas.length;j++){
					var ancho = arrFilas[i].celdas[j].ancho*ajusteImagenes *coefx;
					cargarElementos(doc,arrFilas[i].celdas[j],x,y,ancho,alto)
					x+=ancho;
				}
				y += alto;
			}
		}

		<!---
		 	*Fecha :26/01/2016
			*Descripcion:Funcion recursiva para cargar los elementos que pertenecen al reporte
			*@author Marco Torres
	 	--->
		function cargarElementos(doc,celda,xp,yp,anchoMax,altoMax){
		   	var ancho = celda.ancho*ajusteImagenes;
			if(!celda.filas.length){
				switch(celda.tipo){
					case "vis":
							if(imagenes[celda.valor].src !=''){
								doc.addImage(imagenes[celda.valor],'png', xp, yp, anchoMax, altoMax, 'vis_'+celda.valor)
							}
						break;
	    			case "txt":
	    				doc.setTextColor(130);
						var linea = doc.setFontSize(6).splitTextToSize(""+ celda.valor, anchoMax * 0.85)
						doc.text(xp , yp+3, linea);
	    				break;
	    			case "img":
	    				break;
	    			case "cont":
	    				break;
		    	}
		    	return true;
	    	}
	    	var coefY=calculaCoeficienteY(celda.filas,altoMax);
			for (var i=0;i<celda.filas.length;i++){
				var alto1 =  celda.filas[i].alto*ajusteImagenes*coefY;
				var x1 = xp;
				var coefx=calculaCoeficienteX(celda.filas[i],anchoMax);
	    		for(var j=0;j<celda.filas[i].celdas.length;j++){
					var ancho2 = celda.filas[i].celdas[j].ancho*ajusteImagenes*coefx;
	    			cargarElementos(doc,celda.filas[i].celdas[j],x1,yp,ancho2,alto1);
					x1 += ancho2;
	    		}
				yp += alto1;
	    	}
	    	return true;
	    }

		<!---
		 	*Fecha :26/01/2016
			*Descripcion:Calcula el valor para ajustar los contenedores a un ancho maximo
			*@author Marco Torres
	 	--->
		function calculaCoeficienteX(array,maximo){
			var valor = 0;
			for(var i=0;i<array.celdas.length;i++){
				valor +=array.celdas[i].ancho*ajusteImagenes;
				}
			return maximo/valor;
		}

		<!---
		 	*Fecha :26/01/2016
			*Descripcion:Calcula el valor para ajustar los contenedores a un alto maximo
			*@author Marco Torres
	 	--->
		function calculaCoeficienteY(array,maximo){
			var valor = 0;
			for(var i=0;i<array.length;i++){
				valor +=array[i].alto*ajusteImagenes;
			}
			return maximo/valor;
		}

		<!---
		 	*Fecha :26/01/2016
			*Descripcion:Calcula el valor para ajustar los contenedores a un alto maximo
			*@author Marco Torres
	 	--->
		function email(){
			$.post('#event.buildLink("reportesAdhoc.administradorElementos.obtenerUsuariosAutorizados")#',
	            {idCon:#prc.conjunto.getId()#,idRep:#prc.reporte.getId()#,email:true},
	            function(data){
		        	$('##listaUsuarios').modal('toggle');
		        	$("##listaUsuarios .modal-body").attr("data-rep-id",#prc.reporte.getId()#);
             				$("##listaUsuarios .modal-body").html( data );
	            }
		    );
		}
	</script>
</cfoutput>