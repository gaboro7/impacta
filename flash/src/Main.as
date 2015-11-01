package 
{
	import com.adobe.serialization.json.JSON;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	import flash.utils.setTimeout;
	import partes.Cabezal;
	import partes.Factura;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Main extends Sprite 
	{
		private var loader:URLLoader;
		private var data:Object;
		private var paramObj:Object;
		private var tipo:String;
		private var config:Number = 0;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			loader = new URLLoader();
            configureListeners(loader);
			var myFlashVar:Object
			var varName:String;
			paramObj = LoaderInfo(this.root.loaderInfo).parameters;
			/*for (varName in paramObj) {
				myFlashVar = String(paramObj[varName]);
			}*/
			var pre = "";
		    if(paramObj['id'] == undefined){
				paramObj['id'] = 10240;
				paramObj['tipo_factura'] = "RECIBO";
				pre = "http://localhost:3000/"
				paramObj['controler'] = "notadecreditos";
				paramObj['configuracion'] = 0;
			}
			tipo = 	paramObj['controler'];
			if (paramObj['configuracion'])
				config = Number(paramObj['configuracion']);
			trace ("http://localhost:3000/"+paramObj['controler']+"/"+paramObj['id']+".json");
            var request:URLRequest = new URLRequest(pre + "/"+paramObj['controler']+"/"+paramObj['id']+".json");
		
            try {
                loader.load(request);
            } catch (error:Error) {
                trace("Unable to load requested document.");
            }
			// entry point
		}
		
		private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }
		
		private function normalizarRenglones(renglon:Object):Array {
			var retornable:Array = new Array();
			for (var i:String in renglon) {
				var o:Object = new Object();
				switch(tipo)
					{
						case "facturas":
							o["codigo"] = (renglon[i]["comercializable_id"]==undefined)?"____":renglon[i]["comercializable_id"];
							o["cantidad"] = (renglon[i]["cantidad"]==undefined)?"____":renglon[i]["cantidad"];
							o["descripcion"] = (renglon[i]["nombrearticulo"]==undefined)?renglon[i]["detalle"]:renglon[i]["nombrearticulo"];
							o["precio"] = (renglon[i]["precio_unitario"]==undefined)?"____":renglon[i]["precio_unitario"];
							o["total"] = (renglon[i]["total_renglon"]==undefined)?"____":renglon[i]["total_renglon"];
							o["descuento"] = (renglon[i]["descuento"] == undefined)?"0":renglon[i]["descuento"];
							o["comercializable_id"] = (renglon[i]["comercializable_id"] == undefined)?"0":renglon[i]["comercializable_id"];
							if (o["descripcion"] == undefined)
								o["descripcion"] = "____";
							break;
						case "recibos":
							trace("factura id "+renglon[i]["documento_id"]);
							o["codigo"] = (renglon[i]["documento_id"] == undefined)?"____":renglon[i]["documento_id"];
							o["codigo"] += (renglon[i]["documento_type"]==undefined)?"    ____": "     "+ renglon[i]["documento_type"];
							o["precio"] = (renglon[i]["total_impuestos"]==undefined)?"____":renglon[i]["total_impuestos"];
							o["total"] = (renglon[i]["total_renglon"] == undefined)?"_____":renglon[i]["total_renglon"];
							o["cantidad"] = "";
							o["descripcion"] =  (renglon[i]["comercializable_id"]==undefined)?"____":renglon[i]["comercializable_id"] + " " +(renglon[i]["detalle"] == undefined)?"_____":renglon[i]["detalle"];
							o["comercializable_id"] = (renglon[i]["comercializable_id"] == undefined)?"0":renglon[i]["comercializable_id"];
							o["descuento"] = "";
							break;
						case "notadecreditos":
							if (renglon[i]["factura_id"] != undefined) {
								trace("------------------------------------------------------------------");
								trace(renglon[i]["comercializable_id"]);
								trace(renglon[i]["nombrearticulo"]);
								trace("------------------------------------------------------------------");
								o["codigo"] = (renglon[i]["comercializable_id"]==undefined)?"":renglon[i]["comercializable_id"];
								o["cantidad"] = (renglon[i]["cantidad"]==undefined)?"____":renglon[i]["cantidad"];
								o["descripcion"] = (renglon[i]["nombrearticulo"]==undefined)?renglon[i]["detalle"]:renglon[i]["nombrearticulo"];
								o["precio"] = (renglon[i]["precio_unitario"]==undefined)?"____":renglon[i]["precio_unitario"];
								o["total"] = (renglon[i]["total_renglon"]==undefined)?"____":renglon[i]["total_renglon"];
								o["descuento"] = (renglon[i]["descuento"] == undefined)?"0":renglon[i]["descuento"];
								o["comercializable_id"] = (renglon[i]["comercializable_id"] == undefined)?"0":renglon[i]["comercializable_id"];
								trace(o["descripcion"]);
								if (o["descripcion"] == undefined)
									o["descripcion"] = "____";
							}else {
								trace("------------------------------------------------------------------");
								trace(renglon[i]["comercializable_id"]);
								trace(renglon[i]["nombrearticulo"]);
								trace("------------------------------------------------------------------");
								o["codigo"] = (renglon[i]["comercializable_id"]==undefined)?"":renglon[i]["comercializable_id"];;
								o["cantidad"] = (renglon[i]["cantidad"]==undefined)?"____":renglon[i]["cantidad"];
								o["descripcion"] = (renglon[i]["nombrearticulo"]==undefined)?renglon[i]["detalle"]:renglon[i]["nombrearticulo"];
								o["precio"] = (renglon[i]["precio_unitario"]==undefined)?"____":renglon[i]["precio_unitario"];
								o["total"] = (renglon[i]["total_renglon"]==undefined)?"____":renglon[i]["total_renglon"];
								o["descuento"] = (renglon[i]["descuento"] == undefined)?"0":renglon[i]["descuento"];
								if (o["descripcion"] == undefined)
									o["descripcion"] = "____";
									
								o["comercializable_id"] = (renglon[i]["comercializable_id"] == undefined)?"0":renglon[i]["comercializable_id"];
							}
							break;
						case "notadedebitos":
							o["codigo"] = (renglon[i]["factura_id"]==undefined)?"____":renglon[i]["factura_id"];
							o["cantidad"] = (renglon[i]["cantidad"]==undefined)?"____":renglon[i]["cantidad"];
							o["descripcion"] = (renglon[i]["comercializable_id"]==undefined)?"____":renglon[i]["comercializable_id"] + " " +(renglon[i]["nombrearticulo"]==undefined)?renglon[i]["detalle"]:renglon[i]["nombrearticulo"];
							o["precio"] = (renglon[i]["precio_unitario"]==undefined)?"____":renglon[i]["precio_unitario"];
							o["total"] = (renglon[i]["total_renglon"]==undefined)?"____":renglon[i]["total_renglon"];
							o["descuento"] = (renglon[i]["descuento"] == undefined)?"0":renglon[i]["descuento"];
							o["comercializable_id"] = (renglon[i]["comercializable_id"] == undefined)?"0":renglon[i]["comercializable_id"];
							if (o["descripcion"] == undefined)
								o["descripcion"] = "____";
							break;
						break;
					}
				retornable.push(o);
			}
			trace("retornable largo" + retornable.length);
			return retornable;
		}

        private function completeHandler(event:Event):void {
            var loader:URLLoader = URLLoader(event.target);
            trace(loader.data);
            data = JSON.decode(loader.data );
			trace(data["renglon_facturas"]);
			var renglones:Array = new Array();
	
			renglones = renglones.concat(normalizarRenglones(data["renglon_facturas"]));
			renglones = renglones.concat(normalizarRenglones(data["renglon_factdetalles"]));
			renglones = renglones.concat(normalizarRenglones(data["renglon_recdetalles"]));
			renglones = renglones.concat(normalizarRenglones(data["renglon_ndcdetalles"]));
			renglones = renglones.concat(normalizarRenglones(data["renglon_ndcndds"]));
			renglones = renglones.concat(normalizarRenglones(data["renglon_ndddetalles"]));
			renglones = renglones.concat(normalizarRenglones(data["renglon_recibo_docs"]));
			renglones = renglones.concat(normalizarRenglones(data["renglon_nddndcs"]));
			renglones = renglones.concat(normalizarRenglones(data["renglon_ndc_articulos"]));
			
			trace("renglones " + renglones.length);
			var nombre:String =  data["comerciante"]["nombrefiscal"]
			if (data["sucursal"]) {
				if (config == 0)
					nombre = data["sucursal"]["nombre"];
				else
					nombre += "  "+ data["sucursal"]["nombre"] ;
			}
			trace("el numero es " +  data["numero"]);
			if ( data["numero"] == null)
				data["numero"] = "";
			var factura:Factura = new Factura(data["rut"], data["numero"],nombre, data["direccion_cliente"],
			data["fecha"],data["total_impuestos"],data["total_sinimpuestos"],paramObj['tipo_factura'],renglones,data["detalle"],"(1) ORIGINAL CLIENTE");
			var factura1:Factura = new Factura(data["rut"], data["numero"], nombre, data["direccion_cliente"],
			data["fecha"],data["total_impuestos"],data["total_sinimpuestos"],paramObj['tipo_factura'],renglones,data["detalle"],"(2) ARCHIVO");
		
			var cabezal:MovieClip = new Cabezal();
			cabezal.x = 20.5;
			//cabezal.y = 185;
			switch(tipo)
				{case "facturas":
					
					break;
				case "recibos":
					cabezal.col1_txt.text = "Número Factura";
					cabezal.col2_txt.text = "";
					cabezal.col3_txt.text = "Detalle";
					cabezal.col4_txt.text = "IMP";
					cabezal.col5_txt.text = "TOTAL";
					break;
				case "notadecreditos":
					cabezal.col1_txt.text = "Codigo";
					cabezal.col2_txt.text = "Cant";
					cabezal.col3_txt.text = "Detalle";
					cabezal.col4_txt.text = "IMP";
					cabezal.col5_txt.text = "TOTAL";
					break;
				case "notadedebitos":
					cabezal.col1_txt.text = "N° Documento";
					
					break;
				
				}
			var cabezal1:MovieClip = new Cabezal();
			cabezal1.x = 20.5;
			cabezal1.y = cabezal.y;
			switch(tipo)
				{case "facturas":
					
					break;
				case "recibos":
					cabezal1.col1_txt.text = "Número Factura";
					cabezal1.col2_txt.text = "";
					cabezal1.col3_txt.text = "Detalle";
					cabezal1.col4_txt.text = "IMP";
					cabezal1.col5_txt.text = "TOTAL";
					break;
				case "notadecreditos":
					cabezal1.col1_txt.text = "Número Factura";
					cabezal1.col2_txt.text = "Cant";
					cabezal1.col3_txt.text = "Detalle";
					cabezal1.col4_txt.text = "IMP";
					cabezal1.col5_txt.text = "TOTAL";
					break;
				case "notadedebitos":
					cabezal1.col1_txt.text = "N° Documento";
					
					break;
				
				}
				
			//factura.y = factura.y -30;
			//factura.x = factura.x -30;
			factura.addChild(cabezal);
			trace("factura height  "+factura.height);
			this.addChild(factura);
			factura1.addChild(cabezal1);
			factura1.y = factura.height + 45;
			factura.addChild(factura1);
			print(factura);
			/*setTimeout(function(){
				var printJob:PrintJob = new PrintJob();
				if (printJob.start()) {
					printJob.addPage(factura);
					printJob.send();
					
					
				}
				trace("llamo");
				ExternalInterface.call("recargardespuesdeimprimir", "");	
			},1000);*/
		}
		
		private function print(clip:Sprite) {
			if (!clip) return;//safety

			var printJob:PrintJob = new PrintJob();
			var jobOptions:PrintJobOptions = new PrintJobOptions();     
			/*jobOptions.printAsBitmap=true;
			var numPages:int = 0;
			var printArea:Rectangle;
			var printHeight:Number;
			var printY:int = 0;
			*/
			if (stage)
				stage.addChild(clip);//add to stage for print

			
			if ( printJob.start() ) {

				/* Resize movie clip to fit within page width */
				/*if (clip.width > printJob.pageWidth) {
					clip.width = printJob.pageWidth;
					clip.scaleY = clip.scaleX;
				}*/

				/* Store reference to print area in a new variable! Will save on scaling calculations later... */
				//printArea = new Rectangle(0, 0, printJob.pageWidth/clip.scaleX, printJob.pageHeight/clip.scaleY);

				//numPages = Math.ceil(clip.height / printJob.pageHeight);

				/* Add pages to print job */
			//	for (var i:int = 0; i < numPages; i++) {
					//printJob.addPage(clip, printArea);
					printJob.addPage(clip, null, null);
					//printArea.y += printArea.height;
			//	}
				
				/* Send print job to printer */
				printJob.send();
				
				/* Delete job from memory */
				printJob = null;
					
			}
			ExternalInterface.call("recargardespuesdeimprimir", "");

			if (stage && stage.contains(clip))
				stage.removeChild(clip);//once done remove from stage

		}
		
        private function openHandler(event:Event):void {
            trace("openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
            trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }
		
	}
	
}