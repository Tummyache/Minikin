package Minikin
{
	import flash.display.Sprite;
	import flash.events.Event;
	import Minikin.Worlds.BaseWorld;
	import Minikin.Worlds.EndingScene;
	import Minikin.Worlds.TitleScreen;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class Main extends Engine 
	{
		
		public function Main():void 
		{
			super(800, 600);
			FP.console.enable();
			//FP.world = new TitleScreen();
			FP.world = new BaseWorld("Castle", 0, 200);
		}
		
	}
	
}