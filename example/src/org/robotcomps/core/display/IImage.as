package org.robotcomps.core.display
{
	import flash.display.BitmapData;
	
	import org.osflash.signals.Signal;

	public interface IImage
	{
		//Base Properties
		function get x():Number;
		function set x(value:Number):void;
		
		function get y():Number;
		function set y(value:Number):void;
		
		function get width():Number;
		function set width(value:Number):void;
		
		function get height():Number;
		function set height(value:Number):void;
		
		function get mouseX():Number;
		function get mouseY():Number;
		
		function get scaleX():Number;
		function set scaleX(value:Number):void;
		
		function get scaleY():Number;
		function set scaleY(value:Number):void;
		
		function get alpha():Number
		function set alpha(value:Number):void
			
		function set visible(value:Boolean):void;
		
		//Textures
		function get bitmapData():BitmapData;
		
		function get mouseDown():Signal
		function get mouseClicked():Signal
		function get mouseUp():Signal
		function get mouseDragged():Signal
	}
}