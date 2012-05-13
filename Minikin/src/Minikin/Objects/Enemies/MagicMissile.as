package Minikin.Objects.Enemies 
{
	import net.flashpunk.graphics.Spritemap;
	import Minikin.Global.ImageManager;
	import net.flashpunk.FP;
	import Minikin.Global.GameDetails;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class MagicMissile extends Enemy 
	{
		
		public function MagicMissile() 
		{
			mSprite = new Spritemap(ImageManager.IMG_MAGICMISSILE,8, 8);
			mSprite.centerOO();
			
			type = "Enemy";
			mDamage = 7;
			
			graphic = mSprite;
		}
		
		override public function update():void 
		{
			super.update();
			
			x += mVelocity.x*FP.elapsed;
			y += mVelocity.y*FP.elapsed;
			
			if (x < -100 || x > 4000)
			{
				FP.world.remove(this);
			}
		}
		
	}

}