package org.robotcomps.core.display
{
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import org.osflash.signals.Signal;
	import org.robotcomps.Display;
	import org.robotcomps.RobotComps;
	import org.robotcomps.core.utils.MouseSignals;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	
	public class StarlingImage extends Image implements IImage
	{
		protected var mouseSignals:MouseSignals;
		//public var renderTexture:RenderTexture;
		
		protected var _mouseX:Number;
		protected var _mouseY:Number;
		protected var _bitmapData:BitmapData;
		
		public function StarlingImage(texture:RenderTexture, bitmapData:BitmapData) {
			super(texture);
			this.bitmapData = bitmapData;
			
			mouseSignals = new MouseSignals();
			addEventListener(TouchEvent.TOUCH, onTouch);
			
		}
		
		public function get bitmapData():BitmapData { return _bitmapData; }
		public function set bitmapData(value:BitmapData) { _bitmapData = value; }
		
		/**
		 * Mouse Handlers 
		 **/
		public function get mouseY():Number{ return _mouseY; }
		public function get mouseX():Number { return _mouseX; }

		public function get mouseDown():Signal { return mouseSignals.mouseDown; }
		public function get mouseUp():Signal { return mouseSignals.mouseUp; }
		public function get mouseClicked():Signal { return mouseSignals.mouseClicked; }
		public function get mouseDragged():Signal { return mouseSignals.mouseDragged; }
		
		protected function onTouch(event:TouchEvent):void {
			var touch:Touch = event.getTouch(this);
			if (touch) {
				switch (touch.phase) {
					
					case TouchPhase.BEGAN:                                   
						mouseDown.dispatch(this);
						break;
					
					case TouchPhase.HOVER:                                   
						var location:Point = touch.getLocation(this);
						_mouseX = location.x;
						_mouseY = location.y;
						mouseDragged.dispatch(this);
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
	}
}