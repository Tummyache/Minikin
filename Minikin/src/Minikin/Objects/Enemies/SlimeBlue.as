package Minikin.Objects.Enemies 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import Minikin.Objects.Sword;
	import Minikin.Worlds.BaseWorld;
	import net.flashpunk.graphics.Spritemap;
	import Minikin.Global.ImageManager;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import Minikin.Global.GameDetails;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class SlimeBlue extends Enemy 
	{
		public var mIsHurt:Boolean;
		public var mIsDiving:Boolean;
		public var mFlySpot:Point;
		public var mOriginPoint:Point;
		public var mHitTimer:Timer;
		public var mDiveTimer:Timer;
		
		public function SlimeBlue() 
		{
			super();
			
			mSprite = new Spritemap(ImageManager.IMG_SLIME_BLUE, 24, 24);
			mSprite.add("Fly", [0,1,2,1], 10);
			mSprite.add("Dive", [0], 10, true);
			
			mSprite.play("Fly");
			
			graphic = mSprite;
			mFlySpot = new Point();
			
			mHealth = 10;
			
			mHitTimer = new Timer(200);
			mHitTimer.addEventListener(TimerEvent.TIMER, StopHurting);
			
			setHitbox(16, 16, 8, 9);
			mSprite.centerOO();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (mFlySpot.x == 0 || Point.distance(new Point(x,y), mFlySpot) < 20)
			{
				mSprite.play("Fly");
				mOriginPoint = new Point(x, y);
				mIsDiving = false;
				newFlySpot();
			}
			
			if (Math.abs(GameDetails.GetInstance().mPlayer.x - x) < 50 && mIsDiving == false )
			{
				mIsDiving = true;
				mVelocity.y = 200;
				mVelocity.x = 0;
				mSprite.play("Dive");
			}
			if (Math.abs(GameDetails.GetInstance().mPlayer.x - x) > 50)
			{
				mIsDiving = false;
			}

			if (collide("Level", x + mVelocity.x * FP.elapsed, y))
			{
				mVelocity.x = 0;
				newFlySpot();
			}

			if (mVelocity.x > 0) mSprite.scaleX = 1;
			if (mVelocity.x < 0) mSprite.scaleX = -1;
			
			x += mVelocity.x*FP.elapsed;
			y += mVelocity.y * FP.elapsed;
			
			
			var other:Entity = collide("Level", x, y);
			if (collide("Level", x, y)) {
				trace("Collided");
				while (collideWith(other, x, y))
				{
					y += -FP.sign(mVelocity.y);
					x += -FP.sign(mVelocity.x);
				}
				if (mVelocity.y > 0)
				{
					mSprite.play("Fly");
				}
				newFlySpot();
			}
			else
			{
			}
			
			var otherSword:Sword = collide("Sword", x, y) as Sword;
			if (otherSword)
			{
				mVelocity.x = FP.sign(x - otherSword.x) * 200;
				mVelocity.y = -100;
				if (mIsHurt == false)
				{
					mHealth -= otherSword.Damage();
					mIsHurt = true;
					mSprite.alpha = 0.5;
					mHitTimer.start();
					if (mHealth <= 0)
					{
						FP.world.remove(this);
					}
				}
			}
		}
		
		private function newFlySpot():void
		{
			mFlySpot.x = mOriginPoint.x + Math.random()*200 - Math.random()*200;
			mFlySpot.y = mOriginPoint.y + Math.random()*50 - Math.random()*50;
			mVelocity.x = (mFlySpot.x - x) / Point.distance(mFlySpot, new Point(x, y)) * 40;
			mVelocity.y = (mFlySpot.y - y) / Point.distance(mFlySpot, new Point(x, y)) * 40;
		}
		
		public function StopHurting(e:Event):void
		{
			mHitTimer.stop();
			mHitTimer.reset();
			newFlySpot();
			mSprite.alpha = 1.0;
			mSprite.play("Fly");
			mIsHurt = false;
		}
		
		override public function CleanUp():void 
		{
			super.CleanUp();
			
		}
	}

}