package org.robotcomps.core.display
{
	import org.osflash.signals.Signal;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class StarlingContainer extends Sprite implements IContainer
	{
		protected var _mouseDown:Signal;
		
		public function StarlingContainer() {
			_mouseDown = new Signal();
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function get mouseDown():Signal { return _mouseDown; }
		
		protected function onTouch(event:TouchEvent):void {
			var touch:Touch = event.getTouch(this);
			if (touch) {
				switch (touch.phase) {
					
					case TouchPhase.BEGAN:                                   
						_mouseDown.dispatch();
						break;
				}
			}
		}
		
		
		public function _addChild(child:*):void {
			addChild(child as DisplayObject);
		}
		
		public function _addChildAt(child:*, index:int):void {
			addChildAt(child as DisplayObject, index);
		}
		
		public function _removeChild(child:*):void {
			removeChild(child as DisplayObject);
		}
		
		public function _removeChildAt(index:int):void {
			removeChildAt(index);
		}
		
		public function _setChildIndex(child:*, index:int):void {
			setChildIndex(child as DisplayObject, index);
		}
		
		public function get mouseEnabled():Boolean { return touchable; }
		public function set mouseEnabled(value:Boolean):void {
			touchable = value;
		}
		
	}
}