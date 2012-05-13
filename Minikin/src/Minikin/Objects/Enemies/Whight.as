package Minikin.Objects.Enemies 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import Minikin.Objects.CinematicPieces.LongSword;
	import Minikin.Objects.GhostParticle;
	import Minikin.Objects.NPC;
	import net.flashpunk.graphics.Spritemap;
	import Minikin.Global.ImageManager;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import Minikin.Objects.Sword;
	import Minikin.Global.GameDetails;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class Whight extends Enemy 
	{
		public var mAttackTimer:Timer;
		public var mAttackType:int;
		public var mShootTimer:Timer;
		public var mHurtTimer:Timer;
		public var mIsHurt:Boolean;
		public var mTeleportTimer:Timer;
		
		public function Whight() 
		{
			mSprite = new Spritemap(ImageManager.IMG_WHIGHT, 24, 24);
			mSprite.add("Stand", [0]);
			mSprite.add("Float", [1]);
			
			mSprite.play("Stand");
			
			mSprite.centerOO();
			setHitbox(16, 16, 8, 5);
			
			mVelocity = new Point();
			
			mHealth = 80;
			mDamage = 5;
			
			mAttackTimer = new Timer(1000+Math.random()*666);
			mAttackTimer.addEventListener(TimerEvent.TIMER, PickAttack);
			mAttackTimer.start();
			
			mTeleportTimer = new Timer(1000);
			mTeleportTimer.addEventListener(TimerEvent.TIMER, StartTeleport);
			
			mHurtTimer = new Timer(200);
			mHurtTimer.addEventListener(TimerEvent.TIMER, StopHurting);
			
			mShootTimer = new Timer(500 + Math.random() * 500);
			mShootTimer.addEventListener(TimerEvent.TIMER, ShootMissile);
			
			graphic = mSprite;
		}
		
		override public function update():void 
		{
			super.update();
			
			x += mVelocity.x*FP.elapsed;
			y += mVelocity.y * FP.elapsed;
			
			var otherSword:Sword = collide("Sword", x, y) as Sword;
			if (otherSword)
			{
				if (mIsHurt == false)
				{
					mHealth -= otherSword.Damage();
					mHurtTimer.reset();
					mHurtTimer.start();
					mIsHurt = true;
					mSprite.alpha = 0.5;
					if (mHealth <= 0)
					{
						for (var i:int = 0; i < 20; i++)
						{
							var part:GhostParticle = new GhostParticle();
							part.x = x;
							part.y = y;
							FP.world.add(part);
						}
						var lsword:LongSword = new LongSword(ImageManager.IMG_SWORD_BIG, "BroadSword");
						lsword.x = x;
						lsword.y = y;
						FP.world.add(lsword);
						
						var skele:NPC = new NPC("It's the skeleton of Knight Richter. His soul suspects you will need his Broad Sword for the road ahead. You should continue pressing on, Knight Nigel should be fending off bandits in the desert ahead.", "Skeleton");
						skele.x = x;
						if (Math.abs(400 - skele.x))
						{
							skele.x += 26;
						}
						skele.y = y;
						FP.world.add(skele);
						
						CleanUp();
						FP.world.remove(this);
					}
				}
			}
			
			var other:Entity = collide("Level", x, y);
			if (collide("Level", x, y)) {
				trace("Collided");
				while (collideWith(other, x, y))
				{
					y += -FP.sign(mVelocity.y);
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
		}
		
		public function StopHurting(e:Event):void
		{
			mHurtTimer.stop();
			mIsHurt = false;
			mSprite.alpha = 1.0;
		}
		
		private function PickAttack(e:Event):void
		{
			mAttackType = Math.round(Math.random() * 2);
			mSprite.color = 0xFFFFFF;
			mShootTimer.stop();
			
			if (mAttackType == 0)
			{
				mSprite.play("Stand");
			}
			else if (mAttackType == 1)
			{
				mSprite.play("Float");
				mTeleportTimer.start();
				mSprite.color = 0x0000FF;
			}
			else if (mAttackType == 2)
			{
				mSprite.play("Float");
				mShootTimer.start();
				mSprite.color = 0xFF00FF;
			}
			
			mAttackTimer.delay = 1000 + Math.random() * 500;
			mAttackTimer.reset();
			mAttackTimer.start();
		}
		
		private function StartTeleport(e:Event):void
		{
			x = 100 + Math.random() * 600;
			mTeleportTimer.stop();
			mTeleportTimer.reset();
		}
		
		private function ShootMissile(e:Event):void
		{
			var proj:MagicMissile = new MagicMissile();
			proj.x = x;
			proj.y = y;
			proj.mVelocity = new Point(FP.sign(GameDetails.GetInstance().mPlayer.x - x) * 250);
			FP.world.add(proj);
			
			mShootTimer.delay = 200 + Math.random() * 500;
			mShootTimer.reset();
			mShootTimer.start();
		}
		
		override public function CleanUp():void 
		{
			mAttackTimer.stop();
			mAttackTimer = null;
			mHurtTimer.stop();
			mHurtTimer = null;
			mTeleportTimer.stop();
			mTeleportTimer = null;
			mShootTimer.stop();
			mShootTimer = null;
			
			super.CleanUp();
		}
	}

}