package com.brianshantz.fun 
{
	import starling.display.Sprite;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Brian Shantz
	 */
	public class Block extends Sprite 
	{
		
		public function Block() 
		{
			addChild(Image.fromBitmap(new Resource.BlockImg()));
			pivotX = this.width / 2;
			pivotY = this.height / 2;
		}
		
	}

}