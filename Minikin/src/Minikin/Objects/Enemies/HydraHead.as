package Minikin.Objects.Enemies 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import Minikin.Objects.BaseObject;
	import Minikin.Objects.CinematicPieces.LongSword;
	import Minikin.Objects.NPC;
	import Minikin.Objects.Sword;
	import Minikin.Worlds.EndingScene;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import Minikin.Global.ImageManager;
	import Minikin.Global.GameDetails;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class HydraHead extends Enemy 
	{
		public var mNecks:Array;
		public var mOrigin:Point;
		public var mDestination:Point;
		public var mAddedNecks:Boolean;
		
		public var mAttackTimer:Timer;
		public var mAttackType:int;
		public var mChargeTimer:Timer;
		public var mChompTimer:Timer;
		public var mHurtTimer:Timer;
		
		public var mIsAttacking:Boolean;
		public var mIsHurt:Boolean;
		
		public var mIsFake:Boolean;
		
		public function HydraHead() 
		{
			mSprite = new Spritemap(ImageManager.IMG_HYRDAHEAD, 64, 64);
			mSprite.add("MouthOpen", [0]);
			mSprite.add("MouthClosed", [1]);
			mSprite.add("Chomp", [0, 1], 10);
			
			graphic = mSprite;
			mSprite.centerOO();
			mSprite.originX = 0;
			
			mOrigin = new Point(-20, 300);
			setHitbox(54, 54, 0, 27);
			
			mDestination = new Point(200 + Math.random() * 200, 200+Math.random()*200);
			
			mNecks = new Array();
			var neckImg:Image = new Image(ImageManager.IMG_HYRDANECK);
			neckImg.centerOO();
			for (var i:int = 0; i < 20; i++)
			{
				mNecks[i] = new Entity(0, 0, neckImg);
				(mNecks[i] as Entity).layer = 1;
			}
			
			mDamage = 9;
			
			mAttackTimer = new Timer(1000 + Math.random() * 1000);
			mAttackTimer.addEventListener(TimerEvent.TIMER, PickAttack);
			mAttackTimer.start();
			
			mChargeTimer = new Timer(1000);
			mChargeTimer.addEventListener(TimerEvent.TIMER, Charge);
			
			mChompTimer = new Timer(1000);
			mChompTimer.addEventListener(TimerEvent.TIMER, StopChomping);
			
			mHurtTimer = new Timer(200);
			mHurtTimer.addEventListener(TimerEvent.TIMER, StopHurting);
			
			mVelocity = new Point(Math.random() * 500, Math.random() * 200 - Math.random() * 200);
			
			mHealth = 120;
			
			mIsFake = false;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (mIsFake == true && GameDetails.GetInstance().mHealth <= 10)
			{
				mOrigin.x -= 200 * FP.elapsed;
				x -= 200 * FP.elapsed;
				
				mVelocity.x = 0;
				mVelocity.y = 0;
				
				mIsAttacking = false;
				mAttackTimer.stop();
				mChompTimer.stop();
				mChargeTimer.stop();
				
				mDestination.x = -200;
				
				if (FP.world.typeCount("NPC") == 0)
				{
					var knight:NPC = new NPC("I am not long for this world squire, please take my ancient sword and defeat the Hydra!", "Skeleton");
					knight.x = 368;
					knight.y = -100;
					FP.world.add(knight);
					
					var kaiser:LongSword = new LongSword(ImageManager.IMG_SWORD_KAISER, "KaiserSword");
					kaiser.x = 368;
					kaiser.y = -100;
					FP.world.add(kaiser);
				}
				
				if (x <= - 200)
				{
					for (var i:int = 0; i < mNecks.length; i++)
					{
						FP.world.remove(mNecks[i]);
					}
					FP.world.remove(this);
					CleanUp();
				}
			}

				for (var i:int = 0; i < mNecks.length; i++)
				{
					if (!mAddedNecks)
					{
						FP.world.add(mNecks[i]);
					}
					mNecks[i].x = FP.lerp(x,mOrigin.x,i/mNecks.length);
					mNecks[i].y = FP.lerp(y, mOrigin.y, i / mNecks.length);
				}
				mAddedNecks = true;
				
				if (mIsAttacking == false)
				{
					mVelocity.x = mDestination.x - x;
					mVelocity.y = mDestination.y - y;
				}
				
				if (Point.distance(mDestination, new Point(x, y)) < 20)
				{
					if (mIsAttacking == false)
					{
						mDestination = new Point(200 + Math.random() * 200, 200 + Math.random() * 200);
					}
					else
					{
						mVelocity.x = 0;
						mVelocity.y = 0;
						mSprite.play("Chomp");
						mChompTimer.start();
					}
				}
				
				var otherSword:Sword = collide("Sword", x, y) as Sword;
				if (otherSword && mIsHurt == false)
				{
					mIsHurt = true;
					mSprite.alpha = 0.5;
					mHurtTimer.start();
					if (mIsFake == false)
					{
						mHealth -= otherSword.Damage();
						if (mHealth <= 0)
						{
							CleanUp();
							for (var i:int = 0; i < mNecks.length; i++)
							{
								FP.world.remove(mNecks[i]);
							}
							FP.world.remove(this);
							trace(FP.world.classCount(HydraHead));
							if (FP.world.classCount(HydraHead) == 1)
							{
								FP.world = new EndingScene();
							}
						}
					}
				}
				
				x += mVelocity.x*FP.elapsed;
				y += mVelocity.y * FP.elapsed;
		}
		
		public function PickAttack(e:Event):void
		{
			mAttackType = Math.round(Math.random());
			trace("Attack " + mAttackType);
			
			if (mAttackType == 0)
			{
				mAttackTimer.delay = Math.random() * 1000 + Math.random() * 1000;
				mSprite.play("MouthClosed");
				mAttackTimer.reset();
				mAttackTimer.start();
			}
			else
			{
				mAttackTimer.stop();
				
				mVelocity.x = 0;
				mVelocity.y = 0;
				mDestination.x = GameDetails.GetInstance().mPlayer.x;
				mDestination.y = GameDetails.GetInstance().mPlayer.y;
				mIsAttacking = true;
				
				mSprite.play("Chomp");
				mChargeTimer.reset();
				mChargeTimer.start();
			}
		}
		
		public function Charge(e:Event):void
		{
			mDestination.x = GameDetails.GetInstance().mPlayer.x;
			mDestination.y = GameDetails.GetInstance().mPlayer.y;
			mVelocity.x = (GameDetails.GetInstance().mPlayer.x - x);
			mVelocity.y = (GameDetails.GetInstance().mPlayer.y - y);
			mIsAttacking = true;
			mSprite.play("MouthOpen");
			mChargeTimer.stop();
			mChargeTimer.reset();
		}
		
		public function StopChomping(e:Event):void
		{
			mDestination = new Point(200 + Math.random() * 200, 200 + Math.random() * 200);
			mChompTimer.reset();
			mIsAttacking = false;
			mSprite.play("MouthClosed");
			mAttackTimer.reset();
			mAttackTimer.delay = 8000;
			mAttackTimer.start();
			
		}
		
		public function StopHurting(e:Event):void
		{
			mIsHurt = false;
			mHurtTimer.reset();
			mHurtTimer.stop();
			mSprite.alpha = 1.0;
		}
		
		override public function CleanUp():void 
		{
			mChompTimer.stop();
			mChompTimer = null;
			
			mAttackTimer.stop();
			mAttackTimer = null;
			
			mChargeTimer.stop();
			mChargeTimer = null;
			
			super.CleanUp();
		}
		
		
	}

}