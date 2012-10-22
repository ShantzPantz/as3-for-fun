package com.brianshantz.fun
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import com.brianshantz.fun.SN_1;
	
	/**
	 * ...
	 * @author Brian Shantz
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var s:Starling = new Starling(SN_1, stage, new Rectangle(0, 0, 800, 600));
			s.start();
		}
		
	}
	
}