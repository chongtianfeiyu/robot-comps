package org.robotcomps
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	
	import org.robotcomps.core.display.IImage;
	
	import swc.textField;
	import swc.textFieldBold;

	public class TextFields
	{
		protected static var textCache:Dictionary = new Dictionary(true);
		protected static var currentAccent:uint;
		
		public static function getRegular(size:int = 18, color:int = 0x0, align:String = null):TextField {
			var instance:TextField = new swc.textField().instance;
			return formatText(instance, size, color, align);
		}
		
		public static function getBold(size:int = 18, color:int = 0x0, align:String = ""):TextField {
			var instance:TextField = new swc.textFieldBold().instance;
			return formatText(instance, size, color, align, true);
		}
		
		public static function formatText(instance:TextField, size:int = 18, color:int = 0x0, align:String = null, bold:Boolean = false):TextField {
			var tf:TextFormat = instance.defaultTextFormat;
			tf.align = align || TextFormatAlign.LEFT;
			tf.color = color;
			tf.size = size;
			tf.bold = bold;
			
			instance.selectable = false;
			instance.mouseEnabled = false;
			instance.cacheAsBitmap = true;
			instance.height = size + 6;
			instance.width = 50;
			instance.setTextFormat(tf);
			instance.defaultTextFormat = tf;
			instance.text = "";
			return instance;
		}
		
		public static function cache(textfield:TextField, useTextWidth:Boolean = false):BitmapData {
			var width:int = useTextWidth? textfield.textWidth : textfield.width;
			var height:int = useTextWidth? textfield.textHeight: textfield.height;
			
			var bitmapData:BitmapData = new BitmapData(width, height, true, 0x0);
			bitmapData.draw(textfield);
			
			return bitmapData;
		}
		
		public static function updateImage(image:IImage, text:TextField):void {
			var bitmapData:BitmapData = TextFields.cache(text);
			image.x = text.x;
			image.y = text.y;
			image.alpha = text.alpha;
			Display.updateImage(image, bitmapData);
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
				updateImage(image, text);
			}
			currentAccent = accent;
		}
		
		public static function register(text:TextField, image:IImage):void {
			textCache[text] = image;
		}
		
		public static function unregister(messageText:TextField):void {
			delete textCache[messageText];
		}
	}
}