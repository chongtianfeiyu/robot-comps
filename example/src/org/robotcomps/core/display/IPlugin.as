package org.robotcomps.core.display
{
	import flash.display.BitmapData;

	public interface IPlugin
	{
		
		function getContainer():IContainer;
		
		function getImage(bitmapData:BitmapData):IImage;
		
		function createTexture(bitmapData:BitmapData):Object;
		
		function releaseTexture(bitmapData:BitmapData):void;
		
		function setTexture(image:IImage, bitmapData:BitmapData):void;
		
		function updateTexture(target:BitmapData, source:BitmapData):void;
		
		function swapTextures(target:IImage, source:IImage):void; 
		
	}
}