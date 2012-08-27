package org.robotcomps.controls
{
	
	import com.gskinner.motion.GTween;
	
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	import org.robotcomps.Display;
	import org.robotcomps.core.display.IContainer;
	import org.robotcomps.core.display.IImage;
	import org.robotcomps.core.view.SizableView;
	import org.robotcomps.style.Animations;

	public class BaseButton extends SizableView
	{
		protected var _isSelected:Boolean = false;
		protected var tween:GTween;
		protected var borderType:String;
		protected var borderSize:int;
		
		public var bgColor:Number = 0x090909;
		public var padding:int = 10;
		
		public var container:IContainer;
		public var bg:IImage;
		public var bgDown:IImage;
		public var borders:BorderBox;
		
		
		public function BaseButton(borderSize:int = 0, borderType:String = "accent") {
			this.borderSize = borderSize;
			this.borderType = borderType;
			createChildren();
		}

		override public function get width():Number {
			if(bg){
				return bg.width;
			} else {
				return super.width;
			}
		}
		
		override public function get height():Number {
			if(bg){
				return bg.height;
			} else {
				return super.height;
			}
		}
		
		protected function createChildren():void {
			
			container = Display.getContainer();
			display._addChild(container);
			
			bg = Display.getImageByType(Display.BG_DARK);
			container._addChild(bg);
				
			bgDown = Display.getImageByType(Display.ACCENT);
			bgDown.alpha = 0;
			container._addChild(bgDown);
			
			borders = new BorderBox(1, borderType);
			display._addChild(borders.display);
			
			tween = new GTween(bgDown, Animations.SHORT, {}, {ease: Animations.EASE_OUT});
			
			//Mouse handlers
			mouseDown = new Signal();
			mouseUp = new Signal();
			mouseClicked = new Signal();
			
			display.mouseDown.add(onMouseDown);
			display.mouseClicked.add(onMouseClicked);
		}
		
		public function get isSelected():Boolean {
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void {
			_isSelected = value;
			tween.paused = true;
			tween.proxy.alpha = (value)? 1 : 0;
		}
		
		protected function onMouseDown():void {
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
			mouseDown.dispatch(this);
			
			if(isSelected){ return; }
			tween.proxy.alpha = 1;
		}
		
		protected function onMouseUp(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			mouseUp.dispatch(this);
			
			if(isSelected){ return; }
			tween.proxy.alpha = 0;
		}
		
		protected function onMouseClicked():void {
			mouseClicked.dispatch(this);
		}
		
		override public function updateLayout():void {
			bg.width = bgDown.width = viewWidth;
			bg.height = bgDown.height = viewHeight;
			
			borders.setSize(viewWidth, viewHeight);
		}
	}
}