package org.robotcomps.core.display
{
	import flash.utils.setTimeout;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	
	public class StarlingImage extends Image implements IImage
	{
		protected var _mouseDown:Signal;
		protected var renderTexture:RenderTexture;
		
		public function StarlingImage(texture:RenderTexture) {
			super(texture);
			renderTexture = texture;
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
	}
}