package org.robotcomps.core
{
	import flash.display.BitmapData;

	public class Bitmaps
	{
		public static var WHITE:BitmapData;
		public static var BLACK:BitmapData;
		public static var TRANSPARENT:BitmapData;
		
		public static function init():void {
			WHITE = new BitmapData(2, 2, false, 0xFFFFFF);
			BLACK = new BitmapData(2, 2, false, 0x0);
			TRANSPARENT = new BitmapData(2, 2, true, 0x0);
		}
	}
}