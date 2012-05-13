package Minikin.Objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import Minikin.Global.GameDetails;
	
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class Interface extends Entity 
	{
		public var mSprite:Graphiclist;
		public var mHealthBar:Image;
		public var mBackground:Image;
		
		public function Interface() 
		{
			mSprite = new Graphiclist();
			
			mBackground = Image.createRect(800, 24, 0x000000);
			mSprite.add(mBackground);
			
			mHealthBar = Image.createRect(1, 20, 0xFF0000, 1.0);
			mHealthBar.x = 100;
			mHealthBar.y = 2;
			mHealthBar.scaleX = 700;
			
			mSprite.add(mHealthBar);
			
			var hpText:Text = new Text("Health", 5, 5);
			hpText.size = 20;
			
			mSprite.add(hpText);
			
			layer = -10000001;
			
			graphic = mSprite;
		}
		
		override public function update():void 
		{
			super.update();
			
			mHealthBar.scaleX = (GameDetails.GetInstance().mHealth / GameDetails.GetInstance().mMaxHealth)*700;
		}
	}

}