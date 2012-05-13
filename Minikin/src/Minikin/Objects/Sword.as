package Minikin.Objects 
{
	import flash.display.Sprite;
	import net.flashpunk.graphics.Image;
	import Minikin.Global.ImageManager;
	import net.flashpunk.FP;
	import Minikin.Global.GameDetails;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class Sword extends BaseObject
	{
		public var mRotVelocity:Number;
		public var mFlipped:Boolean;
		public var mSprite:Image;
		
		public function Sword(flipped:Boolean) 
		{
			if (GameDetails.GetInstance().mCurrentSword == 0) mSprite = new Image(ImageManager.IMG_SWORD);
			else if (GameDetails.GetInstance().mCurrentSword == 1) mSprite = new Image(ImageManager.IMG_SWORD_LONG);
			else if (GameDetails.GetInstance().mCurrentSword == 2) mSprite = new Image(ImageManager.IMG_SWORD_BIG);
			else if (GameDetails.GetInstance().mCurrentSword == 3) mSprite = new Image(ImageManager.IMG_SWORD_GIANT);
			else mSprite = new Image(ImageManager.IMG_SWORD_KAISER);
			
			mSprite.angle = (flipped ? 0 : 180);
			mSprite.originX = -3;
			mSprite.originY = mSprite.height/2+1;
			
			mVelocity.x = (flipped ? -15 : 15);
			
			graphic = mSprite;
			mSprite.smooth = true;
			
			mFlipped = flipped;
			mRotVelocity = (flipped ? 900 : -900);
			
			type = "Sword";
			
			//setHitbox(mSprite.width, mSprite.height*2, (flipped ? -10 : mSprite.width+10), mSprite.height);
		}
	
		override public function update():void 
		{
			super.update();
			
			x += mVelocity.x * FP.elapsed;
			
			if (mSprite.angle >= 130)
			{
				setHitbox(mSprite.width, (mSprite.height+mSprite.width)/1.5,  mSprite.width+10, mSprite.width/2);
			}
			else if (mSprite.angle <= 20)
			{
				setHitbox(mSprite.width, (mSprite.height+mSprite.width)/1.5, -10, mSprite.width/2);
			}
			else
			{
				setHitbox((mSprite.height+mSprite.width)/2, mSprite.width, 16, mSprite.width);
			}
			
			mSprite.angle += mRotVelocity * FP.elapsed;
			if ((!mFlipped && mSprite.angle <= -30) || (mFlipped && mSprite.angle >= 210))
			{
				FP.world.remove(this);
			}
		}
		
		public function Damage():int
		{
			var base:int;
			var variance:int;
			if (GameDetails.GetInstance().mCurrentSword == 0)
			{
				base = 2;
				variance = 2;
			}
			else if (GameDetails.GetInstance().mCurrentSword == 1)
			{
				base = 4;
				variance = 2;
			}
			else if (GameDetails.GetInstance().mCurrentSword == 2)
			{
				base = 5;
				variance = 4;
			}
			else if (GameDetails.GetInstance().mCurrentSword == 3)
			{
				base = 9;
				variance = 6;
			}
			else if (GameDetails.GetInstance().mCurrentSword == 4)
			{
				base = 15;
				variance = 10;
			}
			return base + Math.round(Math.random() * variance);
		}
	}

}