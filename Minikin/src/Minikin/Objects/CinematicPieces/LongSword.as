package Minikin.Objects.CinematicPieces 
{
	import flash.geom.Point;
	import Minikin.Objects.BaseObject;
	import net.flashpunk.graphics.Image;
	import Minikin.Global.ImageManager;
	import net.flashpunk.FP;
	import Minikin.Global.GameDetails;
	
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class LongSword extends BaseObject 
	{
		public var mSprite:Image;
		public var mStopped:Boolean;
		
		public function LongSword(sword:Class, _type:String) 
		{
			mSprite = new Image(sword);
			graphic = mSprite;
			
			mSprite.centerOO();
			setHitbox(mSprite.height, mSprite.width-5, mSprite.height / 2, mSprite.width / 2+5);
			
			layer = 1001;
			
			type = _type;
			
			mVelocity = new Point(0, -1000);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (mStopped == false)
			{
				x += mVelocity.x * FP.elapsed;
				y += mVelocity.y * FP.elapsed;
				mSprite.angle += 460 * FP.elapsed;
				mVelocity.y += 1000 * FP.elapsed;
				
				if (Math.abs(400-x) > 30)
					mVelocity.x = FP.sign(400 - x) * 200;
				else
					mVelocity.x = 0;
			}
			
			if (collide("Player", x, y))
			{
				if (type == "LongSword") GameDetails.GetInstance().mHasLongSword = true;
				else if (type == "BroadSword") GameDetails.GetInstance().mHasBroadSword = true;
				else if (type == "HolySword") GameDetails.GetInstance().mHasHolySword = true;
				else if (type == "KaiserSword") GameDetails.GetInstance().mHasKaiserSword = true;
				FP.world.remove(this);
				GameDetails.GetInstance().mHealth = GameDetails.GetInstance().mMaxHealth;
			}
			
			if (mStopped == false && collide("Level", x, y))
			{
				mStopped = true;
				mVelocity.y = 0;
				mSprite.angle = 270;
				while (collide("Level", x, y))
				{
					y -= 1;
				}
			}
		}
		
	}

}