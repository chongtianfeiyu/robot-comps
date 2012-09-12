package org.robotcomps
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
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

		public static var cachePadding:int = 2;
		public static var showOutlines:Boolean = false;
		
		public static function getRegular(text:String = "", size:int = -1, color:int = 0x0, align:String = "left"):TextField {
			var instance:TextField = new swc.textField().instance;
			return formatText(text, instance, size, color, align);
		}
		
		public static function getBold(text:String = "", size:int = -1, color:int = 0x0, align:String = "left"):TextField {
			var instance:TextField = new swc.textFieldBold().instance;
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
			if(width < 2){ width = 2; }
			
			var height:int = textfield.height;
			
			var bitmapData:BitmapData = new BitmapData(width, height, !showOutlines, 0x0);
			if(showOutlines){
				bitmapData.fillRect(bitmapData.rect, 0xFF0000);
			}
			var m:Matrix = new Matrix();
			
			if(textfield.defaultTextFormat.align == TextFormatAlign.CENTER){
				m.tx = cachePadding - (textfield.width - width >> 1);
			} else if(textfield.defaultTextFormat.align == TextFormatAlign.RIGHT){
				m.tx = cachePadding - (textfield.width - width);
			}
			bitmapData.draw(textfield, m);
			
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