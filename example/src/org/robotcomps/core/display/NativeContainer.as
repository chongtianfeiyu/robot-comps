package org.robotcomps.core.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class NativeContainer extends Sprite implements IContainer {
		
		protected var _mouseDown:Signal;
		
		public function NativeContainer() {
			_mouseDown = new Signal();
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
		}
		
		public function get mouseDown():Signal { return _mouseDown; }
		protected function onMouseDown(event:MouseEvent):void {
			_mouseDown.dispatch();
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
		
	}
}