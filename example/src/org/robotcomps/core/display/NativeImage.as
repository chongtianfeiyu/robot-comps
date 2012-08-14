package org.robotcomps.core.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class NativeImage extends Sprite implements IImage
	{
		protected var _mouseDown:Signal;
		protected var bitmap:Bitmap;
		
		public function NativeImage(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=true){
			mouseChildren = false;
			bitmap = new Bitmap(bitmapData, pixelSnapping, smoothing);
			addChild(bitmap);
			
			_mouseDown = new Signal();
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
		}
		
		public function get mouseDown():Signal { return _mouseDown; }
		protected function onMouseDown(event:MouseEvent):void {
			_mouseDown.dispatch();
		}
		
		public function get bitmapData():BitmapData { return bitmap.bitmapData; }
		public function set bitmapData(value:BitmapData):void {
			bitmap.bitmapData = value;
		}
	}
}