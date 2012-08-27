package org.robotcomps.dialogs
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.robotcomps.RobotComps;
	import org.robotcomps.Display;
	import org.robotcomps.TextFields;
	import org.robotcomps.core.display.IImage;
	import org.robotcomps.dialogs.BaseDialog;
	
	public class TitleDialog extends BaseDialog
	{
		protected var titleText:TextField;
		protected var titleCache:IImage;
		
		protected var messageText:TextField;
		protected var messageCache:IImage;
		
		protected var topDivider:IImage;
		
		protected var _title:String;
		protected var _message:String;
		
		protected var paddingTop:int = 20;
		
		public function TitleDialog(width:int = 400, height:int = 250, title:String = "", message:String = "", fontSize:int = -1){
			super(width, height, fontSize); //Super will call createChildren()
			
			this.title = title;
			this.message = message;
			
		}
		
		override protected function createChildren():void {
			topDivider = Display.getImageByType(Display.ACCENT);
			display._addChild(topDivider);
			
			titleText = TextFields.getRegular(fontSize, RobotComps.theme.accent, "left");
			titleCache = Display.getImage();
			display._addChild(titleCache);
			TextFields.register(titleText, titleCache);
			
			messageText = TextFields.getRegular(fontSize * .8, RobotComps.theme.text, "left");
			messageText.multiline = true;
			messageText.autoSize = TextFieldAutoSize.LEFT;
			messageCache = Display.getImage();
			display._addChild(messageCache);
			TextFields.register(messageText, messageCache);
			
			super.createChildren();
		}
		
		override public function updateLayout():void {
			super.updateLayout();
			
			titleText.x = titleText.y = paddingTop;
			titleText.width = viewWidth - titleText.x * 2;
			
			topDivider.width = viewWidth - 2;
			topDivider.x = 1;
			topDivider.y = titleText.y + titleText.height + paddingTop;
			
			messageText.x = titleText.x;
			messageText.y = topDivider.y + paddingTop;
			messageText.width = titleText.width;
			
		}
		
		public function shrinkToText():void {
			if(messageText.y + messageText.textHeight + 20 < buttonContainer.y){
				messageText.height = messageText.textHeight;
				var oldY:int = buttonContainer.y;
				buttonContainer.y = messageText.y + messageText.textHeight + 20;
				bg.height -= oldY - buttonContainer.y;
				_viewHeight = bg.height;
			}
		}
		
		
		public function set title(value:String):void {
			_title = titleText.text = value;
			TextFields.updateImage(titleCache, titleText);
		}
		
		public function set message(value:String):void {
			_message = messageText.text = value;
			TextFields.updateImage(messageCache, messageText);
		}
	}
}