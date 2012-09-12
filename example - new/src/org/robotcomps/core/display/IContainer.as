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
		function get mouseClicked():Signal
		function get mouseUp():Signal

		//Manage children:
		function _addChild(child:*):void
		function _removeChild(child:*):void
			
		function _numChildren():int
		function _removeChildren():void
			
		function _getChildAt(index:int):Object
		
		function _addChildAt(child:*, index:int):void
		function _removeChildAt(index:int):void
		
		function _getChildIndex(child:*):int
		function _setChildIndex(child:*, index:int):void
			
		function _contains(child:*):Boolean
			
		function set mouseEnabled(value:Boolean):void
		
	}
}