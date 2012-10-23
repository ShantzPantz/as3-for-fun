package com.brianshantz.fun 
{
	import flash.display.MovieClip;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.ShapeDebug;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.core.Starling;
	import nape.phys.BodyType;
	
	/**
	 * ...
	 * @author Brian Shantz
	 */
	public class StarlingMain extends Sprite 
	{
		private static const WORLD_FORCE:Vec2 = new Vec2(0, 600);
		private static const FRAME_RATE:int = 60;
		private static const STAGE_WIDTH:int = 800;
		private static const STAGE_HEIGHT:int = 600;
		
		private var space:Space;
		private var debug:ShapeDebug;
		
		public function StarlingMain() 
		{
			space = new Space(WORLD_FORCE);
			
			// Create a movieclip to draw our Nape debug shapes and overlay on stage3D
			debug = new ShapeDebug(STAGE_WIDTH, STAGE_HEIGHT, 0x333333);	
			var MovieClipDebug:MovieClip = new flash.display.MovieClip();
			MovieClipDebug.addChild(debug.display);
			Starling.current.nativeOverlay.addChild(MovieClipDebug);
			
			var border:Body = new Body(BodyType.STATIC);
			border.shapes.add(new Polygon(Polygon.rect(0, 0, -40, STAGE_HEIGHT))); // left wall
			border.shapes.add(new Polygon(Polygon.rect(STAGE_WIDTH, 0, 40, STAGE_HEIGHT))); // right wall
			border.shapes.add(new Polygon(Polygon.rect(0, 0, STAGE_WIDTH, -40))); // top
			border.shapes.add(new Polygon(Polygon.rect(0, STAGE_HEIGHT, STAGE_WIDTH, 40))); // bottom
			border.space = space;
			
			var block:Polygon = new Polygon(Polygon.box(50, 50));
			var body:Body = new Body(BodyType.DYNAMIC);
			
			body.shapes.add(block);
			body.position.setxy(STAGE_WIDTH / 2, STAGE_HEIGHT / 2);
			body.space = space;
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{
			debug.clear();
			space.step(1 / FRAME_RATE, 10, 10);
			debug.draw(space);
			debug.flush();
		}
		
	}

}