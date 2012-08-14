package org.robotcomps.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import org.robotcomps.RobotComps;
	import org.robotcomps.core.display.DisplayType;
	import org.robotcomps.core.display.IContainer;
	import org.robotcomps.core.display.IImage;
	import org.robotcomps.core.display.NativeContainer;
	import org.robotcomps.core.display.NativeImage;
	import org.robotcomps.core.display.StarlingContainer;
	import org.robotcomps.core.display.StarlingImage;
	
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;

	public class Display
	{
		public static var ACCENT:String = "accent";
		public static var BG_LIGHT:String = "bgLight";
		public static var BG_DARK:String = "bgDark";
		
		protected static var starlingTextures:Dictionary = new Dictionary(true);
		
		public static function getContainer():IContainer {
			if(RobotComps.renderMode == DisplayType.STARLING){
				return new StarlingContainer();
			} 
			return new NativeContainer();
		}
		
		public static function getImage(bitmapData:BitmapData):IImage {
			if(RobotComps.renderMode == DisplayType.NATIVE){
				//var texture:Texture = Texture.fromBitmapData(bitmapData);
				//return new StarlingImage(texture);
			}
			return new NativeImage(bitmapData);
		}
		
		public static function getImageByType(type:String):IImage {
			//For basic RobotComps components, type will simply determine color.
			//But this can easily be modified to use a pre-cached bitmap's, eg. BUTTON_1, BG_1 etc
			var bitmapData:BitmapData = new BitmapData(2, 2, false, RobotComps.theme[type]);
			
			if(RobotComps.renderMode == DisplayType.STARLING){
				var texture:RenderTexture = new RenderTexture(bitmapData.width, bitmapData.height, true, 1);
				var image:Image = new Image(Texture.fromBitmapData(bitmapData));
				texture.draw(image);
				
				return new StarlingImage(texture);
			}
			return new NativeImage(bitmapData);
		}
	}
}