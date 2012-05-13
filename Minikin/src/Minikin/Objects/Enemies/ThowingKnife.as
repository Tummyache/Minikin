package Minikin.Objects.Enemies 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import net.flashpunk.graphics.Spritemap;
	import Minikin.Global.ImageManager;
	import net.flashpunk.FP;
	import Minikin.Global.GameDetails;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class ThowingKnife extends Enemy 
	{
		public var mThrowTimer:Timer;
		public var mIsFalling:Boolean;
		
		public function ThowingKnife() 
		{
			mSprite = new Spritemap(ImageManager.IMG_KNIFE, 8, 8);
			graphic = mSprite;
			
			setHitbox(8, 8, 4, 4);
			
			mDamage = 5;
			
			type = "Projectile";
			
			mThrowTimer = new Timer(800);
			mThrowTimer.addEventListener(TimerEvent.TIMER, Fall);
			mThrowTimer.start();
		}
		
		
		override public function update():void 
		{
			super.update();
			
			x += mVelocity.x * FP.elapsed;
			y += mVelocity.y * FP.elapsed;
			
			mSprite.angle = FP.angle(0, 0, mVelocity.x, mVelocity.y);
			
			if (mIsFalling)
			{
				mVelocity.y += 1000 * FP.elapsed;
			}
			
			if (collide("Level", x, y) || y > 2000)
			{
				FP.world.remove(this);
			}
		}
		
		public function Fall(e:Event):void
		{
			mIsFalling = true;
			mVelocity.x /= 2;
		}
		
		override public function CleanUp():void 
		{
			mThrowTimer.stop();
			mThrowTimer = null;
			
			super.CleanUp();
		}
	}

}