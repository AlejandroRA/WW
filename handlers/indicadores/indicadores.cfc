<!---
* =========================================================================
* IPN - CSII
* Sistema: SII
* Modulo: Pruebas
* Sub modulo:
* Fecha : Junio 22, 2015
* Autor : Roberto Petlachi
* Descripcion: Handler para la construcción de indicadores
* =========================================================================
--->

<cfcomponent>
	<!---
	* Fecha : Noviembre 10 2015
	* Autor : Roberto Petlachi
	--->
	<cffunction name="index" access="public" returntype="void" output="false" hint="Indicadores obtenidos con los cálculos necesarios.">
		<cfargument name="event" type="any">
		<cfscript>
			var rc	= event.getCollection();
			var cn	= getModel("indicadores.CN_Indicadores");
			var rc.resultado = cn.getIndicadores();

            var becas = CreateObject("java","MineriaSII.LinearRegression");

            var auxQuery = QueryNew("CONJUNTO, DESCRIPCION, DISTRIBUCION, INDICADOR, NIND, NOMBRE, PERIODO,ICONO,CICLO,TENDENCIA", "CF_SQL_INTEGER,CF_SQL_VARCHAR, CF_SQL_VARCHAR, CF_SQL_DECIMAL,CF_SQL_VARCHAR,CF_SQL_VARCHAR,CF_SQL_VARCHAR,CF_SQL_VARCHAR,CF_SQL_VARCHAR,CF_SQL_DECIMAL");
            var auxInserta = 1;
            var indicadores = ArrayNew(1);
            var valores = ArrayNew(2);
            var auxDistribucion =   rc.resultado.DISTRIBUCION[1];
            var auxNIND =           rc.resultado.NIND[1];
            var aux =0;
            var auxDatos = 1;
            var contador = 1;
            var res = 0;
            var obj =  Structnew();


            for(var i=1; i<=rc.resultado.RecordCount; i++){
                    if(auxDistribucion eq rc.resultado.DISTRIBUCION[i] and auxNIND eq rc.resultado.NIND[i]){
                        queryAddRow(auxQuery );
                        querySetCell(auxQuery, "CONJUNTO",        rc.resultado.CONJUNTO[i], auxInserta);
                        querySetCell(auxQuery, "DESCRIPCION",     rc.resultado.DESCRIPCION[i], auxInserta);
                        querySetCell(auxQuery, "DISTRIBUCION",    rc.resultado.DISTRIBUCION[i], auxInserta);
                        querySetCell(auxQuery, "INDICADOR",       rc.resultado.INDICADOR[i], auxInserta);
                        querySetCell(auxQuery, "NIND",            rc.resultado.NIND[i], auxInserta);
                        querySetCell(auxQuery, "NOMBRE",          rc.resultado.NOMBRE[i], auxInserta);
                        querySetCell(auxQuery, "PERIODO", rc.resultado.PERIODO[i], auxInserta);
                        querySetCell(auxQuery, "ICONO", rc.resultado.ICONO[i], auxInserta);
                        querySetCell(auxQuery, "CICLO", rc.resultado.CICLO[i], auxInserta);

                        valores [auxDatos][1]  = rc.resultado.INDICADOR[i];
                        valores [auxDatos][3]  = rc.resultado.PERIODO[i];

                        auxInserta++;
                        auxDatos++;

                        becas.addDimensionalData("Tiempo", aux,  LSParseNumber(rc.resultado.PERIODO[i]));
                        if(rc.resultado.INDICADOR[i] neq 0){
                        becas.addFactData(aux, LSParseNumber(rc.resultado.INDICADOR[i]));
                        }
                        aux ++;

                    }
                    else{

                         becas.estimateModel();
                         arrayAppend(indicadores,auxDistribucion);
                         becas.printEstimatedModel();
                         becas.computePredictionsAndMissing();
                        for(var j = 0; j < aux ; j++){
                              res = numberFormat(becas.getTendenceValueForSample(j), "99.99");
                              valores [j+1][2]  = numberFormat(res, "99.99");
                              querySetCell(auxQuery, "TENDENCIA", numberFormat(res, "99.99"), contador);
                        contador++;
                        }


                        aux = 0;
                        auxDatos = 1;
                        obj[auxDistribucion] = valores;

                        queryAddRow(auxQuery);
                        querySetCell(auxQuery, "CONJUNTO", rc.resultado.CONJUNTO[i], auxInserta);
                        querySetCell(auxQuery, "DESCRIPCION", rc.resultado.DESCRIPCION[i], auxInserta);
                        querySetCell(auxQuery, "DISTRIBUCION", rc.resultado.DISTRIBUCION[i], auxInserta);
                        querySetCell(auxQuery, "INDICADOR", rc.resultado.INDICADOR[i], auxInserta);
                        querySetCell(auxQuery, "NIND", rc.resultado.NIND[i], auxInserta);
                        querySetCell(auxQuery, "NOMBRE", rc.resultado.NOMBRE[i], auxInserta);
                        querySetCell(auxQuery, "PERIODO", rc.resultado.PERIODO[i], auxInserta);
                        querySetCell(auxQuery, "ICONO", rc.resultado.ICONO[i], auxInserta);
                        querySetCell(auxQuery, "CICLO", rc.resultado.CICLO[i], auxInserta);
                        auxInserta++;
                        becas = CreateObject("java","MineriaSII.LinearRegression");
                        becas.addDimensionalData("Tiempo", aux,  LSParseNumber(rc.resultado.PERIODO[i]) );
                        becas.addFactData(aux, LSParseNumber(rc.resultado.INDICADOR[i]));
                        valores [auxDatos][1]  = rc.resultado.INDICADOR[i];
                        valores [auxDatos][3]  = rc.resultado.PERIODO[i];
                        auxDatos++;
                        aux++;
                    }

                     if(i eq rc.resultado.RecordCount){
                         arrayAppend(indicadores,auxDistribucion);
                         becas.estimateModel();
                         becas.computePredictionsAndMissing();
                        for(var j = 0; j< aux ; j++){
                              res = numberFormat(becas.getTendenceValueForSample(j), "99.99");
                              valores [j+1][2]  = numberFormat(res, "99.99");
                              querySetCell(auxQuery, "TENDENCIA", numberFormat(res, "99.99"), contador);
                              contador++;
                        }
                        obj[auxDistribucion] = valores;
                      }

                auxDistribucion =   rc.resultado.DISTRIBUCION[i];
                auxNIND =           rc.resultado.NIND[i];
            }
|
            rc.datos = auxQuery;

            obj["indicadores"] = indicadores;
            var rc.obj = obj;
            var rc.js = SerializeJSON(obj);

            event.setView("indicadores/indicadores");
		</cfscript>
	</cffunction>


	<cffunction name="index2" access="public" returntype="void" output="false" hint="Indicadores obtenidos con los cálculos necesarios.">
		<cfargument name="event" type="any">
		<cfscript>
			var rc	= event.getCollection();
			var cn	= getModel("indicadores.CN_Indicadores");
			var rc.resultado = cn.getIndicadores();

            var becas = CreateObject("java","MineriaSII.LinearRegression");

            var auxQuery = QueryNew("CONJUNTO, DESCRIPCION, DISTRIBUCION, INDICADOR, NIND, NOMBRE, PERIODO,ICONO,CICLO,TENDENCIA", "CF_SQL_INTEGER,CF_SQL_VARCHAR, CF_SQL_VARCHAR, CF_SQL_DECIMAL,CF_SQL_VARCHAR,CF_SQL_VARCHAR,CF_SQL_VARCHAR,CF_SQL_VARCHAR,CF_SQL_VARCHAR,CF_SQL_DECIMAL");
            var auxInserta = 1;
            var indicadores = ArrayNew(1);
            var valores = ArrayNew(2);
            var auxDistribucion =   rc.resultado.DISTRIBUCION[1];
            var auxNIND =           rc.resultado.NIND[1];
            var aux =0;
            var auxDatos = 1;
            var contador = 1;
            var res = 0;
            var obj =  Structnew();


            for(var i=1; i<=rc.resultado.RecordCount; i++){
                    if(auxDistribucion eq rc.resultado.DISTRIBUCION[i] and auxNIND eq rc.resultado.NIND[i]){
                        queryAddRow(auxQuery );
                        querySetCell(auxQuery, "CONJUNTO",        rc.resultado.CONJUNTO[i], auxInserta);
                        querySetCell(auxQuery, "DESCRIPCION",     rc.resultado.DESCRIPCION[i], auxInserta);
                        querySetCell(auxQuery, "DISTRIBUCION",    rc.resultado.DISTRIBUCION[i], auxInserta);
                        querySetCell(auxQuery, "INDICADOR",       rc.resultado.INDICADOR[i], auxInserta);
                        querySetCell(auxQuery, "NIND",            rc.resultado.NIND[i], auxInserta);
                        querySetCell(auxQuery, "NOMBRE",          rc.resultado.NOMBRE[i], auxInserta);
                        querySetCell(auxQuery, "PERIODO", rc.resultado.PERIODO[i], auxInserta);
                        querySetCell(auxQuery, "ICONO", rc.resultado.ICONO[i], auxInserta);
                        querySetCell(auxQuery, "CICLO", rc.resultado.CICLO[i], auxInserta);

                        valores [auxDatos][1]  = rc.resultado.INDICADOR[i];
                        valores [auxDatos][3]  = rc.resultado.PERIODO[i];

                        auxInserta++;
                        auxDatos++;

                        becas.addDimensionalData("Tiempo", aux,  LSParseNumber(rc.resultado.PERIODO[i]));
                        if(rc.resultado.INDICADOR[i] neq 0){
                        becas.addFactData(aux, LSParseNumber(rc.resultado.INDICADOR[i]));
                        }
                        aux ++;

                    }
                    else{

                         becas.estimateModel();
                         arrayAppend(indicadores,auxDistribucion);
                         becas.printEstimatedModel();
                         becas.computePredictionsAndMissing();
                        for(var j = 0; j < aux ; j++){
                              res = numberFormat(becas.getTendenceValueForSample(j), "99.99");
                              valores [j+1][2]  = numberFormat(res, "99.99");
                              querySetCell(auxQuery, "TENDENCIA", numberFormat(res, "99.99"), contador);
                        contador++;
                        }


                        aux = 0;
                        auxDatos = 1;
                        obj[auxDistribucion] = valores;

                        queryAddRow(auxQuery);
                        querySetCell(auxQuery, "CONJUNTO", rc.resultado.CONJUNTO[i], auxInserta);
                        querySetCell(auxQuery, "DESCRIPCION", rc.resultado.DESCRIPCION[i], auxInserta);
                        querySetCell(auxQuery, "DISTRIBUCION", rc.resultado.DISTRIBUCION[i], auxInserta);
                        querySetCell(auxQuery, "INDICADOR", rc.resultado.INDICADOR[i], auxInserta);
                        querySetCell(auxQuery, "NIND", rc.resultado.NIND[i], auxInserta);
                        querySetCell(auxQuery, "NOMBRE", rc.resultado.NOMBRE[i], auxInserta);
                        querySetCell(auxQuery, "PERIODO", rc.resultado.PERIODO[i], auxInserta);
                        querySetCell(auxQuery, "ICONO", rc.resultado.ICONO[i], auxInserta);
                        querySetCell(auxQuery, "CICLO", rc.resultado.CICLO[i], auxInserta);
                        auxInserta++;
                        becas = CreateObject("java","MineriaSII.LinearRegression");
                        becas.addDimensionalData("Tiempo", aux,  LSParseNumber(rc.resultado.PERIODO[i]) );
                        becas.addFactData(aux, LSParseNumber(rc.resultado.INDICADOR[i]));
                        valores [auxDatos][1]  = rc.resultado.INDICADOR[i];
                        valores [auxDatos][3]  = rc.resultado.PERIODO[i];
                        auxDatos++;
                        aux++;
                    }

                     if(i eq rc.resultado.RecordCount){
                         arrayAppend(indicadores,auxDistribucion);
                         becas.estimateModel();
                         becas.computePredictionsAndMissing();
                        for(var j = 0; j< aux ; j++){
                              res = numberFormat(becas.getTendenceValueForSample(j), "99.99");
                              valores [j+1][2]  = numberFormat(res, "99.99");
                              querySetCell(auxQuery, "TENDENCIA", numberFormat(res, "99.99"), contador);
                              contador++;
                        }
                        obj[auxDistribucion] = valores;
                      }

                auxDistribucion =   rc.resultado.DISTRIBUCION[i];
                auxNIND =           rc.resultado.NIND[i];
            }
|
            rc.datos = auxQuery;

            obj["indicadores"] = indicadores;
            var rc.obj = obj;
            var rc.js = SerializeJSON(obj);

            event.setView("indicadores/tendencias");
		</cfscript>
	</cffunction>




	<cffunction name="datos" access="public" returntype="void" output="false" hint="Obtener datos.">
            <cfargument name="event" type="any">
            <cfscript>
                  var rc      = event.getCollection();
                  var cn      = getModel("indicadores.CN_Indicadores");
                  var rc.resultado = cn.getDatos(rc.nombre);
            </cfscript>
      </cffunction>

</cfcomponent>