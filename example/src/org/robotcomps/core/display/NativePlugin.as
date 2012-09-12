package org.robotcomps.core.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import org.robotcomps.Display;
	import org.robotcomps.RobotComps;
	
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	
	public class NativePlugin implements IPlugin
	{
		public function NativePlugin() {
		}
		
		public function getContainer():IContainer {
			return new NativeContainer();
		}
		
		public function createTexture(bitmapData:BitmapData):Object {
			return bitmapData;
		}
		
		public function releaseTexture(bitmapData:BitmapData):void {
			
		}
		
		public function getImage(bitmapData:BitmapData):IImage {
			return new NativeImage(bitmapData, "auto", true);
		}
		
		public function setTexture(image:IImage, bitmapData:BitmapData):void {
			(image as NativeImage).bitmapData = bitmapData;
		}
		
		public function updateTexture(target:BitmapData, source:BitmapData):void {
			var s:Sprite = new Sprite();
			s.graphics.beginBitmapFill(source);
			s.graphics.drawRect(0, 0, target.width, target.height);
			source = Display.cache(s);
			
			target.fillRect(target.rect, 0x0);
			target.draw(source);
		}
		
		public function swapTextures(target:IImage, source:IImage):void {
			(target as NativeImage).bitmapData = (source as NativeImage).bitmapData;
		}
	}
}