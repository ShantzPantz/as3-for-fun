package com.brianshantz.fun 
{
	import com.brianshantz.fun.Config;
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
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Brian Shantz
	 */
	public class StarlingMain extends Sprite 
	{
		private var space:Space;
		private var debug:ShapeDebug;
		
		public function StarlingMain() 
		{
			// Create Physics Space/World
			space = new Space(Config.WORLD_FORCE);
			
			if ( Config.NAPE_DEBUG ) {
				debug = new ShapeDebug(Config.STAGE_WIDTH, Config.STAGE_HEIGHT, 0x333333);	
				var MovieClipDebug:MovieClip = new flash.display.MovieClip();
				MovieClipDebug.addChild(debug.display);
				Starling.current.nativeOverlay.addChild(MovieClipDebug);
			}
			
			// Create Bodies
			createBorder();
			
			Starling.current.stage.addEventListener(TouchEvent.TOUCH, handleTouch);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function createBorder():void
		{
			var border:Body = new Body(BodyType.STATIC);
			border.shapes.add(new Polygon(Polygon.rect(0, 0, -40, Config.STAGE_HEIGHT))); // left wall
			border.shapes.add(new Polygon(Polygon.rect(Config.STAGE_WIDTH, 0, 40, Config.STAGE_HEIGHT))); // right wall
			border.shapes.add(new Polygon(Polygon.rect(0, 0, Config.STAGE_WIDTH, -40))); // top
			border.shapes.add(new Polygon(Polygon.rect(0, Config.STAGE_HEIGHT, Config.STAGE_WIDTH, 40))); // bottom
			border.space = space;
		}
		
		private function createBlock(x:Number, y:Number):void
		{
			// create instance of the graphic for this body
			var graphic:Block = new Block();
			var block:Polygon = new Polygon(Polygon.box(graphic.width, graphic.height));
			var body:Body = new Body(BodyType.DYNAMIC);
			body.shapes.add(block);
			body.position.setxy(x, y);
			body.graphic = graphic;
			body.space = space;
			body.graphicUpdate = updateGraphics;
			addChild(body.graphic);
		}
		
		private function handleTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				if(touch.phase == TouchPhase.BEGAN)
				{
					createBlock(touch.globalX, touch.globalY);
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
			space.step(1 / Config.FRAME_RATE, 10, 10);
			
			if (Config.NAPE_DEBUG) {
				debug.draw(space);
				debug.flush();
			}
			
		}
		
		private function updateGraphics(b:Body):void
		{
			b.graphic.x = b.position.x;
			b.graphic.y = b.position.y;
			b.graphic.rotation = b.rotation;
		}
		
	}

}