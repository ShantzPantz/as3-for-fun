package com.brianshantz.fun 
{
	import com.brianshantz.fun.Config;
	import flash.display.MovieClip;
	import nape.constraint.DistanceJoint;
	import nape.constraint.MotorJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Circle;
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
	import starling.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author Brian Shantz
	 */
	public class StarlingMain extends Sprite 
	{
		private var space:Space;
		private var debug:ShapeDebug;
		
		private var wheel1:MotorJoint;
		private var wheel2:MotorJoint;
		private var wheelSpeed:Number = 0;
		
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
			createVehicle();
			
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp); 
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
		
		private function createVehicle():void
		{
			var wheelBody: Body = new Body(BodyType.DYNAMIC);
			wheelBody.shapes.add(new Circle(20));
			wheelBody.position.setxy(450, 100);
			wheelBody.torque = 4;
			wheelBody.space = space;
			wheelBody.gravMass = 1.5;
			wheelBody.mass = 20;
					
			var wheelBody2 : Body = new Body(BodyType.DYNAMIC);
			wheelBody2.shapes.add(new Circle(10));
			wheelBody2.position.setxy(425,100);
			wheelBody2.space = space;
					
			var joint:DistanceJoint = new DistanceJoint(wheelBody, wheelBody2, new Vec2(0, 0), new Vec2(0, 0), 100, 100);
	
			joint.space = space;
			joint.stiff = true;
			
			wheel1 = new MotorJoint(space.world, wheelBody, wheelSpeed , 1);
			wheel1.space = space;	
			
			wheel2 = new MotorJoint(space.world, wheelBody2, wheelSpeed, 1);
			wheel2.space = space;	
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
		
		
		private function handleKeyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode) {
				case 38:
					wheel1.rate = 50;
					wheel2.rate = 50;
					break;
				case 40:
					wheel1.rate = -50;
					wheel2.rate = -50;
					break;
			}
		}
		
		private function handleKeyUp(e:KeyboardEvent):void
		{
			switch(e.keyCode) {
				case 38:
					wheel1.rate = 0;
					wheel2.rate = 0;
					break;
				case 40:
					wheel1.rate = 0;
					wheel2.rate = 0;
					break;
			}
		}
		
		private function handleTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				if(touch.phase == TouchPhase.BEGAN)
				{
					
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