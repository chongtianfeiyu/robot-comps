package org.robotcomps.controls
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.osflash.signals.Signal;
	import org.robotcomps.Display;
	import org.robotcomps.RobotComps;
	import org.robotcomps.TextFields;
	import org.robotcomps.core.display.IImage;
	import org.robotcomps.core.view.SizableView;
	import org.robotcomps.style.data.ColorTheme;
	
	import swc.*;
	
	public class Slider extends SizableView
	{
		protected static var initComplete:Boolean;
		protected static var viewAssets:swc.Slider;
		
		//Cache Names
		protected static var TRACK:String = "Robot-Slider-Track";
		protected static var FILL:String = "Robot-Slider-Fill";
		protected static var HEAD_DOWN:String = "Robot-Slider-HeadDown";
		protected static var HEAD_UP:String = "Robot-Slider-HeadUp";
		
		protected var _label:String;
		protected var _position:Number;
		
		//Display Objects
		protected var bg:IImage;
		protected var track:IImage;
		protected var fill:IImage;
		protected var headDown:IImage;
		protected var headUp:IImage;
		protected var labelText:TextField;
		protected var labelImage:IImage;
		
		//Public
		public static var radius:Number = 20;
		public var max:Number = 1;
		public var min:Number = 0;
		public var changed:Signal;
		private static var trackCache:BitmapData;
		
		public function Slider(position:Number = .5, label:String = ""){
			//One time setup for this component class
			if(!initComplete){
				initControl();
				initComplete = true;
			}
			
			_label = label;
			changed = new Signal(Number);
			
			createChildren();
			
			this.position = position;
		}
		
		protected function createChildren():void {
			
			//Create all our display children from our swc Assets
			bg = Display.getImage();
			display._addChild(bg);
			
			track = Display.getImageByType(TRACK);
			display._addChild(track);
			
			fill = Display.getImageByType(FILL);
			display._addChild(fill);
			
			headUp = Display.getImageByType(HEAD_UP);
			headUp.scaleX = headUp.scaleY = .5;
			display._addChild(headUp);
			
			headDown = Display.getImageByType(HEAD_DOWN);
			headDown.scaleX = headDown.scaleY = .5;
			headDown.visible = false;
			display._addChild(headDown);
			
			//Create a Textfield and it's ImageCache
			labelText = TextFields.getRegular(_label, RobotComps.fontSize * .85, RobotComps.theme.text);
			labelImage = Display.getImage();
			//Register the Textfield : Image so we can update it's color onThemeChange
			TextFields.register(labelText, labelImage);
			//Draw label
			if(_label){ updateLabelText(); }
			
			display.mouseDown.add(onMouseDown);
			display.mouseDragged.add(onMouseMoved);
		}
		
		/**
		 * Create statically cached textures from our swc assets.
		 **/
		protected static function initControl():void {
			viewAssets = new swc.Slider();
			
			trackCache = Display.cache(viewAssets.track);
			Display.setTextureByType(TRACK, trackCache);
			Display.setTextureByType(FILL,  Display.cache(viewAssets.fill));
			Display.setTextureByType(HEAD_DOWN,  Display.cache(viewAssets.headDown, 2));
			Display.setTextureByType(HEAD_UP,  Display.cache(viewAssets.headUp, 2));
			
			RobotComps.themeChanged.add(onThemeChanged);
			onThemeChanged(RobotComps.theme);
		}
		
		/** 
		 * Custom themeChanged handler. 
		 * Tint each skin part to match the current theme values.
		 * **/
		public static function onThemeChanged(theme:ColorTheme):void {
			Display.tintByType(TRACK, RobotComps.theme.divider);
			Display.tintByType(FILL, RobotComps.theme.accent);
			Display.tintByType(HEAD_UP, RobotComps.theme.accent);
		}
		
		/**
		 * Position, 0 - 1
		 **/
		public function get position():Number { return _position; }
		public function set position(value:Number):void	{
			_position = Math.max(0, Math.min(value, 1));
			updateTrackHead();
		}
		
		override public function updateLayout():void {
			
			bg.width = viewWidth;
			bg.height = viewHeight; 
			
			fill.height = 4;
			fill.width = viewWidth * position;
			fill.y = bg.height/2 - fill.height/2 |0;
			
			track.width = bg.width = viewWidth;
			track.y = bg.height/2 - track.height/2 |0;
			updateTrackHead();
				
			labelText.y = fill.y - labelText.textHeight * 1.2;
			labelText.width = viewWidth - labelText.x * 2;
			labelText.height = int(labelText.defaultTextFormat.size);
			trace("labelImage, labelText:",labelImage.width, labelText.width);
			Display.match(labelImage, labelText);
		}
		
		private function updateTrackHead():void {
			fill.width = viewWidth * position;
			
			headUp.x = fill.width - headUp.width/2;
			headUp.y = track.y - headUp.height/2;
			
			headDown.x = headUp.x + (headUp.width - headDown.width >> 1);
			headDown.y = headUp.y + (headUp.height - headDown.height >> 1);
		}
		
		public function set fontSize(value:Number):void {
			var tf:TextFormat = labelText.defaultTextFormat;
			if(value == tf.size){ return; }
			
			tf.size = value;
			labelText.setTextFormat(tf);
			labelText.defaultTextFormat = tf;
			
			updateLabelText();
			updateLayout();
		}
		
		public function set label(value:String):void {
			if(value == _label){ return; }
			labelText.text = value;
			_label = value;
			updateLabelText();
			updateLayout();
		}
		
		protected function updateLabelText():void {
			if(display != ""){
				if(!display._contains(labelImage)){
					display._addChild(labelImage);
				}
				TextFields.update(labelText);
			} 
			else if(display._contains(labelImage)) {
				display._removeChild(labelImage);
			}
		}
		
		protected function onMouseDown(target:Object):void {
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
			//updateBar();
		}
		
		protected function onMouseMoved(target:*):void {
			onMouseDrag();
		}
		
		protected function onMouseDrag():void {
			var position:Number = display.mouseX / track.width;
			this.position = position;
			changed.dispatch(_position);
		}
	}
}