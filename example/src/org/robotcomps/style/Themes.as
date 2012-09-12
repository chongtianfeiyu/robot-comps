package org.robotcomps.style
{
	import org.robotcomps.style.data.ColorTheme;

	public class Themes
	{
		public static var BLUE:String = "Themes.BLUE";
		public static var GREEN:String = "Themes.GREEN";
		public static var RED:String = "Themes.RED";
		
		public static var WHITE_BLUE:String = "Themes.WHITE_BLUE";
		public static var WHITE_GREEN:String = "Themes.WHITE_GREEN";
		public static var WHITE_RED:String = "Themes.WHITE_RED";
		
		protected static var hash:Object;
		
		public static function init():void {

			hash = {};
			
			addTheme(BLUE, new ColorTheme(0x33b5e5, 0xFFFFFF, 0x3d3d3d, 0x282828));
			addTheme(GREEN, new ColorTheme(0x10a263, 0xFFFFFF, 0x3d3d3d, 0x282828));
			addTheme(RED, new ColorTheme(0xb61212, 0xFFFFFF, 0x3d3d3d, 0x282828));

			addTheme(WHITE_BLUE, new ColorTheme(0x33b5e5, 0x222222, 0xcbcbcb, 0xf2f2f2));
			addTheme(WHITE_GREEN, new ColorTheme(0x10a263, 0x222222, 0xcbcbcb, 0xf2f2f2));
			addTheme(WHITE_RED, new ColorTheme(0xb61212, 0x222222, 0xcbcbcb, 0xf2f2f2));
		}
		
		public static function getTheme(type:String):ColorTheme {
			return hash[type];
		}
		
		public static function getAllThemes():Vector.<ColorTheme> {
			var themes:Vector.<ColorTheme> = new <ColorTheme>[];
			for(var p:* in hash){
				themes.push(hash[p]);
			}
			return themes;
		}
		
		public static function addTheme(type:String, theme:ColorTheme):void {
			hash[type] = theme;
		}
		
		public static function reset():void {
			hash = {};
		}
	}
}