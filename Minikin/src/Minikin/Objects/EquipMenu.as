package Minikin.Objects 
{
	import flash.utils.Dictionary;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import Minikin.Global.ImageManager;
	import Minikin.Global.GameDetails;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class EquipMenu extends Entity 
	{
		
		public var mMenu:Graphiclist;
		public var mCells:Array;
		public var mDescriptionShadow:Text;
		public var mDescription:Text;
		public var mSelected:int;
		
		public function EquipMenu() 
		{
			mMenu = new Graphiclist();
			mCells = new Array();
			
			for (var i:int = 0; i < 5; i++)
			{
				mCells[i] = new Image(ImageManager.IMG_EMPTY_CELL);
				mCells[i].x = 100 + i * 76;
				mCells[i].y = 100;
				(mCells[i] as Image).centerOO();
				mMenu.add(mCells[i]);
			}
			
			var tempSword:Image;
			if (GameDetails.GetInstance().mHasShortSword)
			{
				tempSword = new Image(ImageManager.IMG_SWORD);
				tempSword.x = mCells[0].x;
				tempSword.y = mCells[0].y;
				tempSword.centerOO();
				tempSword.angle = 45;
				mMenu.add(tempSword);
			}
			
			if (GameDetails.GetInstance().mHasLongSword)
			{
				tempSword = new Image(ImageManager.IMG_SWORD_LONG);
				tempSword.x = mCells[1].x;
				tempSword.y = mCells[1].y;
				tempSword.centerOO();
				tempSword.angle = 45;
				tempSword.smooth = true;
				mMenu.add(tempSword);
			}
			
			if (GameDetails.GetInstance().mHasBroadSword)
			{
				tempSword = new Image(ImageManager.IMG_SWORD_BIG);
				tempSword.x = mCells[2].x;
				tempSword.y = mCells[2].y;
				tempSword.centerOO();
				tempSword.angle = 45;
				tempSword.smooth = true;
				mMenu.add(tempSword);
			}
			
			if (GameDetails.GetInstance().mHasHolySword)
			{
				tempSword = new Image(ImageManager.IMG_SWORD_GIANT);
				tempSword.x = mCells[3].x;
				tempSword.y = mCells[3].y;
				tempSword.centerOO();
				tempSword.angle = 45;
				tempSword.smooth = true;
				mMenu.add(tempSword);
			}
			
			if (GameDetails.GetInstance().mHasKaiserSword)
			{
				tempSword = new Image(ImageManager.IMG_SWORD_KAISER);
				tempSword.x = mCells[4].x;
				tempSword.y = mCells[4].y;
				tempSword.centerOO();
				tempSword.angle = 45;
				tempSword.smooth = true;
				mMenu.add(tempSword);
			}
			
			var descBox:Image = new Image(ImageManager.IMG_DIALOG);
			descBox.x = 100;
			descBox.y = 150;
			mMenu.add(descBox);
			
			var ops:Dictionary = new Dictionary();
			ops["width"] = 316;
			mDescriptionShadow = new Text("", descBox.x+4, descBox.y+6, ops);
			mDescriptionShadow.richText = "Attack:3\nRange:Short";
			mDescriptionShadow.color = 0x000000;
			mDescriptionShadow.size = 20;
			mMenu.add(mDescriptionShadow);
			
			mDescription = new Text("", descBox.x+5, descBox.y+5, ops);
			mDescription.richText = "Attack:3\nRange:Short";
			mDescription.color = 0xFFFFFF;
			mDescription.size = 20;
			mMenu.add(mDescription);
			
			layer = -10000;
			
			mSelected = GameDetails.GetInstance().mCurrentSword;
			
			type = "EquipMenu";
			
			graphic = mMenu;
		}
		
		override public function update():void 
		{
			super.update();
			
			x = FP.camera.x;
			y = FP.camera.y;
			
			if (Input.pressed(Key.LEFT))
			{
				mSelected -= 1;
				if (mSelected < 0) mSelected = 4;
				
				if (!GameDetails.GetInstance().mHasKaiserSword && mSelected == 4) mSelected = 3;
				if (!GameDetails.GetInstance().mHasHolySword && mSelected == 3) mSelected = 2;
				if (!GameDetails.GetInstance().mHasBroadSword && mSelected == 2) mSelected = 1;
				if (!GameDetails.GetInstance().mHasLongSword && mSelected == 1) mSelected = 0;
				
				GameDetails.GetInstance().mCurrentSword = mSelected;
			}
			
			if (Input.pressed(Key.RIGHT))
			{
				mSelected += 1;
				if (mSelected > 4) mSelected = 0;
				
				if (!GameDetails.GetInstance().mHasLongSword && mSelected == 1) mSelected = 0;
				if (!GameDetails.GetInstance().mHasBroadSword && mSelected == 2) mSelected = 0;
				if (!GameDetails.GetInstance().mHasHolySword && mSelected == 3) mSelected = 0;
				if (!GameDetails.GetInstance().mHasKaiserSword && mSelected == 4) mSelected = 0;
				
				GameDetails.GetInstance().mCurrentSword = mSelected;
			}
			
			if (mSelected == 0)
			{
				mDescriptionShadow.richText = "Short Sword\nAttack:2~2\nRange:Short";
			}
			if (mSelected == 1)
			{
				mDescriptionShadow.richText = "Long Sword\nAttack:4~2\nRange:Long";
			}
			if (mSelected == 2)
			{
				mDescriptionShadow.richText = "Broad Sword\nAttack:5~4\nRange:Very Long";
			}
			if (mSelected == 3)
			{
				mDescriptionShadow.richText = "Holy Sword\nAttack:9~6\nRange:Very Very Long";
			}
			if (mSelected == 4)
			{
				mDescriptionShadow.richText = "Ancient Sword\nAttack:15~10\nRange:Extremely Long";
			}
			mDescription.richText = mDescriptionShadow.richText;
			
			for (var i:int = 0; i < mCells.length; i++)
			{
				(mCells[i] as Image).color = 0xFFFFFF;
			}
			(mCells[mSelected] as Image).color = 0xFFFF00;
		}
	}

}