package Minikin.Objects.Enemies 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Minikin.Objects.Sword;
	import net.flashpunk.graphics.Spritemap;
	import Minikin.Global.ImageManager;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class Slime extends Enemy 
	{
		public var mAttackTimer:Timer;
		public var mIsHurt:Boolean;
		
		public function Slime() 
		{
			super();
			
			mSprite = new Spritemap(ImageManager.IMG_SLIME, 16, 16);
			mSprite.add("Stand", [0]);
			mSprite.add("Readying", [0, 1], 10, true);
			mSprite.add("Attacking", [2, 3], 10, true);
			
			mSprite.play("Stand");
			
			mAttackTimer = new Timer(Math.random() * 2000 + 1000, 0);
			mAttackTimer.addEventListener(TimerEvent.TIMER, Attack);
			mAttackTimer.start();
			
			graphic = mSprite;
			
			mHealth = 6;
			
			setHitbox(16, 16, 8, 9);
			mSprite.centerOO();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (collide("Level", x + mVelocity.x * FP.elapsed, y))
			{
				mVelocity.x = 0;
			}
			
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
					if (mVelocity.y > 16 * (1 / FP.elapsed))
					{
						mVelocity.y = 16 * (1 / FP.elapsed);
					}
				}
			}
			
			other = collide("Platform", x, y+1);
			if (mVelocity.y > 0 && other && other.y+10 > y + 6)
			{
				mIsHurt = false;
				mSprite.alpha = 1.0;
				mSprite.play("Stand");
				while (collideWith(other, x, y))
				{
					y += -FP.sign(mVelocity.y);
				}
				mVelocity.y = 0;
				mVelocity.x = 0;
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
			
			if ( y >= 2000)
			{
				FP.world.remove(this);
			}
		}
		
		private function Attack(e:Event):void
		{
			mVelocity.x = (Math.random() - Math.random()) * 200;
			y -= 1;
			mVelocity.y = -400;
			
			mSprite.play("Attacking");
			
			mAttackTimer.reset();
			mAttackTimer.delay = Math.random() * 2000 + 1000;
			mAttackTimer.start();
		}
		
		override public function CleanUp():void 
		{
			super.CleanUp();
			
			mAttackTimer.stop();
			mAttackTimer = null;
		}
	}

}