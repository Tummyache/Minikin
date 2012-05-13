package Minikin.Objects.Enemies 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import Minikin.Objects.CinematicPieces.LongSword;
	import Minikin.Objects.NPC;
	import Minikin.Objects.Player;
	import Minikin.Objects.SlimeParticle;
	import Minikin.Objects.Sword;
	import net.flashpunk.graphics.Spritemap;
	import Minikin.Global.ImageManager;
	import net.flashpunk.FP;
	import Minikin.Global.GameDetails;
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class SlimeBoss extends Enemy 
	{
		public var mAttackTimer:Timer;
		public var mSpawningTimer:Timer;
		
		public var mAttackType:int;
		public var mIsAttacking:Boolean;
		
		public var mIsHurt:Boolean;
		public var mHurtTimer:Timer;
		
		public var mPlayer:Player;
		
		public function SlimeBoss() 
		{
			super();
			
			mSprite = new Spritemap(ImageManager.IMG_SLIME_BOSS, 64, 64);
			mSprite.add("Idle", [0]);
			mSprite.add("Spawning", [3, 0], 10, true);
			mSprite.add("Moving", [0, 1, 0, 2], 10, true);
			mSprite.play("Idle");
			mSprite.centerOO();
			graphic = mSprite;
			
			mHealth = 30;
			
			setHitbox(48, 32, 24, 0);
			
			mAttackTimer = new Timer(1000 + Math.random() * 1000);
			mAttackTimer.addEventListener(TimerEvent.TIMER, StartAttacking);
			mAttackTimer.start();
			
			mSpawningTimer = new Timer(500 + Math.random() * 200);
			mSpawningTimer.addEventListener(TimerEvent.TIMER, Spawn);
			
			mHurtTimer = new Timer(200);
			mHurtTimer.addEventListener(TimerEvent.TIMER, StopHurting);
			
			mAttackType = 0;
			
			mDamage = 4;
			
			mVelocity = new Point(0, 0);
			
			mPlayer = GameDetails.GetInstance().mPlayer;
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
							var part:SlimeParticle = new SlimeParticle();
							part.x = x;
							part.y = y;
							FP.world.add(part);
						}
						var lsword:LongSword = new LongSword(ImageManager.IMG_SWORD_LONG, "LongSword");
						lsword.x = x;
						lsword.y = y;
						FP.world.add(lsword);
						
						var skele:NPC = new NPC("It's the skeleton of Knight Gwyn. He bestows his Long Sword onto you from the afterlife, press E to bring up your weapons. You should continue pressing on, Knight Richter should be patrolling the Graveyard up ahead.", "Skeleton");
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
					y += -1;
				}
				mVelocity.y = 0;
				mVelocity.x = 0;
			}
		}

		public function StartAttacking(e:Event):void
		{
			mAttackType = Math.round(Math.random() * 2);
			mSpawningTimer.stop();
			
			if (mAttackType == 0)
			{
				mIsAttacking = false;
				mSprite.play("Idle");
				mVelocity.x = 0;
				mVelocity.y = 0;
			}
			else if (mAttackType == 1)
			{
				mIsAttacking = true;
				mSprite.play("Moving");
				if (mPlayer.x > x)
				{
					mVelocity.x = 25;
				}
				else
				{
					mVelocity.x = -25;
				}
			}
			else
			{
				mVelocity.x = 0;
				mVelocity.y = 0;
				
				mIsAttacking = true;
				mSpawningTimer.reset();
				mSpawningTimer.start();
				mSprite.play("Spawning");
			}
			
			mAttackTimer.reset();
			mAttackTimer.delay = Math.random() * 1000 + 1000;
			mAttackTimer.start();
		}
		public function Spawn(e:Event):void
		{
			var tempSlime:Slime = new Slime();
			tempSlime.x = x+Math.random()*20-Math.random()*20;
			tempSlime.y = y+Math.random()*10-Math.random()*10;
			FP.world.add(tempSlime);
			
			mSpawningTimer.reset();
			mSpawningTimer.delay = Math.random() * 500 + 200;
			mSpawningTimer.start();
			
		}
		
		public function StopHurting(e:Event):void
		{
			mHurtTimer.stop();
			mIsHurt = false;
			mSprite.alpha = 1.0;
		}
		
		override public function CleanUp():void 
		{
			super.CleanUp();
			
			mSpawningTimer.stop();
			mSpawningTimer = null;
			mAttackTimer.stop();
			mAttackTimer = null;
			mHurtTimer.stop();
			mHurtTimer = null;
			mPlayer = null;
		}
		
	}

}