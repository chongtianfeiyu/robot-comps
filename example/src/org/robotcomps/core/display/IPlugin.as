package org.robotcomps.core.display
{
	import flash.display.BitmapData;

	public interface IPlugin
	{
		function getContainer():IContainer;
		
		function getImage(texture:Object):IImage;
		
		function createTexture(bitmapData:BitmapData):Object;
		
		function updateImage(image:IImage, bitmapData:BitmapData):void;
		
		function updateTexture(texture:Object, bitmapData:BitmapData):void;
		
	}
}