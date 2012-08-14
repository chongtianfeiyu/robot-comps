package org.robotcomps.view
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import org.osflash.signals.Signal;
	import org.robotcomps.RobotComps;
	import org.robotcomps.containers.layouts.ILayout;
	import org.robotcomps.core.Display;
	import org.robotcomps.core.display.IContainer;
	
	public class SizableView
	{
		protected var _viewWidth:int;
		protected var _viewHeight:int;
		protected var layout:ILayout;
		
		public var stage:Stage;
		public var display:IContainer;
		
		public function SizableView() {
			stage = RobotComps.stage;
			if(!stage){ throw(new Error("Call RobotComps.init() before trying to create a RobotComps component.")); }
			display = Display.getContainer();
			
		}
		
		public function set visible(value:Boolean):void {
			(display as Object).visible = value;
		}
		
		public function set mouseChildren(value:Boolean):void {
			(display as Object).mouseChildren = value;
		}
		
		public function get isPortrait():Boolean {
			return viewWidth < viewHeight;
		}
		
		public function get viewHeight():int {
			return _viewHeight;
		}
		
		public function get viewWidth():int {
			return _viewWidth;
		}
		
		public function get x():Number { return display.x; }
		public function set x(value:Number):void {
			display.x = value;
		}
		
		public function get y():Number { return display.y; }
		public function set y(value:Number):void {
			display.y = value;
		}
		
		
		public function get height():Number { return display.height; }
		public function set width(value:Number):void {
			setSize(value, height);
		}
		
		
		public function get width():Number { return display.width; }
		public function set height(value:Number):void {
			setSize(width, value);
		}
		
		public function setSize(width:int, height:int):void {
			if(isNaN(width) || isNaN(height)){ return; }
			_viewWidth = width;
			_viewHeight = height;
			updateLayout();
		}
		
		public function updateLayout():void {
			if(layout){
				layout.update(this.display as IContainer);
			}
		}
		
		public function destroy():void {
			//OVerride in subclass	
		}
	}
}