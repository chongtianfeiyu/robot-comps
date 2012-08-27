package org.robotcomps.core.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	import org.robotcomps.RobotComps;
	import org.robotcomps.core.utils.MouseSignals;
	
	public class NativeImage extends Sprite implements IImage
	{
		protected var mouseSignals:MouseSignals;
		
		protected var bitmap:Bitmap;
		
		public function NativeImage(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=true){
			mouseChildren = false;
			bitmap = new Bitmap(bitmapData, pixelSnapping, smoothing);
			bitmap.smoothing = smoothing;
			addChild(bitmap);
			
			mouseSignals = new MouseSignals();
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		public function get bitmapData():BitmapData { return bitmap.bitmapData; }
		public function set bitmapData(value:BitmapData):void {
			var smoothing:Boolean = bitmap.smoothing;
			bitmap.bitmapData = value;
			addChild(bitmap);
 			bitmap.smoothing = smoothing;
		}
		
		/**
		 * MOUSE HANDLERS
		 **/
		public function get mouseDown():Signal { return mouseSignals.mouseDown; }
		protected function onMouseDown(event:MouseEvent):void {
			RobotComps.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
			mouseSignals.mouseDown.dispatch();
		}
		
		public function get mouseUp():Signal { return mouseSignals.mouseUp; }
		protected function onMouseUp(event:MouseEvent):void {
			RobotComps.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			mouseSignals.mouseUp.dispatch();
		}
		
		public function get mouseClicked():Signal { return mouseSignals.mouseClicked; }
		protected function onClick(event:MouseEvent):void {
			mouseSignals.mouseClicked.dispatch();
		}
		
		
	}
}