package Minikin.Objects 
{
	import flash.geom.Point;
	import Minikin.Worlds.BaseWorld;
	import net.flashpunk.FP;
	import Minikin.Global.ImageManager;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class Cloud extends BaseObject 
	{
		public var mSprite:Image;
		
		public function Cloud() 
		{
			super();
			
			mVelocity = new Point( -Math.random() * 35+5, 0);
			x = (FP.world as BaseWorld).mCollisionGrid.width + 100;
			y = Math.random() * (FP.screen.height/2);
			
			mSprite = new Image(ImageManager.IMG_CLOUD);
			mSprite.smooth = true;
			
			graphic = mSprite;
			if (Math.random() > 0.25)
			{
				mSprite.scale = Math.max(Math.random(), .60);
				layer = 1499;
			}
			else
			{
				mSprite.scale = Math.max(Math.random()-0.25, .25);
				layer = 1501;
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			x += mVelocity.x*FP.elapsed;
			if (x < -300)
			{
				FP.world.remove(this);
			}
		}
		
	}

}