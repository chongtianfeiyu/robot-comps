package org.robotcomps.core
{
	
	import flash.display.BitmapData;
	
	public class Colors
	{
		
		public static var defaultText:int = 0xFFFFFF;
		
		public static var defaultAccent:int = 0x33b5e5;
		public static var defaultBgLight:int = 0x3d3d3d;
		public static var defaultBgDark:int = 0x282828;
		
		protected static var _accentColor:BitmapData;
		public static function get accentColor():BitmapData {
			if(!_accentColor){
				_accentColor = new BitmapData(1, 1, false, defaultAccent);
			}
			return _accentColor;
		}
		
		protected static var _backgroundLight:BitmapData;
		public static function get backgroundLight():BitmapData {
			if(!_backgroundLight){
				_backgroundLight = new BitmapData(1, 1, false, defaultBgLight);
			}
			return _backgroundLight;
		}
		
		protected static var _backgroundDark:BitmapData;
		public static function get backgroundDark():BitmapData {
			if(!_backgroundDark){
				_backgroundDark = new BitmapData(1, 1, false, defaultBgDark);
			}
			return _backgroundDark;
		}
		
		protected static var _black:BitmapData;
		public static function get black():BitmapData {
			if(!_black){
				_black = new BitmapData(1, 1, false, 0x0);
			}
			return _black;
		}
		
		protected static var _white:BitmapData;
		public static function get white():BitmapData {
			if(!_white){
				_white = new BitmapData(1, 1, false, 0xFFFFFF);
			}
			return _white;
		}
		
		protected static var _clear:BitmapData;
		public static function get clear():BitmapData {
			if(!_clear){
				_clear = new BitmapData(1, 1, true, 0x0);
			}
			return _clear;
		}
	}
}