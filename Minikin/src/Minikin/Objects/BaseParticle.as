package Minikin.Objects 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import Minikin.Global.GameDetails;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class BaseParticle extends Entity
	{
		public var mVelocity:Point;
		public var mSprite:Spritemap
		public var mBehavior:String;
		public var mLife:Number;
		
		public function BaseParticle(sprite:Class, dimensions:Point, behavior:String = "Normal", life:Number = 1.0, color:uint = 0xFFFFFF) 
		{
			mBehavior = behavior;
			mLife = life;
			mSprite = new Spritemap(sprite, dimensions.x, dimensions.y);
			mSprite.color = color;
			var tempArray:Array = new Array();
			for (var i:int = 0; i < mSprite.columns; i++)
			{
				tempArray[i] = i;
			}
			mSprite.add("Animate", tempArray, 10, true);
			mSprite.play("Animate");
			
			graphic = mSprite;
		}
		
		override public function update():void 
		{
			mLife -= FP.elapsed;
			
			if (mBehavior == "Normal")
			{
				x += mVelocity.x*FP.elapsed;
				y += mVelocity.y*FP.elapsed;
			}
			else if (mBehavior == "Fall+Fade")
			{
				x += mVelocity.x * FP.elapsed;
				y += mVelocity.y * FP.elapsed;
				mVelocity.y += 2000 * FP.elapsed;
				mSprite.alpha -= FP.elapsed / mLife;
			}
			else if (mBehavior == "Fade")
			{
				x += mVelocity.x * FP.elapsed;
				y += mVelocity.y * FP.elapsed;
				mSprite.alpha -= FP.elapsed / mLife;
			}
			
			if (mLife <= 0.0) FP.world.remove(this);
			
			super.update();
		}
		
	}

}