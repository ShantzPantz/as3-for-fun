package com.brianshantz.fun.entities 
{
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	
	/**
	 * ...
	 * @author Brian Shantz
	 */
	public class Player extends Body 
	{
		
		public function Player() 
		{
			super(BodyType.DYNAMIC, new Vec2(0, 0));

			var head:Circle = new Circle(20);
			var body:Polygon = new Polygon(Polygon.rect( -10, 10, 20, 40));
			shapes.add(head);
			shapes.add(body);
		}
		
	}

}