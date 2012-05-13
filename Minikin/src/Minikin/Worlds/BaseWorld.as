package Minikin.Worlds 
{
	import adobe.utils.ProductManager;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import Minikin.Objects.Cloud;
	import Minikin.Objects.Enemies.Bandit;
	import Minikin.Objects.Enemies.BanditLeader;
	import Minikin.Objects.Enemies.Enemy;
	import Minikin.Objects.Enemies.Ghoul;
	import Minikin.Objects.Enemies.HydraHead;
	import Minikin.Objects.Enemies.Knifer;
	import Minikin.Objects.Enemies.Slime;
	import Minikin.Objects.Enemies.SlimeBlue;
	import Minikin.Objects.Enemies.SlimeBoss;
	import Minikin.Objects.Enemies.SlimePink;
	import Minikin.Objects.Enemies.Whight;
	import Minikin.Objects.Enemies.Zombie;
	import Minikin.Objects.Interface;
	import Minikin.Objects.NPC;
	import Minikin.Objects.Pickup;
	import Minikin.Objects.Platform;
	import Minikin.Objects.Teleporter;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import Minikin.Objects.Player;
	import Minikin.Global.ImageManager;
	import net.flashpunk.FP;
	import Minikin.Global.GameDetails;
	import Minikin.Assets.Ogmo.LevelManager;
	import Minikin.Global.MusicController;
	
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class BaseWorld extends World 
	{
		public var mBottomTiles:Tilemap;
		public var mMiddleTiles:Tilemap;
		public var mTopTiles:Tilemap;
		public var mDetailTiles:Tilemap;
		public var mCollisionGrid:Grid;
		public var mBackdrop:Entity;
		public var mName:String;
		public var mInterface:Interface;
		public var mFader:Entity;
		public var mFaderImage:Image;
		public var mFadeOut:Boolean;
		
		public var mPlayer:Player;
		
		
		public function BaseWorld(map:String, teleX:int, teleY:int) 
		{
			mPlayer = new Player();
			mPlayer.x = teleX;
			mPlayer.y = teleY;
			
			GameDetails.GetInstance().mPlayer = mPlayer;
			
			add(mPlayer);
			
			mInterface = new Interface();
			add(mInterface);
			
			mFaderImage = Image.createRect(1, 1, 0x000000);
			mFaderImage.scale = 4000;
			mFader = new Entity(0, 0, mFaderImage);
			add(mFader);
			mFader.layer = -20000000;
			
			LoadLevel(map);
		}
		
		override public function update():void 
		{
			super.update();
			
			mBackdrop.x = FP.camera.x;
			mBackdrop.y = FP.camera.y;
			
			//if (mName.search("Cave") != -1)
			//{
				//if (Math.random() < 0.1*FP.elapsed)
				//{
					//add(new Cloud());
				//}
			//}
		}
		
		override public function updateLists():void 
		{
			super.updateLists();
			
			if (mFaderImage.alpha > 0)
			{
			mFaderImage.alpha -= 5 * FP.elapsed;
			}
			
			mInterface.x = camera.x;
			mInterface.y = camera.y;
		}
		
		public function LoadLevel(map:String):void
		{
			var level:Class = ImageManager.LVL_CASTLE;
			
			var chipset:Class = ImageManager.IMG_CASTLE_GROUND;
			var background:Class = ImageManager.IMG_BACK_CASTLE;
			mName = map;
			
			level = LevelManager.getLevel(mName);
			
			if (map.search("Forest") != -1 || map.search("Treetop") != -1)
			{
				chipset = ImageManager.IMG_GRASSY_GROUND;
				background = ImageManager.IMG_BACK_FOREST;
				
				if (map == "ForestBoss" && !GameDetails.GetInstance().mHasLongSword)
				{
					MusicController.getInstance().loop("Boss");
				}
				else 
				{
					MusicController.getInstance().loop("Forest");
				}
			}
			if (map.search("Castle") != -1)
			{
				chipset = ImageManager.IMG_CASTLE_GROUND;
				MusicController.getInstance().loop("Forest");
			}
			if (map.search("Graveyard") != -1)
			{
				background = ImageManager.IMG_BACK_GRAVEYARD;
				chipset = ImageManager.IMG_GRAVEYARD_GROUND;
				
				if (map == "GraveyardBoss" && !GameDetails.GetInstance().mHasBroadSword)
				{
					MusicController.getInstance().loop("Boss");
				}
				else 
				{
					MusicController.getInstance().loop("Graveyard");
				}
			}
			if (map.search("Desert") != -1)
			{
				background = ImageManager.IMG_BACK_DESERT;
				chipset = ImageManager.IMG_DESERT_GROUND;
				
				if (map == "DesertBoss" && !GameDetails.GetInstance().mHasHolySword)
				{
					MusicController.getInstance().loop("Boss");
				}
				else 
				{
					MusicController.getInstance().loop("Desert");
				}
			}
			if (map.search("Cave") != -1)
			{
				background = ImageManager.IMG_BACK_CAVE;
				chipset = ImageManager.IMG_CAVE_GROUND;
				
				if ((map == "CaveBoss" && !GameDetails.GetInstance().mHasKaiserSword) || map == "Cave03")
				{
					MusicController.getInstance().loop("Boss");
				}
				else 
				{
					MusicController.getInstance().loop("Cave");
				}
			}

			var rawData:ByteArray = new level;
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			
			var dataList:XMLList;
			var dataElement:XML;
			
			// Create the chipset layers
			dataList = xmlData.@width;
			trace(dataList.@width);
			var wid:int = xmlData.@width;
			var heit:int = int(xmlData.@height);
			mBottomTiles = new Tilemap(chipset, wid, heit, 16, 16);
			mMiddleTiles = new Tilemap(chipset, wid, heit, 16, 16);
			mTopTiles = new Tilemap(chipset, wid, heit, 16, 16);
			mDetailTiles = new Tilemap(chipset, wid, heit, 16, 16);
			mCollisionGrid = new Grid(wid, heit, 16, 16);
			
			var mLevel:Entity = new Entity(0, 0, mBottomTiles, mCollisionGrid);
			mLevel.layer = 1000;
			mLevel.type = "Level";
			add(mLevel);
			
			mLevel = new Entity(0, 0, mMiddleTiles, null);
			mLevel.layer = 500;
			add(mLevel);
			
			mLevel = new Entity(0, 0, mTopTiles, null);
			mLevel.layer = -500;
			add(mLevel);
			
			mLevel = new Entity(0, 0, mDetailTiles, null);
			mLevel.layer = -1000;
			add(mLevel);
			
			mBackdrop = new Entity(0, 0, new Image(background), null);
			mBackdrop.layer = 1500;
			(mBackdrop.graphic as Image).scale = 4;
			add(mBackdrop);
			
			FP.screen.color = 0x87CEFA;
			
			// Load in the data from xml
			dataList = xmlData.Collision;
			
			trace(dataList.toString());
			mCollisionGrid.loadFromString(dataList.toXMLString(), "", "\n");
			
			dataList = xmlData.Bottom.tile;
			
			for each(dataElement in dataList) {
				mBottomTiles.setTile(int(dataElement.@x), int(dataElement.@y), int(dataElement.@id));
			}
			
			dataList = xmlData.Middle.tile;
			
			for each(dataElement in dataList) {
				mMiddleTiles.setTile(int(dataElement.@x), int(dataElement.@y), int(dataElement.@id));
			}
			
			dataList = xmlData.Top.tile;
			
			for each(dataElement in dataList) {
				mTopTiles.setTile(int(dataElement.@x), int(dataElement.@y), int(dataElement.@id));
			}
			
			dataList = xmlData.Detail.tile;
			
			for each(dataElement in dataList) {
				mDetailTiles.setTile(int(dataElement.@x), int(dataElement.@y), int(dataElement.@id));
			}
			
			dataList = xmlData.Entities.NPC;
			
			for each(dataElement in dataList) {
				var newNPC:NPC = new NPC(String(dataElement.@Dialog), dataElement.@Type);
				newNPC.x = int(dataElement.@x);
				newNPC.y = int(dataElement.@y);
				add(newNPC);
			}
			
			dataList = xmlData.Entities.Teleport;
			
			for each(dataElement in dataList)
			{
				add(new Teleporter(dataElement.@x, dataElement.@y, dataElement.@width, dataElement.@height, dataElement.@Map, dataElement.@TeleportX, dataElement.@TeleportY));
			}
			
			dataList = xmlData.Entities.Pickup;
			
			for each(dataElement in dataList)
			{
					var tempPick:Pickup = new Pickup(dataElement.@Type);
					tempPick.x = dataElement.@x;
					tempPick.y = dataElement.@y;
					add(tempPick);
			}
			
			//Load Monsters
			dataList = xmlData.Entities.Monster;
			
			for each(dataElement in dataList)
			{
				var newEnemy:Enemy;
				if (dataElement.@Type == "Slime") newEnemy = new Slime();
				if (dataElement.@Type == "SlimePink") newEnemy = new SlimePink();
				if (dataElement.@Type == "SlimeBlue") newEnemy = new SlimeBlue();
				if (dataElement.@Type == "BossSlime" && (mName != "Forest03" || !GameDetails.GetInstance().mHasLongSword)) newEnemy = new SlimeBoss();
				if (dataElement.@Type == "Zombie") newEnemy = new Zombie();
				if (dataElement.@Type == "Ghoul") newEnemy = new Ghoul();
				if (dataElement.@Type == "Whight" && (mName != "Graveyard02" || !GameDetails.GetInstance().mHasBroadSword)) newEnemy = new Whight();
				if (dataElement.@Type == "Bandit") newEnemy = new Bandit();
				if (dataElement.@Type == "Knifer") newEnemy = new Knifer();
				if (dataElement.@Type == "BanditLeader" && (mName != "Desert03" || !GameDetails.GetInstance().mHasHolySword)) newEnemy = new BanditLeader();
				if (dataElement.@Type == "Hydra" && ((mName != "Cave01" || !GameDetails.GetInstance().mHasKaiserSword) || mName == "Cave03"))
				{
					for (var i:int =0; i < 7; i++)
					{
						var tempHydra:HydraHead = new HydraHead();
						tempHydra.x = 300;
						tempHydra.y = 300;
						if (mName == "Cave01") tempHydra.mIsFake = true;
						add(tempHydra);
					}
				}
				
				if (newEnemy)
				{
					newEnemy.x = dataElement.@x;
					newEnemy.y = dataElement.@y;
					add(newEnemy);
				}
			}
			
			dataList = xmlData.Entities.Platform;
			for each(dataElement in dataList)
			{
				var newPlatform:Platform = new Platform(dataElement.@x, dataElement.@y, dataElement.@width);
				add(newPlatform);
			}
			
			// Get the nearest spawn point to my blatant guess
			dataList = xmlData.Entities.SpawnPoint;
			
			var nearestSpawn:Point = null;
			for each(dataElement in dataList)
			{
				if (nearestSpawn == null)
				{
					nearestSpawn = new Point(dataElement.@x, dataElement.@y);
				}
				else
				{
					var playPoint:Point = new Point(mPlayer.x, mPlayer.y);
					if (Point.distance(nearestSpawn, playPoint) > Point.distance(new Point(dataElement.@x, dataElement.@y), playPoint))
					{
						nearestSpawn.x = dataElement.@x;
						nearestSpawn.y = dataElement.@y;
					}
				}
			}
			if (nearestSpawn != null)
			{
				mPlayer.x = nearestSpawn.x;
				mPlayer.y = nearestSpawn.y;
			}
		}
		
	}

}