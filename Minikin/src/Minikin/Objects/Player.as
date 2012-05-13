package Minikin.Objects 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import Minikin.Objects.Enemies.Bandit;
	import Minikin.Objects.Enemies.Enemy;
	import Minikin.Worlds.BaseWorld;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import Minikin.Global.ImageManager;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import Minikin.Global.GameDetails;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class Player extends BaseObject
	{
		// Accessors and Mutators are for pussies
		public var mSprite:Spritemap;
		public var mIsJumping:Boolean;
		public var mIsDoubleJumping:Boolean;
		public var mIsAttacking:Boolean;
		public var mIsHurt:Boolean;
		public var mIsShielded:Boolean;
		public var mCanShield:Boolean;
		public var mAttackTimer:Timer;
		public var mHurtTimer:Timer;
		public var mShieldTimer:Timer;
		public var mShieldCooldown:Timer;
		public var mSword:Sword;
		public var mShield:Entity;
		public var mIsPaused:Boolean;
		
		public function Player() 
		{
			super();
			
			mSprite = new Spritemap(ImageManager.IMG_PLAYER, 24, 24);
			mSprite.add("Stand", [5]);
			mSprite.add("Walk", [0, 1, 2, 3, 4], 10, true);
			mSprite.add("Attack", [6, 7, 8, 9], 15, false);
			mSprite.play("Attack");
			
			graphic = mSprite;
			setHitbox(16, 16, 8, 5);
			
			mAttackTimer = new Timer(300);
			mAttackTimer.addEventListener(TimerEvent.TIMER, AttackFinished);
			
			mHurtTimer = new Timer(500);
			mHurtTimer.addEventListener(TimerEvent.TIMER, HurtFinished);
			
			mShieldTimer = new Timer(700);
			mShieldTimer.addEventListener(TimerEvent.TIMER, ShieldFinished);
			
			mShieldCooldown = new Timer(1000);
			mShieldCooldown.addEventListener(TimerEvent.TIMER, CanShieldAgain);
			
			var shieldImg:Image = new Image(ImageManager.IMG_BUBBLE);
			shieldImg.centerOO();
			mShield = new Entity(x, y, shieldImg);
			
			type = "Player";
			
			mCanShield = true;
			
			mSprite.centerOO();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.E))
			{
				if (FP.world.typeCount("EquipMenu") == 1)
				{
					FP.world.remove(FP.world.typeFirst("EquipMenu"));
					mIsPaused = false;
				}
				else
				{
					FP.world.add(new EquipMenu());
					mIsPaused = true;
				}
			}
			
			if (mIsAttacking == false)
			{
				if (Input.check(Key.LEFT))
				{
					mVelocity.x = -120;
					mSprite.scaleX = -1;
					mSprite.play("Walk");
				}
				else if (Input.check(Key.RIGHT))
				{
					mVelocity.x = 120;
					mSprite.scaleX = 1;
					mSprite.play("Walk");
				}
				else
				{
					mVelocity.x = 0;
					mSprite.play("Stand");
				}
			}
			
			if ((Input.pressed(Key.SPACE) || Input.pressed(Key.UP)) && (mIsJumping == false || (mIsDoubleJumping == false && GameDetails.GetInstance().mHasDoubleJump)) && mIsAttacking == false)
			{
				if (mIsJumping == true) mIsDoubleJumping = true;
				else mIsJumping = true;
				mVelocity.y = -400;
				y -= 3;
			}
			
			if (Input.check(Key.A) && mIsAttacking == false)
			{
				mSprite.play("Attack");
				
				mIsAttacking = true;
				
				mAttackTimer.reset();
				mAttackTimer.start();
				
				if (mIsJumping == false)
				{
					mVelocity.x = 0;
				}
				
				mSword = new Sword((mSprite.scaleX == -1 ? true : false));
				mSword.x = x;
				mSword.y = y;
				FP.world.add(mSword);
			}
			
			if (Input.pressed(Key.SHIFT) && mCanShield == true)
			{
				FP.world.add(mShield);
				mShieldTimer.start();
				mCanShield = false;
				mIsShielded = true;
			}
			
			mShield.x = x;
			mShield.y = y;
			
			var otherEnemy:Enemy = collide("Enemy", x, y) as Enemy;
			if (otherEnemy && mIsHurt == false)
			{
				GameDetails.GetInstance().mHealth -= otherEnemy.mDamage;
				
				mVelocity.x = FP.sign(x - otherEnemy.x) * 200;
				mVelocity.y = -200;
				mIsHurt = true;
				mSprite.alpha = 0.5;
				
				//var temp:Popup = new Popup();
				//temp.x = x;
				//temp.y = y - 20;
				//FP.world.add(temp);
				
				mHurtTimer.reset();
				mHurtTimer.start();
			}
			
			otherEnemy = collide("Projectile", x, y) as Enemy;
			if (otherEnemy)
			{
				if (mIsShielded == false)
				{
					if (mIsHurt == false)
					{
						GameDetails.GetInstance().mHealth -= otherEnemy.mDamage;
						
						mVelocity.x = FP.sign(x - otherEnemy.x) * 200;
						mVelocity.y = -200;
						mIsHurt = true;
						mSprite.alpha = 0.5;
						
						//var temp:Popup = new Popup();
						//temp.x = x;
						//temp.y = y - 20;
						//FP.world.add(temp);
						
						mHurtTimer.reset();
						mHurtTimer.start();
					}
				}
				else
				{
					var tempPart:BaseParticle = new BaseParticle(ImageManager.IMG_PARTICLE_SMALL, new Point(4, 4), "Fall+Fade", 1.0, 0xBAFEFE);
					tempPart.x = otherEnemy.x;
					tempPart.y = otherEnemy.y;
					tempPart.mVelocity = new Point((otherEnemy.x - x)*75, (otherEnemy.y - y)*75);
					FP.world.add(tempPart);
					
					otherEnemy.CleanUp();
					FP.world.remove(otherEnemy);
				}
			}
			
			if (collide("Level", x + mVelocity.x * FP.elapsed, y))
			{
				mVelocity.x = 0;
			}
			
			if (x + mVelocity.x * FP.elapsed < 10 || x+mVelocity.x*FP.elapsed > FP.camera.x + 790)
			{
				mVelocity.x = 0;
			}
			
			if (mIsPaused == false)
			{
				x += mVelocity.x * FP.elapsed;
			}
			y += mVelocity.y * FP.elapsed;
			
			if (!IsSpecialRoom())
			{
				var tele:Teleporter = collide("Teleport", x, y) as Teleporter;
				if (tele)
				{
					var cleanArray:Array = new Array();
					FP.world.getClass(BaseObject, cleanArray);
					for (var i:int = 0; i < cleanArray.length; i++)
					{
						(cleanArray[i] as BaseObject).CleanUp();
					}
					FP.world.removeAll();
					FP.world = new BaseWorld(tele.mZone, tele.mTelePoint.x, tele.mTelePoint.y);
				}
			}
			
			if (mSword)
			{
				mSword.x = x;
				mSword.y = y;
			}
			
			var other:Entity = collide("Level", x, y);
			if (collide("Level", x, y)) {
				trace("Collided");
				while (collideWith(other, x, y))
				{
					y += -FP.sign(mVelocity.y);
				}
				if (mVelocity.y > 0)
				{
					mIsJumping = false;
					mIsDoubleJumping = false;
				}
				mVelocity.y = 0;
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
				if (!Input.check(Key.DOWN))
				{
					mIsJumping = false;
					mIsDoubleJumping = false;
					while (collideWith(other, x, y))
					{
						y += -FP.sign(mVelocity.y);
					}
					mVelocity.y = 0;
				}
				else
				{
					y += 6;
				}
			}
			
			FP.camera.x = x-FP.halfWidth;
			FP.camera.y = y - FP.halfHeight;
			
			if (FP.camera.x < 0) FP.camera.x = 0;
			if (FP.camera.y < 0) FP.camera.y = 0;
			if (FP.camera.x > (FP.world as BaseWorld).mCollisionGrid.width - FP.screen.width) FP.camera.x = (FP.world as BaseWorld).mCollisionGrid.width - FP.screen.width;
			if (FP.camera.y > (FP.world as BaseWorld).mCollisionGrid.height - FP.screen.height) FP.camera.y = (FP.world as BaseWorld).mCollisionGrid.height - FP.screen.height;
			
			if (GameDetails.GetInstance().mHealth <= 0)
			{
				GameDetails.GetInstance().mHealth = GameDetails.GetInstance().mMaxHealth;
				var tempWorld:BaseWorld = new BaseWorld("Castle", 1600, 400)
				var oldYou:NPC = new NPC("This skeleton looks like you, something must have brought you back.  You'd better be more careful while travelling.", "Skeleton");
				oldYou.x = 1500;
				oldYou.y = 300;
				tempWorld.add(oldYou);
				FP.world = tempWorld;
			}
		}
		
		override public function CleanUp():void 
		{
			mAttackTimer.stop();
			mAttackTimer = null;
			mHurtTimer.stop();
			mHurtTimer = null;
			mShieldCooldown.stop();
			mShieldCooldown = null;
			mShieldTimer.stop();
			mShieldTimer = null;
			
			super.CleanUp();
		}
		
		private function IsSpecialRoom():Boolean
		{
			return false;
			
			var room:BaseWorld = FP.world as BaseWorld;
			if (room.mName == "Forest03") // Slime Lord Room
			{
				if (GameDetails.GetInstance().mHasLongSword == true)
				{
					return false;
				}
				else
				{
					return true;
				}
			}
			if (room.mName == "Graveyard02") // Whight Room
			{
				if (GameDetails.GetInstance().mHasBroadSword == true)
				{
					return false;
				}
				else
				{
					return true;
				}
			}
			if (room.mName == "Desert03") // Bandit Leader Room
			{
				if (GameDetails.GetInstance().mHasHolySword == true)
				{
					return false;
				}
				else
				{
					return true;
				}
			}
			if (room.mName == "Cave01") // Fake Hydra Room
			{
				if (GameDetails.GetInstance().mHasKaiserSword == true)
				{
					return false;
				}
				else
				{
					return true;
				}
			}
			if (room.mName == "Cave03") // Fake Hydra Room
			{
				return true;
			}
			
			return false;
		}
		
		private function AttackFinished(e:Event):void
		{
			mIsAttacking = false;
			mSword = null;
			mAttackTimer.stop();
		}
		
		private function HurtFinished(e:Event):void
		{
			mIsHurt = false;
			mSprite.alpha = 1.0;
			mHurtTimer.stop();
		}
		
		private function ShieldFinished(e:Event):void
		{
			mShieldTimer.stop();
			mShieldTimer.reset();
			
			mIsShielded = false;
			FP.world.remove(mShield);
			for (var i:int = 0; i < 8; i++)
			{
				var tempPart:BaseParticle = new BaseParticle(ImageManager.IMG_PARTICLE_SMALL, new Point(4, 4), "Fall+Fade", 1.0, 0xBAFEFE);
				tempPart.x = x + Math.random() * 10 - Math.random() * 10;
				tempPart.y = y -10 + Math.random() * 4 - Math.random() * 4;
				tempPart.mVelocity = new Point((tempPart.x - x)*40, (tempPart.y - y)*40);
				FP.world.add(tempPart);
			}
			
			mShieldCooldown.reset();
			mShieldCooldown.start();
		}
		
		private function CanShieldAgain(e:Event):void
		{
			mShieldCooldown.reset();
			mShieldCooldown.stop();
			
			mCanShield = true;
		}
	}

}