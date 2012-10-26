package com.brianshantz.fun 
{
	import com.brianshantz.fun.Config;
	import com.brianshantz.fun.entities.Basketball;
	import com.brianshantz.fun.entities.Player;
	import flash.display.MovieClip;
	import nape.constraint.DistanceJoint;
	import nape.constraint.LineJoint;
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
		private static const BALL_START_POS:Vec2 = new Vec2(Config.STAGE_WIDTH / 2, 100);
		private var space:Space;
		private var debug:ShapeDebug;
		
		private var basketball:Basketball;
		private var player1:Player;
		
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
			startGame();
			
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
		
		private function startGame():void
		{
			basketball = new Basketball(BodyType.DYNAMIC, new Vec2());
			basketball.position.setxy(BALL_START_POS.x, BALL_START_POS.y);
			basketball.space = space;
			
			player1 = new Player();
			player1.allowRotation = false;
			player1.space = space;
			
			//var pJoint:LineJoint = new LineJoint(space.world, player1, new Vec2(), new Vec2(), new Vec2(0, 1), 0, 0);
			//pJoint.space = space;
		}
		
		private function handleKeyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode) {
				case 38:
					player1.applyLocalForce(new Vec2(5000, 0));
					break;
				case 40:
					player1.applyLocalForce(new Vec2(-5000, 0));
					break;
			}
		}
		
		private function handleKeyUp(e:KeyboardEvent):void
		{
			switch(e.keyCode) {
				case 38:
					
					break;
				case 40:
					
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
		
	}

}