package Minikin.Objects 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class BaseObject extends Entity
	{
		public var mVelocity:Point;
		
		public function BaseObject() 
		{
			mVelocity = new Point(0, 0);
		}
		
		public function CleanUp():void
		{
			
		}
	}

}