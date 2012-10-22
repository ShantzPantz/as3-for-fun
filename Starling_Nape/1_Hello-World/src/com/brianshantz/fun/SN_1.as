package com.brianshantz.fun 
{
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.shape.Shape;
	import nape.space.Space;
	import nape.util.ShapeDebug;
	import nape.phys.BodyType;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.core.Starling;
	
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Brian Shantz
	 */
	public class SN_1 extends Sprite 
	{
		private var debug:ShapeDebug;
		private var space:Space;
		
		public function SN_1() 
		{
			// Set up space
			space = new Space(new Vec2(0, 600));
			
			// Setup debug shit.
			debug = new ShapeDebug(800, 480, 0x33333333);
			debug.draw(space);
			
			var MovieClipDebug:flash.display.MovieClip = new flash.display.MovieClip();
			MovieClipDebug.addChild(debug.display);
			
			Starling.current.nativeOverlay.addChild(MovieClipDebug);
			
			createShit();
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function createShit():void
		{
			var b:Body = new Body(BodyType.STATIC);
			b.shapes.add(new Polygon(Polygon.box(800, 20)));
			b.space = space;
			
			var c:Body = new Body(BodyType.DYNAMIC);
			c.shapes.add(new Circle(20));
			c.space = space;
		}
		
		private function update(e:Event):void 
		{
			debug.clear();
			
			space.step(1 / 60);
			
			debug.draw(space);
			debug.flush();
		}
		
		
	}

}