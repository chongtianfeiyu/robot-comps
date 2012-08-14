package org.robotcomps.core.display
{
	import org.osflash.signals.Signal;

	public interface IContainer
	{
		//Base Properties
		function get x():Number
		function set x(value:Number):void
		
		function get y():Number
		function set y(value:Number):void

		function get width():Number
		function set width(value:Number):void
		
		function get height():Number
		function set height(value:Number):void
			
		function get alpha():Number
		function set alpha(value:Number):void
		
		function set visible(value:Boolean):void;
		
		function get mouseDown():Signal
			
		//Manage children:
		function _addChild(image:*):void
		function _removeChild(image:*):void
		
		function _addChildAt(image:*, index:int):void
		function _removeChildAt(index:int):void
		
		function _setChildIndex(image:*, index:int):void
			
		function set mouseEnabled(value:Boolean):void
		
	}
}