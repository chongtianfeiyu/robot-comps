package org.robotcomps
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	
	import flashx.textLayout.formats.TextAlign;
	
	import org.robotcomps.core.display.IImage;
	
	import swc.Text;
	import swc.TextBold;

	public class TextFields
	{
		public static var cacheCount:int = 0;
		
		public static var showOutlines:Boolean = false;
		public static var cachePadding:int = 2;
		
		protected static var textCache:Dictionary = new Dictionary(true);
		protected static var currentAccent:uint;

		public static function getRegular(text:String = "", size:int = -1, color:int = 0x0, align:String = "left"):TextField {
			var instance:TextField = new swc.Text().instance;
			return formatText(text, instance, size, color, align);
		}
		
		public static function getBold(text:String = "", size:int = -1, color:int = 0x0, align:String = "left"):TextField {
			var instance:TextField = new swc.TextBold().instance;
			return formatText(text, instance, size, color, align, true);
		}
		
		public static function formatText(text:String, instance:TextField, size:int = -1, color:int = 0x0, align:String = null, bold:Boolean = false):TextField {
			var tf:TextFormat = instance.defaultTextFormat;
			tf.align = align || TextFormatAlign.LEFT;
			tf.color = color;
			tf.size = (size == -1)? RobotComps.fontSize : size;
			tf.bold = bold;
			
			instance.selectable = false;
			instance.mouseEnabled = false;
			instance.cacheAsBitmap = true;
			instance.multiline = false;
			instance.wordWrap = false;
			instance.autoSize = TextFieldAutoSize.LEFT;
			instance.height = size + 6;
			instance.width = 10;
			instance.setTextFormat(tf);
			instance.defaultTextFormat = tf;
			instance.text = text;
			return instance;
		}
		
		public static function cache(textfield:TextField, trim:Boolean = true):BitmapData {
			
			var width:int = !trim? textfield.width : textfield.textWidth + cachePadding * 2;
			if(width < 2){ width = 2; } //GPU can't handle textures 1px texture
			
			var height:int = textfield.height;
			
			var bitmapData:BitmapData = new BitmapData(width, height, !showOutlines, 0x0);
			if(showOutlines){
				bitmapData.fillRect(bitmapData.rect, 0xFF0000);
				textfield.opaqueBackground = 0x220000FF;
			}
			var m:Matrix;
			if(textfield.defaultTextFormat.align == TextAlign.CENTER){
				m = new Matrix();
				m.tx = cachePadding - (textfield.width - width >> 1);
			} else if(textfield.defaultTextFormat.align == TextAlign.RIGHT){
				m = new Matrix();
				m.tx = cachePadding - (textfield.width - width);
			}
			
			bitmapData.draw(textfield, m);
			if(++cacheCount % 10 == 0){
				trace("cacheCount: ", cacheCount);
			}
			return bitmapData;
		}
		
		/**
		 * Registers a textfield and returns a cached IImage object. If no image is passed in, a new one is created on the fly.
		 * Once a textfield it will also automatically update the TEXT and ACCENT colors whenever the theme is changed.
		 * Registration also enable use of Textfields.update().
		 **/
		public static function register(text:TextField, image:IImage = null):IImage {
			if(!image){ image = Display.getImage(); }
			textCache[text] = image;
			return image;
		}
		
		public static function unregister(messageText:TextField):void {
			delete textCache[messageText];
		}
		
		/**
		 * Updates the IImage cache for a given Textfield. The Textfield must be registered for this to work.
		 **/
		public static function update(text:TextField, trim:Boolean = true):IImage {
			if(!textCache[text]){ return null; } //Exit if we can't find the matching image, must not be registered.
			return updateImage(textCache[text], text, trim);
		}
		
		/**
		 *  Caches a textfield and returns image object 
		 * */
		public static function updateImage(image:IImage, text:TextField, trim:Boolean = true):IImage {
			var bitmapData:BitmapData = TextFields.cache(text, trim);
			
			image.x = text.x;
			image.y = text.y;
			image.alpha = text.alpha;

			Display.updateImage(image, bitmapData);
			return image;
		}
		
		public static function setColor(normal:uint, accent:uint):void {
			for (var i:Object in textCache) {
				var text:TextField = i as TextField;
				var image:IImage = textCache[i];
				var tf:TextFormat = text.defaultTextFormat;
				if(tf.color == currentAccent){
					tf.color = accent;
				} else {
					tf.color = normal;
				}
				text.setTextFormat(tf);
				text.defaultTextFormat = tf;
				updateImage(image, text, image.width == text.textWidth);
			}
			currentAccent = accent;
		}
		
		
	}
}