package org.robotcomps
{
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	public class Device
	{
		protected static var _dialogSize:Rectangle;
		protected static var stage:Stage;
		
		public static function init(stage:Stage):void {
			Device.stage = stage;
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
		
		public static function get dialogWidth():int { return dialogSize.width; }
		public static function get dialogHeight():int { return dialogSize.height; }
		public static function get dialogSize():Rectangle {
			if(!_dialogSize){
				_dialogSize = new Rectangle();
			}
			var minWidth:int = Capabilities.screenDPI * 2.5;
			_dialogSize.width = Math.max(minWidth, stage.stageWidth * .65);
			_dialogSize.height = _dialogSize.width * .6;
			if(_dialogSize.height < 250){
				_dialogSize.height = 250;
			}
			return _dialogSize;	
		}
	}
}