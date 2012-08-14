package org.robotcomps.style
{
	import com.gskinner.motion.easing.Quadratic;

	public class Animations
	{
		public static var SHORT:Number = .35;
		public static var NORMAL:Number = .55;
		public static var LONG:Number = .8;
		
		public static var EASE_OUT:Function = Quadratic.easeOut;
		public static var EASE_IN:Function = Quadratic.easeIn;
	}
}