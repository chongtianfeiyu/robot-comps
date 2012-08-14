package org.robotcomps
{
	import flash.display.Stage;
	
	import org.robotcomps.style.ColorTheme;
	import org.robotcomps.style.Themes;

	public class RobotComps
	{
		public static var stage:Stage;
		public static var renderMode:String;
		public static var fontSize:int;
		public static var theme:ColorTheme;
		
		
		public static function init(stage:Stage, renderMode:String = "native", fontSize:int = 14, theme:ColorTheme = null):void {
			
			RobotComps.renderMode = renderMode;
			RobotComps.fontSize = fontSize;
			RobotComps.stage = stage;
			
			Themes.init();
			setTheme((theme)? theme : Themes.BLUE);
			
		}
		
		public static function setTheme(value:ColorTheme):void {
			theme = value;
		}
		
	}
}