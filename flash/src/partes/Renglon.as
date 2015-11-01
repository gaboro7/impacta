package partes 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Renglon extends MovieClip 
	{
		public function Renglon(codigo:String, cantidad:String,
		                        descripcion:String, precio:String,
								total:String, comercializable_id:String = "" ) 
		{
			codigo_txt.text = codigo.toUpperCase();
			cantidad_txt.text = cantidad.toUpperCase();
			articulo_txt.text =  descripcion.toUpperCase();
			unitario_txt.text = precio.toUpperCase();
			if(String(Number(cantidad)) != "NaN")
				total_txt.text = String( String(Math.round((Number(cantidad) * Number(precio)) * 100) / 100)) ;//total.toUpperCase();
			else
				total_txt.text = (total) ;//total.toUpperCase();
		}
		
	}

}