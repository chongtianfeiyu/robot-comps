package org.robotcomps.core.display
{
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import org.osflash.signals.Signal;
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
		public var renderTexture:RenderTexture;
		
		public function StarlingImage(texture:RenderTexture) {
			super(texture);
			renderTexture = texture;
			
			mouseSignals = new MouseSignals();
			addEventListener(TouchEvent.TOUCH, onTouch);
			
		}
			
		public function get mouseDown():Signal { return mouseSignals.mouseDown; }
		public function get mouseUp():Signal { return mouseSignals.mouseUp; }
		public function get mouseClicked():Signal { return mouseSignals.mouseClicked; }
		
		protected function onTouch(event:TouchEvent):void {
			var touch:Touch = event.getTouch(this);
			if (touch) {
				switch (touch.phase) {
					
					case TouchPhase.BEGAN:                                   
						mouseDown.dispatch(this);
						break;
					
					case TouchPhase.ENDED:                                   
						mouseSignals.mouseUp.dispatch();
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