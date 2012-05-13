package Minikin.Objects 
{
	import flash.geom.Point;
	import Minikin.Global.ImageManager;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import Minikin.Global.GameDetails;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class Pickup extends BaseObject
	{
		public var mSprite:Image;
		public var mOriginPoint:Point;
		
		public function Pickup(_type:String) 
		{
			if (_type == "Wings") mSprite = new Image(ImageManager.IMG_WINGS);
			if (_type == "DefUp") mSprite = new Image(ImageManager.IMG_DEF_ORB);
			if (_type == "AtkUp") mSprite = new Image(ImageManager.IMG_ATK_ORB);
			if (_type == "HPUp") mSprite = new Image(ImageManager.IMG_HP_ORB);

			setHitbox(mSprite.width, mSprite.height, mSprite.width / 2, mSprite.height / 2);
			
			mSprite.centerOO();
			
			type = _type;
			
			mVelocity = new Point(0, -3);
			
			graphic = mSprite;
		}
		
		override public function update():void 
		{
			if (mOriginPoint == null)
			{
				mOriginPoint = new Point(x, y);
			}
			
			if (Point.distance(mOriginPoint, new Point(x, y)) > 5)
			{
				y = mOriginPoint.y + 5 * FP.sign(mVelocity.y);
				mVelocity.y *= -1;
			}
			
			y += mVelocity.y * FP.elapsed;
			
			if (collide("Player", x, y))
			{
				if (type == "Wings") GameDetails.GetInstance().mHasDoubleJump = true;
				if (type == "DefUp") GameDetails.GetInstance().mHasDoubleJump = true;
				if (type == "AtkUp") GameDetails.GetInstance().mHasDoubleJump = true;
				if (type == "HPUp") GameDetails.GetInstance().mHasDoubleJump = true;
				
				FP.world.remove(this);
			}
			
			if (Math.random() > 0.95)
			{
				var newPart:BaseParticle = new BaseParticle(ImageManager.IMG_PARTICLE_SMALL, new Point(4, 4), "Fade", 1.0, 0xFFFFFF);
				newPart.mVelocity = new Point(0, -(Math.random() * 80 + 20));
				newPart.x = x + Math.random() * 10 - Math.random() * 10;
				newPart.y = y + Math.random() * 10 - Math.random() * 10;
				FP.world.add(newPart);
			}
			
			super.update();
		}
		
	}

}