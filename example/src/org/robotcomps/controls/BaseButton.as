package org.robotcomps.controls
{
	
	import com.gskinner.motion.GTween;
	
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	import flash.events.MouseEvent;
	
	import org.robotcomps.core.Display;
	import org.robotcomps.core.display.IContainer;
	import org.robotcomps.core.display.IImage;
	import org.robotcomps.style.Animations;
	import org.robotcomps.view.SizableView;

	public class BaseButton extends SizableView
	{
		protected var _isSelected:Boolean = false;
		protected var tween:GTween;
		
		public var bgColor:Number = 0x090909;
		
		public var container:IContainer;
		
		public var bg:IImage;
		public var bgDown:IImage;
		public var borderBox:BorderBox;
		private var _borderSize:int;
		
		public function BaseButton(borderSize:int = 0) {
			this.borderSize = borderSize;
			createChildren();
		}
		
		public function get borderSize():int{ return _borderSize; }
		public function set borderSize(value:int):void {
			_borderSize = value;
			if(borderBox){
				borderBox.borderSize = _borderSize;
				borderBox.visible = (_borderSize > 0);
			}
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
			
			borderBox = new BorderBox();
			borderSize = borderSize;
			display._addChild(borderBox.display);
			
			tween = new GTween(bgDown, Animations.SHORT, {}, {ease: Animations.EASE_OUT});
			
			display.mouseDown.add(onMouseDown);
			
		}
		
		public function get isSelected():Boolean {
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void {
			_isSelected = value;
			tween.paused = true;
			tween.proxy.alpha = (value)? 1 : 0;
		}
		
		protected function onMouseUp(event:MouseEvent):void {
			if(isSelected){ return; }
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			tween.proxy.alpha = 0;
		}
		
		protected function onMouseDown():void {
			if(isSelected){ return; }
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
			tween.proxy.alpha = 1;
		}
		
		override public function updateLayout():void {
			bg.width = bgDown.width = viewWidth;
			bg.height = bgDown.height = viewHeight;
			
			borderBox.setSize(viewWidth, viewHeight);
		}
	}
}