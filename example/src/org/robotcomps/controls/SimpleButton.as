package org.robotcomps.controls
{
	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.robotcomps.Display;
	import org.robotcomps.RobotComps;
	import org.robotcomps.TextFields;
	import org.robotcomps.core.display.IImage;
	
	public class SimpleButton extends BaseButton
	{	
		
		protected var _label:String;
		protected var _icon:BitmapData;
		
		protected var iconImage:IImage;
		protected var labelImage:IImage;
		protected var labelText:TextField;
		
		
		public function SimpleButton(label:String = "", icon:BitmapData = null, borderType:String = "accent") {
			
			this._label = label;
			this._icon = icon;
			
			super(1, borderType);
		}
		
		override protected function createChildren():void {
			
			super.createChildren();
			
			labelText = TextFields.getRegular(_label, RobotComps.fontSize * .75, RobotComps.theme.text);
			labelText.multiline = false;
			labelText.wordWrap = false;
			
			labelImage = TextFields.register(labelText);
			updateLabelText();
			
			iconImage = Display.getImage(_icon);
			if(_icon != null){
				container._addChild(iconImage);
			}
		}
		
		protected function updateLabelText():void {
			if(_label != ""){
				if(!container._contains(labelImage)){
					container._addChild(labelImage);
				}
				TextFields.update(labelText, false);
			} 
			else if(container._contains(labelImage)) {
				container._removeChild(labelImage);
			}
		}
		
		public function get label():String { return _label || ""; }
		public function set label(value:String):void {
			_label = value;
			labelText.text = value;
			updateLabelText();
		}
		
		public function set align(value:String):void {
			var tf:TextFormat = labelText.defaultTextFormat;
			tf.align = value;
			labelText.setTextFormat(tf);
			labelText.defaultTextFormat = tf;
			labelText.opaqueBackground 0xFFFFFFF;
			
			updateLabelText();
			updateLayout();
		}
		
		public function set bold(value:Boolean):void {
			var tf:TextFormat = labelText.defaultTextFormat;
			tf.bold = value;
			labelText.setTextFormat(tf);
			labelText.defaultTextFormat = tf;
			
			updateLabelText();
			updateLayout();
		}
		
		public function set fontSize(value:Number):void {
			var tf:TextFormat = labelText.defaultTextFormat;
			tf.size = value;
			labelText.setTextFormat(tf);
			labelText.defaultTextFormat = tf;
			
			updateLabelText();
			updateLayout();
		}
		
		override public function updateLayout():void {
			super.updateLayout();
			
			labelText.y = viewHeight - labelText.textHeight >> 1;
			
			if(label != "" && _icon){
				iconImage.x = padding;
				iconImage.y = viewHeight - iconImage.height >> 1;
				
				labelText.x = iconImage.x + iconImage.width + padding;
				labelText.width = viewWidth - labelText.x - padding;
			} 
			else if (label != ""){
				labelText.width = viewWidth - padding;
				labelText.x = viewWidth - labelText.width >> 1;
			} 
			else if (_icon){
				iconImage.x = viewWidth - iconImage.width >> 1;
				iconImage.y = viewHeight - iconImage.height >> 1;
			}
			labelText.height = viewHeight - labelText.y - padding;
			Display.match(labelImage, labelText);
			
		}
	}
}