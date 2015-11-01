package partes 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Factura extends Sprite 
	{
	
		public function Factura(rut:String, numero:String, nombre:String, direccion_cliente:String , fecha:String, total_imp:String,
								total_sin_imp:String,tipo:String,ren:Object,comentario:String = "",origen:String = "") 
		{
			
			ruc_txt.text       =  rut.toUpperCase();
			numero_txt.text    =  numero.toUpperCase();
			nombre_txt.text    =  "Nombre     :   "+  nombre.toUpperCase();
			direccion_txt.text =  "Dirección   :   "+  direccion_cliente.toUpperCase();
			fecha_txt.text     =  "Fecha          :    " + formatDate(fecha.toUpperCase());
			total_txt.text     =  String(int((Number(total_imp)+Number(total_sin_imp))*100)/100);
			iva_txt.text       =  String(Math.round(parseFloat(total_imp)*100)/100);
			comentario_txt.text = comentario;
			origen_txt.text = origen;
			tipo_txt.text      =  tipo.toUpperCase();
			var descuento:String = "0";
			var sub_total:Number = 0;
			trace("largo del renglon " + ren.length);
			for (var i:String in ren) {
				trace(ren[i]["codigo"], ren[i]["cantidad"],	ren[i]["descripcion"], ren[i]["precio"], ren[i]["total"])
				if(String(Number(ren[i]["cantidad"])) != "NaN")
					sub_total += Number(ren[i]["cantidad"]) * Number(ren[i]["precio"]) ;
				else
					sub_total += Number(ren[i]["total"]) ;
				try 
				{
					
					var renglon:Renglon = new Renglon(ren[i]["codigo"], ren[i]["cantidad"],
					ren[i]["descripcion"], ren[i]["precio"], ren[i]["total"],ren[i]["comercializable_id"]);
					renglon.x = 32;
					renglon.y = 195 + 15 * Number(i);
					
					descuento = Math.max(Number(ren[i]["descuento"]), Number(descuento)).toString();
					trace("agrego renglon = "+renglon.y);
					this.addChild(renglon);
				}catch (err:Error)
				{
					trace("faking error");
				}
			}
			sub_total_txt.text =  String(Math.round(sub_total * 100) / 100);
			descuento_txt.text = String(Math.round((sub_total - parseFloat(total_sin_imp)) * 100) / 100);
			
		}
		
		private function formatDate(date:String):String {
			var result:Array = date.split("-");
			return result[2] + "/" + result[1] + "/" + result[0];
		}
		
	}

}