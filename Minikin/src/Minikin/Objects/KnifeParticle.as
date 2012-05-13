package Minikin.Objects 
{
	import flash.geom.Point;
	import net.flashpunk.graphics.Spritemap;
	import Minikin.Global.ImageManager;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class KnifeParticle extends BaseObject
	{
		public var mSprite:Spritemap;
		
		public function KnifeParticle() 
		{
			mSprite = new Spritemap(ImageManager.IMG_KNIFE, 8, 8);
			mSprite.add("Idle", [0], 10);
			mSprite.play("Idle");
			mSprite.centerOO();
			graphic = mSprite;
			
			mVelocity = new Point(Math.random() * 300 - Math.random() * 300, - Math.random() * 300 -500);
		}
		
		override public function update():void 
		{
			super.update();
			
			x += mVelocity.x * FP.elapsed;
			y += mVelocity.y * FP.elapsed;
			
			mSprite.angle = FP.angle(0, 0, mVelocity.x, mVelocity.y);
			
			mVelocity.y += 800 * FP.elapsed;
			
			if (y > 2000)
			{
				FP.world.remove(this);
			}
		}
		
	}

}