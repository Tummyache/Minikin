package Minikin.Objects.Enemies 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import Minikin.Global.ImageManager;
	import net.flashpunk.Entity;
	import Minikin.Objects.Sword;
	import Minikin.Global.GameDetails;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class Ghoul extends Enemy 
	{
		public var mIsHurt:Boolean;
		
		public var mWanderTimer:Timer;
		public var mChasing:Boolean;
		public var mIsJumping:Boolean;
		
		public function Ghoul() 
		{
			mSprite = new Spritemap(ImageManager.IMG_GHOUL, 24, 24);
			mSprite.add("Stand", [0]);
			mSprite.add("Walk", [0, 1, 0, 2], 10);
			
			mSprite.play("Stand");
			mSprite.centerOO();
			
			mWanderTimer = new Timer(1000 * Math.random() * 1000);
			mWanderTimer.addEventListener(TimerEvent.TIMER, Wander);
			Wander(null);
			
			graphic = mSprite;
			
			mDamage = 7;
			mHealth = 20;
			
			mVelocity = new Point(0, -1);
			
			setHitbox(16, 16, 8, 5);
		}
		
		override public function update():void 
		{
			if (Math.abs(mVelocity.x) > 3)
			{
				mSprite.play("Walk");
			}
			
			if (Math.abs(x - GameDetails.GetInstance().mPlayer.x) < 100)
			{
				mChasing = true;
			}
			if (mChasing == true && mIsHurt == false)
			{
				mVelocity.x = FP.sign(GameDetails.GetInstance().mPlayer.x - x) * 120;
				if (Math.abs(x - GameDetails.GetInstance().mPlayer.x) > 50 && Math.abs((x+mVelocity.x*FP.elapsed)-GameDetails.GetInstance().mPlayer.x) < 50 && mIsJumping == false)
				{
					mIsJumping = true;
					mVelocity.x *= 2.0;
					mVelocity.y = -300;
				}
			}
			
			if (collide("Level", x + mVelocity.x * FP.elapsed, y))
			{
				mVelocity.x = 0;
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
				}
				if (mVelocity.y > 0)
				{
					mIsHurt = false;
					mSprite.alpha = 1.0;
					mIsJumping = false;
					mSprite.play("Stand");
				}
				mVelocity.y = 0;
				mVelocity.x = 0;
			}
			else
			{
				if (!collide("Level", x, y + 1))
				{
					mVelocity.y += 2000 * FP.elapsed;
				}
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
					if (mHealth <= 0)
					{
						FP.world.remove(this);
					}
				}
			}
			
			super.update();
		}
		
		private function Wander(e:Event):void
		{
			if (Math.random() > 0.5)
			{
				mVelocity.x = 15;
			}
			else
			{
				mVelocity.x = -15;
			}
			mWanderTimer.reset();
			mWanderTimer.delay = 1000 + Math.random() * 500;
			mWanderTimer.start();
		}
		
		override public function CleanUp():void 
		{
			mWanderTimer.stop();
			mWanderTimer = null;
			
			super.CleanUp();
		}
		
	}

}