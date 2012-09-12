package org.robotcomps.controls
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.osflash.signals.Signal;
	import org.robotcomps.Device;
	import org.robotcomps.RobotComps;
	
	import swc.*;
	
	public class Slider extends Sprite
	{
		protected static var bgCache:BitmapData;
		protected static var trackCache:BitmapData;
		protected static var fillCache:BitmapData;
		protected static var headUpCache:BitmapData;
		protected static var headDownCache:BitmapData;
		
		public static var radius:Number = 20;
		
		protected var viewAssets:swc.slider;
		protected var bg:Bitmap;
		protected var track:Bitmap;
		protected var fill:Bitmap;
		protected var headDown:Bitmap;
		protected var headUp:Bitmap;
		protected var labelText:TextField;
		
		public var max:Number = 1;
		public var min:Number = 0;
		
		public var changed:Signal;
		
		public function Slider(position:Number = .5, label:String = ""){
			
			changed = new Signal(Number);
			
			viewAssets = new swc.slider();
			//Shared cache among all assets
			if(!bgCache){
				bgCache = new BitmapData(1, 1, true, 0x0);
				trackCache = new BitmapData(1, 1, false, RobotComps.theme.divider);
				fillCache = new BitmapData(1, 1, false, RobotComps.theme.accent);
				
				//Draw Track Head
				if(!headUpCache){
					drawTrackHead(RobotComps.theme.accent);
				}
				
				//Draw Track Over Image from .FLA
				var sprite:Sprite = viewAssets.headDown;
				sprite.width = sprite.height = radius * 2;
				var m:Matrix = new Matrix();
				m.scale(sprite.scaleX, sprite.scaleY);
				headDownCache = new BitmapData(radius * 2, radius * 2, true, 0x0);
				
				if(RENDER::GPU) {
					headDownCache.drawWithQuality(sprite, m, null, null, null, true, StageQuality.HIGH);
				} else {
					headDownCache.draw(sprite, m, null, null, null, true);
				}
			}
			
			bg = new Bitmap(bgCache, PixelSnapping.AUTO, true);
			addChild(bg);
			
			track = new Bitmap(trackCache, PixelSnapping.AUTO, true);
			addChild(track);
			
			fill = new Bitmap(fillCache, PixelSnapping.AUTO, true);
			addChild(fill);
			
			headUp = new Bitmap(headUpCache, PixelSnapping.AUTO, true);
			addChild(headUp);
			
			headDown = new Bitmap(headDownCache, PixelSnapping.AUTO, true);
			headDown.visible = false;
			addChild(headDown);
			
			bg.height = radius * 3;
			
			
			labelText = viewAssets.labelText;
			labelText.text = label;
			labelText.mouseEnabled = false;
			addChild(labelText);
			
			fontSize = RobotComps.fontSize * .75;
			
			viewAssets = null;
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			this.position = position;
		}
		
		protected static function drawTrackHead(color:Number):void {
			
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(color, .5);
			sprite.graphics.drawCircle(radius, radius, radius);
			sprite.graphics.endFill();
			sprite.graphics.beginFill(color, 1);
			sprite.graphics.drawCircle(radius, radius, 10);
			sprite.graphics.endFill();
			if(!headUpCache){
				headUpCache = new BitmapData(sprite.width + 2, sprite.height + 2, true, 0x0);
			}
			headUpCache.fillRect(headUpCache.rect, 0x0);
			if(RENDER::GPU) {
				headUpCache.drawWithQuality(sprite, null, null, null, null, false, StageQuality.HIGH);
			} else {
				headUpCache.draw(sprite, null, null, null, null, false);
			}
		}
		
		public static function set colorMain(value:Number):void {
			trackCache.fillRect(trackCache.rect, value);
		}
		
		public static function set colorAccent(value:Number):void {
			drawTrackHead(value);
			
			if(!fillCache){ return; }
			fillCache.fillRect(fillCache.rect, value);
		}
		
		/**
		 * Position, 0 - 1
		 **/
		protected var _position:Number;
		public function get position():Number {
			return _position;
		}
		public function set position(value:Number):void	{
			_position = Math.max(0, Math.min(value, 1));
			fill.width = track.width * position;
			headDown.x = headUp.x = fill.width - headDown.width/2;
		}
		
		/** 
		 * Override width setter 
		 **/
		override public function set width(value:Number):void {
			bg.width = value;
			
			fill.width = value * position;
			fill.height = 4;
			fill.y = bg.height/2 - fill.height/2 |0;
			
			track.width = bg.width = value;
			track.y = bg.height/2 - track.height/2 |0;
			
			headDown.x = headUp.x = fill.width - headDown.width/2;
			headDown.y = headUp.y = track.y - headDown.height/2;
			
			labelText.y = fill.y - labelText.textHeight * 1.2;
			labelText.width = value - labelText .x * 2;
			labelText.height = Device.hitSize/2;
		}
		
		public function set fontSize(value:Number):void {
			var tf:TextFormat = labelText.defaultTextFormat;
			tf.size = value;
			labelText.setTextFormat(tf);
			labelText.defaultTextFormat = tf;
		}
		
		public function set label(value:String):void {
			labelText.text = value;
		}
		
		protected function onMouseDown(value:MouseEvent):void {
			headDown.visible = true;
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
		}
		
		protected function onMouseUp(value:MouseEvent):void {
			headDown.visible = false;
			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onEnterFrame(value:Event):void {
			updateBar();
		}
		
		protected function updateBar():void {
			fill.width = Math.max(0, Math.min(bg.width, this.mouseX));
			headDown.x = headUp.x = fill.width - headDown.width/2;
			_position = fill.width / track.width;
			changed.dispatch(_position);
		}
	}
}