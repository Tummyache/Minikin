package Minikin.Objects 
{
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import Minikin.Global.ImageManager;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import Minikin.Global.GameDetails;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class NPC extends BaseObject 
	{
		public var mGraphics:Graphiclist;
		public var mSprite:Spritemap;
		public var mDialogBox:Image;
		public var mText:Text;
		public var mTextShadow:Text;
		public var mDialog:String;
		public var mSound:Sfx;
		public var mIsHealer:Boolean;
		
		public function NPC(dialog:String, type:String) 
		{
			mGraphics = new Graphiclist();
			mSound = new Sfx(ImageManager.SFX_NPC_TALK);
			
			if (type == "King")
			{
				mSprite = new Spritemap(ImageManager.IMG_KING, 24, 24);
			}
			else if (type == "Queen")
			{
				mSprite = new Spritemap(ImageManager.IMG_QUEEN, 24, 24);
				mIsHealer = true;
			}
			else if (type == "Jester")
			{
				mSprite = new Spritemap(ImageManager.IMG_JESTER, 24, 24);
			}
			else if (type == "Skeleton")
			{
				mSprite = new Spritemap(ImageManager.IMG_SKELETON, 24, 24);
			}
			else if (type == "SoothSayer")
			{
				mSprite = new Spritemap(ImageManager.IMG_SOOTHSAYER, 24, 24);
			}
			else
			{
				mSprite = new Spritemap(ImageManager.IMG_PLAYER, 24, 24);
			}
			
			var animArray:Array = new Array();
			for (var i:int = 0; i < mSprite.columns; i++)
			{
				animArray[i] = i;
			}
			
			mSprite.add("Idle", animArray, 5, true);
			mSprite.play("Idle");
			mSprite.centerOO();
			
			mDialogBox = new Image(ImageManager.IMG_DIALOG);
			mDialogBox.scale = 0.0;
			mDialogBox.x = 0;
			mDialogBox.y = -mSprite.height - 16;
			mDialogBox.centerOO();
			mDialogBox.originY = 128;
			
			mGraphics.add(mSprite);
			mGraphics.add(mDialogBox);
			
			mDialog = dialog;
			
			var props:Dictionary = new Dictionary();
			props["width"] = 312;
			
			mTextShadow = new Text("", 0, 0, props);
			mTextShadow.color = 0x000000;
			mTextShadow.size = 12;
			mTextShadow.originX = mDialogBox.originX;
			mTextShadow.originY = mDialogBox.originY;
			mTextShadow.wordWrap = true;
			mTextShadow.richText = mDialog;
			mTextShadow.scale = 0;
			mGraphics.add(mTextShadow);
			
			mText = new Text("", 0, 0, props);
			mText.color = 0xFFFFFF;
			mText.size = 12;
			mText.originX = mDialogBox.originX;
			mText.originY = mDialogBox.originY;
			mText.wordWrap = true;
			mText.richText = mDialog;
			mText.scale = 0;
			mGraphics.add(mText);
			
			this.type = "NPC";
			
			graphic = mGraphics;
			
			setHitbox(16, 16, 8, 5);
		}
		
		override public function update():void 
		{
			super.update();
			
			
			if (collide("Player", x, y))
			{
				if (mIsHealer)
					GameDetails.GetInstance().mHealth = GameDetails.GetInstance().mMaxHealth;
				if (mDialogBox.scale == 0)
				{
					mSound.play(0.5);
				}
				mDialogBox.scale += 5.0 * FP.elapsed;
				layer = -1500;
				if (mDialogBox.scale > 1.0)
				{
					mDialogBox.scale = 1.0;
				}
			}
			else
			{
				mSound.stop();
				layer = 0;
				mDialogBox.scale -= 5.0 * FP.elapsed;
				if (mDialogBox.scale < 0.0)
				{
					mDialogBox.scale = 0.0;
				}
			}
			
			if (x < 150)
			{
				mDialogBox.x = 150;
			}
			else if (x-FP.camera.x > 650)
			{
				mDialogBox.x = -150;
			}
			else 
			{
				mDialogBox.x = 0;
			}
			
			mText.scale = mDialogBox.scale;
			mText.x = mDialogBox.x+4;
			mText.y = mDialogBox.y + 4;
			
			mTextShadow.scale = mDialogBox.scale;
			mTextShadow.x = mDialogBox.x+3;
			mTextShadow.y = mDialogBox.y+5;
			
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
	}

}