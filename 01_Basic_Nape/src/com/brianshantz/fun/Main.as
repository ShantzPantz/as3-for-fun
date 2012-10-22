package com.brianshantz.fun
{
	import flash.display.Sprite;
	import flash.events.Event;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.ShapeDebug;
	import nape.phys.BodyType;
	
	/**
	 * ...
	 * @author Brian Shantz
	 */
	public class Main extends Sprite 
	{
		
		private static const WORLD_FORCE:Vec2 = new Vec2(0, 600);
		
		private var space:Space;
		private var debug:ShapeDebug;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			space = new Space(WORLD_FORCE);
			
			debug = new ShapeDebug(stage.stageWidth, stage.stageHeight, 0x333333);
			addChild(debug.display);
			
			var border:Body = new Body(BodyType.STATIC);
			border.shapes.add(new Polygon(Polygon.rect(0, 0, -40, stage.stageHeight))); // left wall
			border.shapes.add(new Polygon(Polygon.rect(stage.stageWidth, 0, 40, stage.stageHeight))); // right wall
			border.shapes.add(new Polygon(Polygon.rect(0, 0, stage.stageWidth, -40))); // top
			border.shapes.add(new Polygon(Polygon.rect(0, stage.stageHeight, stage.stageWidth, 40))); // bottom
			border.space = space;
			
			var block:Polygon = new Polygon(Polygon.box(50, 50));
			var body:Body = new Body(BodyType.DYNAMIC);
			
			body.shapes.add(block);
			body.position.setxy(stage.stageWidth / 2, stage.stageHeight / 2);
			body.space = space;
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{
			debug.clear();
			space.step(1 / stage.frameRate, 10, 10);
			debug.draw(space);
			debug.flush();
		}
		
	}
	
}