package org.robotcomps.core.display
{
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
		
		function get alpha():Number
		function set alpha(value:Number):void
			
		function set visible(value:Boolean):void;
		
		function get mouseDown():Signal
	}
}