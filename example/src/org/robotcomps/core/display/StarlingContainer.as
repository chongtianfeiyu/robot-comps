package org.robotcomps.core.display
{
	import flash.display.Stage;
	import flash.geom.Point;
	
	import org.osflash.signals.Signal;
	import org.robotcomps.RobotComps;
	import org.robotcomps.core.utils.MouseSignals;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class StarlingContainer extends Sprite implements IContainer
	{
		protected var mouseSignals:MouseSignals;
		protected var _mouseX:Number;
		protected var _mouseY:Number;
		
		public function StarlingContainer() {
			mouseSignals = new MouseSignals();
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		
		/**
		 * MOUSE HANDLERS
		 **/
		public function get mouseDown():Signal { return mouseSignals.mouseDown; }
		public function get mouseUp():Signal { return mouseSignals.mouseUp; }
		public function get mouseClicked():Signal { return mouseSignals.mouseClicked; }
		public function get mouseDragged():Signal { return mouseSignals.mouseDragged; }
		
		public function get mouseY():Number{ return _mouseY; }
		public function get mouseX():Number { return _mouseX; }
		
		protected function onTouch(event:TouchEvent):void {
			var touch:Touch = event.getTouch(this);
			if (touch) {
				switch (touch.phase) {
					
					case TouchPhase.BEGAN:                                   
						mouseSignals.mouseDown.dispatch(this);
						break;
					     
					case TouchPhase.MOVED:
						var location:Point = touch.getLocation(this);
						_mouseX = location.x;
						_mouseY = location.y;
						mouseSignals.mouseDragged.dispatch(this);
						break;
					
					case TouchPhase.ENDED:               
						mouseSignals.mouseUp.dispatch(this);
						var stage:Stage = RobotComps.stage;
						if(hitTest(globalToLocal(new Point(stage.mouseX, stage.mouseY)), true)){
							mouseClicked.dispatch(this);
						}
						break;
				}
			}
		}
		
		public function get mouseEnabled():Boolean { return touchable; }
		public function set mouseEnabled(value:Boolean):void {
			touchable = value;
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
		
		public function _removeChildAt(index:int):void {
			removeChildAt(index);
		}
		
		public function _removeChildren():void {
			removeChildren();;
		}
		
		public function _getChildAt(index:int):Object {
			return getChildAt(index);	
		}
		
		public function _numChildren():int {
			return numChildren;
		}
		
		public function _getChildIndex(child:*):int {
			return getChildIndex(child as DisplayObject);
		}
		
		public function _setChildIndex(child:*, index:int):void {
			setChildIndex(child as DisplayObject, index);
		}
		
		public function _contains(child:*):Boolean {
			return contains(child as DisplayObject);
		}
		
		
	}
}