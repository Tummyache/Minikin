package Minikin.Worlds 
{
	import flash.display.Graphics;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import Minikin.Global.ImageManager;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import Minikin.Global.MusicController;
	
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class TitleScreen extends World 
	{
		public var mScreenOne:Image;
		public var mScreenTwo:Image;
		
		public var mImageHolder:Graphiclist;
		
		public var mTracker:int;
		
		public function TitleScreen() 
		{
			mScreenOne = new Image(ImageManager.IMG_BACK_CASTLE);
			mScreenOne.scale = 4;
			mScreenTwo = new Image(ImageManager.IMG_BACK_FOREST);
			mScreenTwo.scale = 4;
			mScreenTwo.alpha = 0.0;
			
			mImageHolder = new Graphiclist();
			mImageHolder.add(mScreenOne);
			mImageHolder.add(mScreenTwo);
			
			mTracker = 1;
			
			var tempEntity:Entity = new Entity(0, 0, mImageHolder);
			add(tempEntity);
			
			var titleText:Text = new Text("MINIKIN");
			titleText.centerOO();
			titleText.size = 100;
			var titleShadow:Text = new Text("MINIKIN", -5, 5);
			titleShadow.centerOO();
			titleShadow.color = 0x000000;
			titleShadow.size = 100;
			var title:Entity = new Entity(460-titleText.width/2, 200, new Graphiclist(titleShadow, titleText));
			add(title);
			
			titleText = new Text("Press ENTER to start a new game");
			title = new Entity(260, 500, titleText);
			add(title);
			
			MusicController.getInstance().loop("Title");
		}
		
		override public function update():void 
		{
			mScreenTwo.alpha += 0.2 * FP.elapsed;
			if (mScreenTwo.alpha >= 1.0)
			{
				mTracker += 1;
				if (mTracker > 4) mTracker = 0;
				mImageHolder.remove(mScreenOne);
				mScreenOne = mScreenTwo;
				mImageHolder.add(mScreenOne);
				mImageHolder.remove(mScreenTwo);
				if (mTracker == 0)
				{
					mScreenOne = new Image(ImageManager.IMG_BACK_CAVE);
					mScreenTwo = new Image(ImageManager.IMG_BACK_CASTLE);
				}
				if (mTracker == 1)
				{ 
					mScreenOne = new Image(ImageManager.IMG_BACK_CASTLE);
					mScreenTwo = new Image(ImageManager.IMG_BACK_FOREST);
				}
				if (mTracker == 2)
				{ 
					mScreenOne = new Image(ImageManager.IMG_BACK_FOREST);
					mScreenTwo = new Image(ImageManager.IMG_BACK_GRAVEYARD);
				}
				if (mTracker == 3)
				{ 
					mScreenOne = new Image(ImageManager.IMG_BACK_GRAVEYARD);
					mScreenTwo = new Image(ImageManager.IMG_BACK_DESERT);
				}
				if (mTracker == 4)
				{ 
					mScreenOne = new Image(ImageManager.IMG_BACK_DESERT);
					mScreenTwo = new Image(ImageManager.IMG_BACK_CAVE);
				}
				mImageHolder.add(mScreenOne);
				mImageHolder.add(mScreenTwo);
				mScreenOne.scale = 4;
				mScreenTwo.scale = 4;
				mScreenTwo.alpha = 0;
			}
			
			if (Input.pressed(Key.ENTER))
			{
				FP.world = new BaseWorld("Castle", 1600, 400);
			}
			
			super.update();
		}
		
	}

}