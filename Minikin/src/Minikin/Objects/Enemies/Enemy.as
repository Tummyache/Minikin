package Minikin.Objects.Enemies 
{
	import flash.geom.Point;
	import Minikin.Objects.BaseObject;
	import net.flashpunk.graphics.Spritemap;
	import Minikin.Global.ImageManager;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class Enemy extends BaseObject
	{
		public var mSprite:Spritemap;
		public var mHealth:int;
		public var mDamage:int;
		
		public function Enemy() 
		{
			type = "Enemy";
			
			mDamage = 1;
			
			mVelocity = new Point(0, -1);
		}
		
		override public function update():void 
		{
			super.update();
			
			
		}
		
	}

}