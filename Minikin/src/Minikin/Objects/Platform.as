package Minikin.Objects 
{
	import Minikin.Global.ImageManager;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class Platform extends BaseObject 
	{
		
		public function Platform(_x:int, _y:int, _width:int) 
		{
			x = _x;
			y = _y;
			
			var layers:Graphiclist = new Graphiclist();
			var img:Image = Image.createRect(_width + 2, 6, 0x000000, 1.0);
			img.x = -1;
			img.y = -1;
			layers.add(img);
			layers.add(Image.createRect(_width, 4, 0x8B4513, 1.0));
			
			graphic = layers;
			setHitbox(_width, 20, 0, 0);
			
			type = "Platform";
		}
		
	}

}