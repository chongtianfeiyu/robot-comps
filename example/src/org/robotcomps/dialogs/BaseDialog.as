package org.robotcomps.dialogs
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	import org.robotcomps.Display;
	import org.robotcomps.RobotComps;
	import org.robotcomps.controls.SimpleButton;
	import org.robotcomps.core.display.IContainer;
	import org.robotcomps.core.display.IImage;
	import org.robotcomps.core.view.SizableView;
	
	public class BaseDialog extends SizableView
	{
		
		protected var padding:int = 10;
		public var fontSize:int; 
		public var bg:SizableView;
		public var buttonHeight:int = RobotComps.hitSize * 1.5;
		
		protected var bgPadding:Number;
		
		protected var buttonList:Array;
		protected var buttonContainer:IContainer;
		
		public var buttonClicked:Signal;
		
		public function BaseDialog(width:int = 400, height:int = 250, fontSize:int = -1){
			if(fontSize == -1){ fontSize = RobotComps.fontSize; }
			this.fontSize = fontSize;
			
			buttonClicked = new Signal(String);
			
			_viewWidth = width;
			_viewHeight = height;
			bgPadding = 1;
			createChildren();
		}
		
		override public function get height():Number {
			return (bg)? bg.height : super.height;
		}
		
		protected function createChildren():void {
			bg =  new DialogBackground();
			display._addChildAt(bg.display, 0);
			
			mouseClicked = new Signal();
			updateLayout();
		}
		
		
		public function setButtons(value:Array):void {
			if(!buttonContainer){
				buttonContainer = Display.getContainer();
				display._addChild(buttonContainer);
			}
			buttonContainer._removeChildren();
			
			buttonList = [];
			var button:SimpleButton;
			for(var i:int = 0, l:int = value.length; i < l; i++){
				button = new SimpleButton("", null, Display.DIVIDER);
				button.label = value[i];
				button.mouseClicked.add(onButtonClicked);
				buttonContainer._addChild(button.display);
				buttonList[i] = button;
			}
			updateButtons();
		}
		
		override public function updateLayout():void {
			bg.width = viewWidth;
			bg.height = viewHeight;
			
			updateButtons();
		}
		
		protected function updateButtons():void {
			if(!buttonContainer){ return; }
			
			//Buttons should stretch to fill hz space - borderPadding 
			var buttonWidth:int = (viewWidth - bgPadding * 2)/(buttonContainer._numChildren());
			for (var i:int = 0, l:int = buttonList.length; i < l; i++){
				
				var button:SimpleButton = buttonList[i];
				if(i < l - 1){ button.borders.show(false, true, true, false); }
				else { button.borders.show(false, false, true, false); }
				button.align = "center";
				button.setSize(buttonWidth, buttonHeight);
				button.mouseClicked.add(onButtonClicked);
				button.x = buttonWidth * i;
			}
			buttonContainer.x = bgPadding;
			buttonContainer.y = bg.height - buttonHeight - 1;
			
		}
		
		protected function onButtonClicked(label:String):void {
			buttonClicked.dispatch(label);
		}
	
	}
}