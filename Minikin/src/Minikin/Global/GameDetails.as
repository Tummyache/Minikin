package Minikin.Global 
{
	import flash.utils.Dictionary;
	import Minikin.Objects.Player;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class GameDetails 
	{
		
		private static var mInstance:GameDetails;
		
		public var mHasShortSword:Boolean;
		public var mHasLongSword:Boolean;
		public var mHasBroadSword:Boolean;
		public var mHasHolySword:Boolean;
		public var mHasKaiserSword:Boolean;
		
		public var mDefenseUps:Dictionary;
		public var mHealthUps:Dictionary;
		
		public var mHasDoubleJump:Boolean;
		
		public var mPlayer:Player;
		
		public var mDefense:int;
		public var mHealth:int;
		public var mMaxHealth:int;
		
		public var mCurrentSword:int;
		
		public static function GetInstance():GameDetails
		{
			if (mInstance == null) mInstance = new GameDetails();
			return mInstance;
		}
		
		public function GameDetails() 
		{
			mHasShortSword = true;
			mHasLongSword = false;
			mHasBroadSword = false;
			mHasHolySword = false;
			mHasKaiserSword = false;
			
			mHasDoubleJump = true;
			
			mCurrentSword = 0;
			
			mDefenseUps = new Dictionary();
			mHealthUps = new Dictionary();
			
			mHealth = 100;
			mMaxHealth = 100;
		}
		
	}

}