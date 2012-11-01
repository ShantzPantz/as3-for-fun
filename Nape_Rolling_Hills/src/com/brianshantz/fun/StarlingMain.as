package com.brianshantz.fun 
{
	import com.brianshantz.fun.Config;
	import flash.display.MovieClip;
	import nape.geom.Vec2;
	import nape.geom.Vec2List;
	import nape.phys.Body;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.ShapeDebug;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.core.Starling;
	import nape.phys.BodyType;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Brian Shantz
	 */
	public class StarlingMain extends Sprite 
	{
		private var _space:Space;
		private var debug:ShapeDebug;
		
		public function StarlingMain() 
		{
			// Create Physics Space/World
			_space = new Space(Config.WORLD_FORCE);
			
			if ( Config.NAPE_DEBUG ) {
				debug = new ShapeDebug(Config.STAGE_WIDTH, Config.STAGE_HEIGHT, 0x333333);	
				var MovieClipDebug:MovieClip = new flash.display.MovieClip();
				MovieClipDebug.addChild(debug.display);
				Starling.current.nativeOverlay.addChild(MovieClipDebug);
			}
			
			Starling.current.stage.addEventListener(TouchEvent.TOUCH, handleTouch);
			addEventListener(Event.ENTER_FRAME, update);
			
		}
		
		private function drawHills(numberOfHills:int, pixelStep:int):void {
			_space = new Space(Config.WORLD_FORCE);
			var hillStartY:Number = 140 + Math.random() * 200;
			var hillWidth:Number = Config.STAGE_WIDTH / numberOfHills;
			var hillSliceWidth:Number = hillWidth / pixelStep;
			var hillVector:Vec2List;
			for (var i:int = 0; i < numberOfHills; i++) {
				var randomHeight:Number = Math.random() * 100;
				if (i != 0) {
					hillStartY -= randomHeight;
				}
				for (var j:int = 0; j < hillSliceWidth; j++) {
					hillVector = new Vec2List();
					hillVector.push(new Vec2(j * pixelStep + hillWidth * i, Config.STAGE_HEIGHT));
					hillVector.push(new Vec2(j * pixelStep + hillWidth * i, hillStartY + randomHeight * Math.cos(2 * Math.PI / hillSliceWidth * j)));
					hillVector.push(new Vec2((j + 1) * pixelStep + hillWidth * i, hillStartY + randomHeight * Math.cos(2 * Math.PI / hillSliceWidth * (j + 1))));
					hillVector.push(new Vec2((j + 1) * pixelStep + hillWidth * i, Config.STAGE_HEIGHT));
					var sliceBody:Body = new Body(BodyType.STATIC);
					for (var z:int = 0; z < hillVector.length; z++) {
						sliceBody.shapes.add(new Polygon(hillVector));
					}
					sliceBody.space = _space;
				}
				hillStartY = hillStartY + randomHeight;
			}
		}
		
		private function handleTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				if(touch.phase == TouchPhase.BEGAN)
				{
					drawHills(2, 10);
				}
 
				else if(touch.phase == TouchPhase.ENDED)
				{
					
				}
 
				else if(touch.phase == TouchPhase.MOVED)
				{
					
				}
			}
		}
		
		
		private function update(e:Event):void
		{
			
			if (Config.NAPE_DEBUG) { debug.clear(); }
			
			// Loop Code here.
			_space.step(1 / Config.FRAME_RATE, 10, 10);
			
			if (Config.NAPE_DEBUG) {
				debug.draw(_space);
				debug.flush();
			}
			
		}
		
	}

}