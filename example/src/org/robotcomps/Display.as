package org.robotcomps
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageQuality;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
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
		public static var DIVIDER:String = "divider";
		public static var BG:String = "bg";
		
		public static var showSpriteSheet:Boolean = true;
		
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
			bitmapsByType = {};
		}
		
		public static function getContainer():IContainer {
			return plugin.getContainer();
		}
		
		/** Returns a new IImage object from a given bitmapData. Will only create one texture for each unique bitmapData.  **/
		public static function getImage(bitmapData:BitmapData = null):IImage {
			if(!bitmapData){ bitmapData = Bitmaps.TRANSPARENT; }
			return plugin.getImage(bitmapData);
		}
		
		/** Returns a new IImage object based on texture type. **/
		public static function getImageByType(type:String):IImage {
			var bitmapData:BitmapData = getTextureByType(type);
			if(!bitmapData){ 
				trace("[Display] Unable to find bitmap source for type: " + type);
				return null; 
			}
			return plugin.getImage(bitmapData);
		}
		
		/** Returns a new IImage object from on a solid color (24bit). **/
		public static function getImageByColor(color:uint):IImage {
			
			var string:String = "#" + color;
			var texture:BitmapData = bitmapsByType[string];
			if(!texture){
				texture = new BitmapData(2, 2, false, color);
				bitmapsByType[string] = texture;
			}
			return plugin.getImage(texture);
		}

		/**
		 * Get a bitmapData by type.
		 **/
		public static function getTextureByType(type:String):BitmapData {
			var bitmapData:BitmapData = bitmapsByType[type];
			//trace("Getting Type: ", type, bitmapData);
			if(!bitmapData){
				var theme:ColorTheme = RobotComps.theme;
				if(type in RobotComps.theme){
					bitmapData = new BitmapData(2, 2, false, RobotComps.theme[type]);
					setTextureByType(type, bitmapData);
				} else {
					bitmapData = Bitmaps[type];
				} 
			}
			return bitmapData;
		}
		
		/**
		 * Add a new type of texture to the cache.
		 **/
		public static function setTextureByType(type:String, bitmapData:BitmapData):void {
			bitmapsByType[type] = bitmapData;
			plugin.createTexture(bitmapData);
			//trace("Setting Type: ", type);
		}
		
		
		/**
		 * Updates a texture with a new bitmapData object; 
		 **/
		public static function updateTexture(target:BitmapData, source:BitmapData):void {
			plugin.updateTexture(target, source);
		}
		
		/**
		 * Update an image with a new bitmapData.
		 **/
		public static function updateImage(image:IImage, bitmapData:BitmapData):void {
			plugin.setTexture(image, bitmapData);
		}
		
		/**
		 * Swaps textures between two image objects 
		 **/
		public static function swapTextures(target:IImage, source:IImage):void {
			plugin.swapTextures(target, source);
		}
		
		/**
		 * Release texture / bitmapData from memory
		 **/
		public static function releaseTexture(texture:BitmapData):void {
			if(!texture){ return; }
			plugin.releaseTexture(texture);
		}
		
		/**
		 * Release texture / bitmapData from memory
		 **/
		public static function releaseTextureByType(type:String):void {
			plugin.releaseTexture(bitmapsByType[type]);
			delete bitmapsByType[type];
		}

		/**
		 * Loops through the texture cache and updates the color theme. It simply looks for textureTypes that match property names in the current ColorTheme (ie 'bg', 'accent' etc)
		 */
		public static function setColorTheme(theme:ColorTheme):void {
			var bitmapData:BitmapData;
			for(var o:* in bitmapsByType){
				if(o in theme == false){ continue; }
				bitmapData = bitmapsByType[o];
				Display.tint(bitmapData, theme[o]);
				updateTexture(bitmapData, bitmapData);
			}
		}
		
		/**
		 * Cache a native flash displayObject.
		 **/
		public static function cache(target:DisplayObject, scale:Number = 1, padding:int = 0, alpha:Boolean = true, color:uint = 0x0):BitmapData
		{
			target.scaleX = target.scaleY = 1;
			
			var rect:Rectangle = target.getBounds(target);
			rect.width += padding;
			rect.height += padding;
			
			rect.x -= padding/2;
			rect.y -= padding/2;
			
			var bmpData:BitmapData = new BitmapData(rect.width * scale, rect.height * scale, alpha, color);
			var m:Matrix = new Matrix(1,0,0,1, -rect.x, -rect.y);
			m.scale(scale, scale);
			bmpData.drawWithQuality(target, m, null, null, null, true, StageQuality.HIGH);
			return bmpData;
		}
		
		
		public static function tint(bitmapData:BitmapData, color:uint):void {
			
			var vec:Vector.<uint> = bitmapData.getVector(bitmapData.rect);
			for(var i:int = 0, l:int = vec.length; i < l; i++){
				var a:uint = vec[i] & 0xFF000000;
				if(a != 0){
					vec[i] = (color & 0x00FFFFFF) | (a);
				}
			}
			bitmapData.setVector(bitmapData.rect, vec);
		}
		
		public static function tintByType(type:String, color:uint):void {
			var bitmapData:BitmapData = Display.getTextureByType(type);
			tint(bitmapData, color);
			updateTexture(bitmapData, bitmapData);
		}
		
		
		public static function match(target:Object, source:Object):void {
			target.x = source.x;
			target.y = source.y;
			target.alpha = source.alpha;
		}
	}
}