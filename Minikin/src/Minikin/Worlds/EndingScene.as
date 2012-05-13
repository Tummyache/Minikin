package Minikin.Worlds 
{
	import flash.events.TextEvent;
	import flash.utils.Dictionary;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import Minikin.Global.MusicController;
	import net.flashpunk.FP
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class EndingScene extends World
	{
		
		public function EndingScene() 
		{
			FP.screen.color = 0x000000;
			
			MusicController.getInstance().loop("Title");
			
			var params:Dictionary = new Dictionary();
			params["width"] = 400;
			var goodbye:Text = new Text("", 200, 200, params);
			goodbye.wordWrap = true;
			goodbye.richText = "Well that was it, you discovered the fate of all the knights and killed the Hydra.\n I wish I could give you a better ending, but in 48 hours I'm lucky to have done this much.\n\nMade for Ludum Dare #23 (Tiny World)\n\nBy Nick Heckman\n\nSpecial thanks to all my friends who left me the hell alone all weekend!";
			
			
			add(new Entity(0, 0, goodbye));
		}
		
	}

}