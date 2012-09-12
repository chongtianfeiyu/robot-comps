package org.robotcomps.core.display
{
	import flash.display.BitmapData;
	
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;

	public class StarlingPlugin implements IPlugin
	{
		public function StarlingPlugin() {
		}
		
		public function getContainer():IContainer {
			return new StarlingContainer();
		}
		
		public function createTexture(bitmapData:BitmapData):Object {
			var image:Image = new Image(Texture.fromBitmapData(bitmapData));
			var starlingTexture:RenderTexture = new RenderTexture(bitmapData.width, bitmapData.height, true, 1);
			starlingTexture.draw(image);
			return starlingTexture;
		}
		
		public function getImage(texture:Object):IImage {
			return new StarlingImage(texture as RenderTexture);
		}
		
		public function updateImage(image:IImage, bitmapData:BitmapData):void {
			(image as StarlingImage).texture = Texture.fromBitmapData(bitmapData);
			(image as StarlingImage).readjustSize();
		}
		
		public function updateTexture(texture:Object, bitmapData:BitmapData):void {
			var image:Image = new Image(Texture.fromBitmapData(bitmapData));
			texture.draw(image);
		}
	}
}