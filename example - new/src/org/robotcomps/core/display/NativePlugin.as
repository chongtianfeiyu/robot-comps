package org.robotcomps.core.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
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
		
		public function getImage(texture:Object):IImage {
			return new NativeImage(texture as BitmapData, "auto", true);
		}
		
		public function updateImage(image:IImage, bitmapData:BitmapData):void {
			(image as NativeImage).bitmapData = bitmapData;
			
			
			
		}
		
		public function updateTexture(texture:Object, bitmapData:BitmapData):void {
			var bitmapData2:BitmapData = texture as BitmapData;
			bitmapData2.draw(bitmapData);
		}
	}
}