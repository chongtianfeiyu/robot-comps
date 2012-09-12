package org.robotcomps.dialogs
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.robotcomps.Display;
	import org.robotcomps.RobotComps;
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
		
		protected var paddingTop:int = 0;
		
		public function TitleDialog(width:int = 400, height:int = 250, title:String = "", message:String = "", fontSize:int = -1){
			super(width, height, fontSize); //Super will call createChildren()
			
			paddingTop = RobotComps.fontSize * .85;
			
			this.title = title;
			this.message = message;
			
		}
		
		override protected function createChildren():void {
			topDivider = Display.getImageByType(Display.ACCENT);
			display._addChild(topDivider);
			
			titleText = TextFields.getRegular("", fontSize, RobotComps.theme.accent);
			titleCache = Display.getImage();
			display._addChild(titleCache);
			TextFields.register(titleText, titleCache);
			
			messageText = TextFields.getRegular("", fontSize * .8, RobotComps.theme.text);
			messageText.wordWrap = true;
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
			titleCache.x = titleText.x;
			titleCache.y = titleText.y;
			
			topDivider.width = viewWidth - 2;
			topDivider.x = 1;
			topDivider.y = titleText.y * 2 + titleText.textHeight * .8;
			
			messageText.x = titleText.x;
			messageText.y = topDivider.y + paddingTop;
			messageText.width = viewWidth - titleText.x * 2;
			messageCache.x = messageText.x;
			messageCache.y = messageText.y;
		}
		
		public function shrinkToText():void {
			if(!buttonContainer){ return; }
			var buttonY:int = buttonContainer? buttonContainer.y : viewHeight
			if(messageText.y + messageText.textHeight + 20 < buttonY){
				messageText.height = messageText.textHeight;
				buttonContainer.y = messageText.y + messageText.textHeight + 20;
				bg.height -= buttonY - buttonContainer.y;
				_viewHeight = bg.height;
			}
		}
		
		
		public function set title(value:String):void {
			_title = titleText.text = value;
			TextFields.updateImage(titleCache, titleText);
			updateLayout();
		}
		
		public function set message(value:String):void {
			_message = messageText.text = value;
			TextFields.updateImage(messageCache, messageText);
			updateLayout();
		}
	}
}