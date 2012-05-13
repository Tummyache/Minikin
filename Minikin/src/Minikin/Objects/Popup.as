package Minikin.Objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import Minikin.Global.ImageManager;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class Popup extends Entity
	{
		public var mSprite:Image;
		
		public function Popup()
		{
			mSprite = new Image(ImageManager.IMG_DEF_UP);
			mSprite.scale = 0.0;
			
			graphic = mSprite;
			mSprite.centerOO();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (mSprite.alpha == 1.0)
			{
				mSprite.scale += 5.0 * FP.elapsed;
			}
			if (mSprite.scale > 1.3)
			{
				mSprite.alpha -= 2.0 * FP.elapsed;
			}
			
			if (mSprite.alpha <= 0.0)
			{
				FP.world.remove(this);
			}
		}
		
	}

}