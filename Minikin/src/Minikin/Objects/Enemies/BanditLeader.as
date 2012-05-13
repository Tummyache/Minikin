package Minikin.Objects.Enemies 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.net.drm.DRMVoucherDownloadContext;
	import flash.utils.Timer;
	import Minikin.Global.ImageManager;
	import Minikin.Objects.CinematicPieces.LongSword;
	import Minikin.Objects.KnifeParticle;
	import Minikin.Objects.NPC;
	import net.flashpunk.FP;
	import Minikin.Global.GameDetails;
	import Minikin.Objects.Sword;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class BanditLeader extends Enemy 
	{	
		public var mAttackTimer:Timer;
		public var mAttackType:int;
		public var mIsHurt:Boolean;
		public var mIsJumping:Boolean;
		public var mThrowTimer:Timer;
		
		public function BanditLeader() 
		{
			mSprite = new Spritemap(ImageManager.IMG_BANDITLEADER, 32, 32);
			mSprite.add("Stand", [0]);
			mSprite.add("Ready", [1]);
			mSprite.add("Attack", [1,2,3], 7);
			mSprite.add("Jump", [4]);
			
			graphic = mSprite;
			
			mDamage = 6;
			mHealth = 60;
			
			mAttackTimer = new Timer(1700+Math.random()*800);
			mAttackTimer.addEventListener(TimerEvent.TIMER, PickAttack);
			mAttackTimer.start();
			
			mThrowTimer = new Timer(800);
			mThrowTimer.addEventListener(TimerEvent.TIMER, Throw);
			
			mVelocity = new Point(0, -1);
			
			mSprite.centerOO();
			setHitbox(24, 24, 12, 9);
		}
		
		override public function update():void 
		{
			super.update();
			
			super.update();
			
			if (collide("Level", x + mVelocity.x * FP.elapsed, y))
			{
				mVelocity.x = 0;
			}
			
			if (x + mVelocity.x * FP.elapsed < 10 || x+mVelocity.x*FP.elapsed > FP.camera.x + 790)
			{
				mVelocity.x = 0;
			}
			
			x += mVelocity.x*FP.elapsed;
			y += mVelocity.y * FP.elapsed;
			
			mSprite.scaleX = FP.sign(GameDetails.GetInstance().mPlayer.x - x);
			
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
					mIsJumping = false;
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
						for (var i:int = 0; i < 20; i++)
						{
							var part:KnifeParticle = new KnifeParticle();
							part.x = x;
							part.y = y;
							FP.world.add(part);
						}
						var lsword:LongSword = new LongSword(ImageManager.IMG_SWORD_GIANT, "HolySword");
						lsword.x = x;
						lsword.y = y;
						FP.world.add(lsword);
						
						var skele:NPC = new NPC("It's the skeleton of Knight Nigel. He wants to leave you his Holy Sword. You should continue pressing on, Knight Tiberius is investigating a disturbance up ahead.", "Skeleton");
						skele.x = x;
						if (Math.abs(400 - skele.x)<20)
						{
							skele.x += 26;
						}
						skele.y = y-32;
						FP.world.add(skele);
						
						CleanUp();
						FP.world.remove(this);
					}
				}
			}
		}
		
		public function PickAttack(e:Event):void
		{
			mAttackType = Math.round(Math.random() * 2);
			if (mAttackType == 0)
			{
				mVelocity.x = 0;
				mSprite.play("Stand");
			}
			else if (mAttackType == 1)
			{
				mSprite.play("Ready");
				
				mThrowTimer.start();
				
				mAttackTimer.stop();
			}
			else
			{
				mSprite.play("Jump");
				mVelocity = new Point(GameDetails.GetInstance().mPlayer.x - x, -800);
			}
			
			mAttackTimer.delay = 1000 + Math.random() * 800;
			mAttackTimer.reset();
			mAttackTimer.start();
		}
		
		public function Throw(e:Event):void
		{
			mSprite.play("Attack");
			
			var dir:int = FP.sign(GameDetails.GetInstance().mPlayer.x - x);
			
			mVelocity.x = -dir*200;
			mVelocity.y = -200;
			
			mSprite.scaleX = dir;
			
			var tempKnife:ThowingKnife = new ThowingKnife();
			tempKnife.x = x;
			tempKnife.y = y;
			tempKnife.mVelocity = new Point(dir*200,0);
			FP.world.add(tempKnife);
			
			tempKnife = new ThowingKnife();
			tempKnife.x = x;
			tempKnife.y = y;
			tempKnife.mVelocity = new Point(dir*200,-400);
			FP.world.add(tempKnife);
			
			
			tempKnife = new ThowingKnife();
			tempKnife.x = x;
			tempKnife.y = y;
			tempKnife.mVelocity = new Point(dir*200,-200);
			FP.world.add(tempKnife);
			
			mThrowTimer.stop();
			mThrowTimer.reset();
			mAttackTimer.start();
		}
		
		override public function CleanUp():void 
		{
			mAttackTimer.stop();
			mAttackTimer = null;
			mThrowTimer.stop();
			mThrowTimer = null;
			
			super.CleanUp();
		}
	}

}