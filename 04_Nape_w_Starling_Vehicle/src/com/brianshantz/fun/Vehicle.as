package com.brianshantz.fun 
{
	import nape.constraint.DistanceJoint;
	import nape.constraint.MotorJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Circle;
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
		
		public var rearWheelBody:Body;
		public var frontWheelBody:Body;
		public var rearWheel:MotorJoint;
		public var frontWheel:MotorJoint;
		public var joint:DistanceJoint;
		
		public function Vehicle(space:Space, posX:Number=0, posY:Number=0) 
		{
			rearWheelBody = new Body(BodyType.DYNAMIC);
			rearWheelBody.shapes.add(new Circle(WHEEL_SIZE));
			rearWheelBody.position.setxy(posX, posY);
			rearWheelBody.space = space;
			
			frontWheelBody = new Body(BodyType.DYNAMIC);
			frontWheelBody.shapes.add(new Circle(WHEEL_SIZE));
			frontWheelBody.position.setxy(posX + 100, posY);
			frontWheelBody.space = space;
			
			joint = new DistanceJoint(rearWheelBody, frontWheelBody, new Vec2(0, 0), new Vec2(0, 0), 100, 100);
			joint.stiff = true;
			joint.space = space;
			
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