package com.brianshantz.fun.entities 
{
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	
	/**
	 * ...
	 * @author Brian Shantz
	 */
	public class Basketball extends Body 
	{
		private static const BOUNCE:Number = 1.5;
		
		private var material:Material = new Material(BOUNCE);
		
		public function Basketball(type:BodyType, position:Vec2) 
		{
			super(type, position);
			shapes.add(new Circle(20, new Vec2(0,0), material));
		}
		
	}

}