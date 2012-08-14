package org.robotcomps.core
{
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import swc.textField;
	import swc.textFieldBold;

	public class TextFields
	{
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
	}
}