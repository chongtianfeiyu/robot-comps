package org.robotcomps
{
	import flash.display.Stage;
	import flash.system.Capabilities;

	public class Device
	{
		public static function init(stage:Stage):void {
			_hitSize = Capabilities.screenDPI * .50;
		}
		
		public static function get screenScale():Number {
			return 1;
		}
		
		protected static var _hitSize:int;
		public static function get hitSize():int {
			return _hitSize;
		}
		
		public static function get isTablet():Boolean {
			return true;
		}
		
	}
}