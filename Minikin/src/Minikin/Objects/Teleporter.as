package Minikin.Objects 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class Teleporter extends Entity 
	{
		
		public var mZone:String;
		public var mTelePoint:Point;
		
		public function Teleporter(_x:int, _y:int, _width:int, _height:int, _zone:String, _teleX:int, _teleY:int) 
		{
			super();
			
			x = _x;
			y = _y;
			
			setHitbox(_width, _height, 0, 0);
			
			type = "Teleport";
			
			mZone = _zone;
			mTelePoint = new Point(_teleX, _teleY);
		}
		
	}

}