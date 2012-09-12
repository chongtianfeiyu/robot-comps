package org.robotcomps
{
	import flash.display.Stage;
	import flash.events.Event;
	
	import org.osflash.signals.Signal;
	import org.robotcomps.core.Bitmaps;
	import org.robotcomps.dialogs.DialogManager;
	import org.robotcomps.style.Themes;
	import org.robotcomps.style.data.ColorTheme;

	public class RobotComps
	{
		public static var stage:Stage;
		public static var renderMode:String;
		public static var fontSize:int;
		public static var theme:ColorTheme;
		public static var hitSize:int = 50;
		
		public static var stageResized:Signal;
		public static var themeChanged:Signal;
		
		/**
		 * Initialize RobotComps and make it ready for use. This should be done after you have initialized your Stage3D rendering engine.
		 * @param stage - The root stage of your application. This is used to track mouse events and determine application size.
		 * @param root - The root display object for the Dialog Manager to use.
		 * @param renderMode - The RenderType to use (Native, Starling, etc)
		 * @param fontSize - Default Font Size 
		 * @param theme - Default Theme 
		 * 
		 */
		public static function init(stage:Stage, root:*, renderMode:String = "native", fontSize:int = 20, theme:ColorTheme = null):void {
			
			RobotComps.renderMode = renderMode;
			RobotComps.fontSize = fontSize;
			RobotComps.stage = stage;
			stage.addEventListener(Event.RESIZE, onStageResized, false, 0, true);
			
			stageResized = new Signal(int, int);
			themeChanged = new Signal(ColorTheme);
			
			Device.init(stage);
			Bitmaps.init();
			Display.init();
			Themes.init();
			
			setTheme((theme)? theme : Themes.getTheme(Themes.BLUE));
			DialogManager.init(root, stage);
			
		}
		
		protected static function onStageResized(event:Event):void {
			stageResized.dispatch(stage.stageWidth, stage.stageHeight);
		}
		
		/**
		 * Change the color theme for the running application.
		 * @param value
		 * 
		 */
		public static function setTheme(value:ColorTheme):void {
			theme = value;
			Display.setColorTheme(value);
			TextFields.setColor(value.text, value.accent);
			themeChanged.dispatch(value);
		}
		
	}
}