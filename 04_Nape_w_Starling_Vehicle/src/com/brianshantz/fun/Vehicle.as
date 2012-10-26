package com.brianshantz.fun 
{
	import nape.constraint.DistanceJoint;
	import nape.constraint.LineJoint;
	import nape.constraint.MotorJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.space.Space;
	import starling.display.Sprite;
	import nape.phys.BodyType;
	
	/**
	 * ...
	 * @author Brian Shantz
	 */
	public class Vehicle extends Sprite 
	{
		private static const WHEEL_SIZE:Number = 20;
		private static const WHEEL_TORQUE:Number = 10;
		private static const WHEEL_GRAV_MASS:Number = 10;
		private static const WHEEL_MASS:Number = 10;
		
		public var body:Body;
		public var rearWheelBody:Body;
		public var frontWheelBody:Body;
		public var rearWheel:MotorJoint;
		public var frontWheel:MotorJoint;
		
		// Suspension
		public var rearStrut:LineJoint;
		public var frontStrut:LineJoint;
		
		public var rearSpring:DistanceJoint;
		public var frontSpring:DistanceJoint;
		
		public function Vehicle(space:Space, posX:Number=0, posY:Number=0) 
		{
			body = new Body(BodyType.DYNAMIC);
			body.shapes.add(new Polygon(Polygon.box(100, 50)));
			body.position.setxy(posX + 50, posY - 50);
			body.space = space;
			
			rearWheelBody = new Body(BodyType.DYNAMIC);
			rearWheelBody.shapes.add(new Circle(WHEEL_SIZE));
			rearWheelBody.position.setxy(posX, posY);
			rearWheelBody.space = space;
			
			frontWheelBody = new Body(BodyType.DYNAMIC);
			frontWheelBody.shapes.add(new Circle(WHEEL_SIZE));
			frontWheelBody.position.setxy(posX + 100, posY);
			frontWheelBody.space = space;
			
			rearStrut = new LineJoint(body, rearWheelBody, new Vec2( -50, 0), new Vec2(0, 0), new Vec2(0, 1), 0, 60);
			rearStrut.ignore = true;
			rearStrut.space = space;
			
			frontStrut = new LineJoint(body, frontWheelBody, new Vec2(50, 0), new Vec2(0, 0), new Vec2(0, 1), 0, 60);
			frontStrut.ignore = true;
			frontStrut.space = space;
			
			rearSpring = new DistanceJoint(body, rearWheelBody, new Vec2(-50, 0), new Vec2(0, 0), 40, 40);
			rearSpring.stiff = false;
			rearSpring.frequency = 5;
			rearSpring.damping = 1;
			rearSpring.space = space;
			
			rearSpring = new DistanceJoint(body, frontWheelBody, new Vec2(50, 0), new Vec2(0, 0), 40, 40);
			rearSpring.stiff = false;
			rearSpring.frequency = 5;
			rearSpring.damping = 1;
			rearSpring.space = space;
			
			rearWheel = new MotorJoint(space.world, rearWheelBody, 0, 1);
			rearWheel.space = space;
			
			frontWheel = new MotorJoint(space.world, frontWheelBody, 0, 1);
			frontWheel.space = space;	
		}
		
		public function set speed(s:Number):void {
			rearWheel.rate = s;
			frontWheel.rate = s;
		}
		
	}

}