package org.robotcomps.style
{
	public class Themes
	{
		public static var BLUE:ColorTheme;
		public static var GREEN:ColorTheme;
		public static var RED:ColorTheme;
		/*
		public static var BLUE:Number = 0x33b5e5;
		public static var AQUA:Number = 0x1f6782;
		public static var RED:Number = 0xb61212;
		public static var GREEN:Number = 0x10a263;
		public static var PURPLE:Number = 0x7f42ee;
		public static var BRONZE:Number = 0x8e4703;
		public static var PINK:Number = 0xe31dc0;
		*/
		
		public static function init():void {

			BLUE = new ColorTheme(0x33b5e5, 0xFFFFFF, 0x3d3d3d, 0x282828);
			GREEN = new ColorTheme(0x10a263, 0xFFFFFF, 0x3d3d3d, 0x282828);
			RED = new ColorTheme(0xb61212, 0xFFFFFF, 0x3d3d3d, 0x282828);
			
			

		}
	}
}