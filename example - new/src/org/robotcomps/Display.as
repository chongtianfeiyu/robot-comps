package org.robotcomps
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	
	import org.robotcomps.core.Bitmaps;
	import org.robotcomps.core.display.IContainer;
	import org.robotcomps.core.display.IImage;
	import org.robotcomps.core.display.IPlugin;
	import org.robotcomps.core.display.NativePlugin;
	import org.robotcomps.core.display.StarlingPlugin;
	import org.robotcomps.core.display.data.RenderMode;
	import org.robotcomps.style.data.ColorTheme;

	public class Display
	{
		public static var ACCENT:String = "accent";
		public static var BG_LIGHT:String = "bgLight";
		public static var BG_DARK:String = "bgDark";
		
		protected static var texturesByType:Object;
		protected static var texturesByColor:Object;
		protected static var texturesByBitmap:Dictionary;		
		protected static var bitmapsByType:Object;
		
		protected static var plugin:IPlugin;
		
		public static function init():void {
			if (RobotComps.renderMode == RenderMode.STARLING) {
				plugin = new StarlingPlugin();
			} else {
				plugin = new NativePlugin();
			}
			reset();
		}
		
		public static function reset():void {
			texturesByType = {};
			texturesByColor = {};
			texturesByBitmap = new Dictionary();
			bitmapsByType = {};
		}
		
		public static function getContainer():IContainer {
			return plugin.getContainer();
		}
		
		public static function getImage(bitmapData:BitmapData = null):IImage {
			if(!bitmapData){ bitmapData = Bitmaps.TRANSPARENT; }
			var texture:* = texturesByBitmap[bitmapData];
			if(!texture){
				texture = plugin.createTexture(bitmapData);
				texturesByBitmap[bitmapData] = texture;
			}
			return plugin.getImage(texture);
		}
				
		public static function getImageByType(type:String):IImage {
			var texture:* = texturesByType[type];
			if(!texture){
				var bitmapData:BitmapData = getBitmapByType(type);
				texture = plugin.createTexture(bitmapData);
				texturesByType[type] = texture;
			}
			return plugin.getImage(texture);
		}
		
		public static function getImageByColor(color:uint):IImage {
			var string:String = "#" + color;
			var texture:* = texturesByColor[string];
			if(!texture){
				var bitmapData:BitmapData = new BitmapData(2, 2, false, color);
				texture = plugin.createTexture(bitmapData);
				texturesByColor[string] = texture;
			}
			return plugin.getImage(texture);
			
		}
		
		public static function getImageFromBitmap(bitmap:Bitmap):IImage {
			return getImage(bitmap.bitmapData);
		}
		
		public static function updateColorTheme(value:ColorTheme):void {
			var bitmapData:BitmapData;
			for(var o:* in texturesByType){
				if(o in value == false){ return; }
				bitmapData = getBitmapByType(o);
				plugin.updateTexture(texturesByType[o], bitmapData);
			}
		}
		
		public static function updateImage(image:IImage, bitmapData:BitmapData):void {
			plugin.updateImage(image, bitmapData);
		}
		
		public static function setTextureByType(bitmapData:BitmapData, type:String):void {
			texturesByType[type] = bitmapData;
		}
		
		public static function getBitmapByType(type:String):BitmapData {
			var bitmapData:BitmapData;
			if(type in RobotComps.theme){
				bitmapData = bitmapsByType[type];
				if(!bitmapData){
					bitmapData = new BitmapData(2, 2, false, RobotComps.theme[type]);
				}
			} else {
				bitmapData = Bitmaps[type];
			}
			return bitmapData;
		}
		
	}
}