package org.robotcomps.core.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	import org.robotcomps.RobotComps;
	import org.robotcomps.core.utils.MouseSignals;
	
	public class NativeContainer extends Sprite implements IContainer {
		
		protected var mouseSignals:MouseSignals;
		
		public function NativeContainer() {
			init();
		}
		
		protected function init():void {
			mouseSignals = new MouseSignals();
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		/**
		 * MOUSE HANDLERS
		 **/
		public function get mouseDown():Signal { return mouseSignals.mouseDown; }
		protected function onMouseDown(event:MouseEvent):void {
			RobotComps.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
			mouseSignals.mouseDown.dispatch(this);
		}
		
		public function get mouseUp():Signal { return mouseSignals.mouseUp; }
		protected function onMouseUp(event:MouseEvent):void {
			RobotComps.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			mouseSignals.mouseUp.dispatch(this);
		}
		
		public function get mouseClicked():Signal { return mouseSignals.mouseClicked; }
		protected function onClick(event:MouseEvent):void {
			mouseSignals.mouseClicked.dispatch(this);
		}
		
		
		/**
		 * MANAGE CHILDREN
		 **/
		public function _addChild(child:*):void {
			addChild(child as DisplayObject);
		}
		
		public function _addChildAt(child:*, index:int):void {
			addChildAt(child as DisplayObject, index);
		}
		
		public function _removeChild(child:*):void {
			removeChild(child as DisplayObject);
		}
		
		public function _getChildAt(index:int):Object {
			return getChildAt(index);	
		}
		
		public function _removeChildAt(index:int):void {
			removeChildAt(index);
		}
		
		public function _removeChildren():void {
			removeChildren();
		}
		
		public function _getChildIndex(child:*):int {
			return getChildIndex(child as DisplayObject);
		}
		
		public function _numChildren():int {
			return numChildren;
		}
		
		public function _setChildIndex(child:*, index:int):void {
			setChildIndex(child as DisplayObject, index);
		}
		
		public function _contains(child:*):Boolean {
			return contains(child as DisplayObject);
		}
	}
}