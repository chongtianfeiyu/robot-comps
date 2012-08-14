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
	import org.robotcomps.style.ColorTheme;
	
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;

	public class Display
	{
		public static var ACCENT:String = "accent";
		public static var BG_LIGHT:String = "bgLight";
		public static var BG_DARK:String = "bgDark";
		
		protected static var texturesByType:Object = {};
		
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
			//Starling
			if(RobotComps.renderMode == DisplayType.STARLING){
				var starlingTexture:RenderTexture = texturesByType[type];
				if(!starlingTexture){
					var bitmapData:BitmapData = getBitmapByType(type);
					var image:Image = new Image(Texture.fromBitmapData(bitmapData));
					starlingTexture = new RenderTexture(bitmapData.width, bitmapData.height, true, 1);
					starlingTexture.draw(image);
					texturesByType[type] = starlingTexture;
				}
				return new StarlingImage(starlingTexture);
			}
			
			//Native
			var bitmapData:BitmapData = texturesByType[type];
			if(!bitmapData){ 
				bitmapData = getBitmapByType(type);
				texturesByType[type] = bitmapData;
			}
			return new NativeImage(bitmapData);
		}
		
		//By default we'll use type to control the color of our shared textures.
		protected static function getBitmapByType(type:String):BitmapData {
			return new BitmapData(2, 2, false, RobotComps.theme[type]);
		}
		
		public static function reset():void {
			texturesByType = {};
		}
		
		public static function updateColorTheme(value:ColorTheme):void {
			var bitmapData:BitmapData;
			for(var o:* in texturesByType){
				if(o in value == false){ return; }
				if(texturesByType[o] is BitmapData){
					bitmapData = texturesByType[o];
					bitmapData.fillRect(bitmapData.rect, value[o]);
				}
				else if(texturesByType[o] is RenderTexture){
					bitmapData = getBitmapByType(o);
					var image:Image = new Image(Texture.fromBitmapData(bitmapData));
					texturesByType[o].draw(image);
				}
			}
			
		}
	}
}