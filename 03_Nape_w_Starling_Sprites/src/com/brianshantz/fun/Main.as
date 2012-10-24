package com.brianshantz.fun
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.ShapeDebug;
	import nape.phys.BodyType;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Brian Shantz
	 */
	public class Main extends Sprite 
	{
		private var _starling:Starling;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			_starling = new Starling(StarlingMain, stage, new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
			_starling.start();
			
		}
		
		
		
	}
	
}