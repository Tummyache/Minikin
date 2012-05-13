package Minikin.Global 
{
	import net.flashpunk.Sfx;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class MusicController 
	{
		
		private static var mInstance:MusicController;
		
		public var mBackgroundMusic:Sfx;
		public var mCurrentMusic:String;
		
		public function MusicController() 
		{
			
		}
		
		public static function getInstance():MusicController
		{
			if (mInstance == null) mInstance = new MusicController();
			return mInstance;
		}
		
		public function loop(music:String):void
		{
			if (mCurrentMusic == music)
			{
				return;
			}
			else
			{
				mCurrentMusic = music;
				if (mBackgroundMusic) mBackgroundMusic.stop();
			}
			if (music == "Title")
			{
				mBackgroundMusic = new Sfx(ImageManager.SFX_TITLE);
			}
			else if (music == "Forest")
			{
				mBackgroundMusic = new Sfx(ImageManager.SFX_FOREST);
			}
			else if (music == "Graveyard")
			{
				mBackgroundMusic = new Sfx(ImageManager.SFX_GRAVEYARD);
			}
			else if (music == "Desert")
			{
				mBackgroundMusic = new Sfx(ImageManager.SFX_DESERT);
			}
			else if (music == "Cave")
			{
				mBackgroundMusic = new Sfx(ImageManager.SFX_CAVE);
			}
			else if (music == "Boss")
			{
				mBackgroundMusic = new Sfx(ImageManager.SFX_BOSS);
			}
			
			mBackgroundMusic.loop();
		}
		
	}

}