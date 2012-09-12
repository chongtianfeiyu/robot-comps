package org.robotcomps.core.display
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import org.robotcomps.Display;
	
	import starling.display.Image;
	import starling.errors.AbstractClassError;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;

	public class StarlingPlugin implements IPlugin
	{
		public var texturesByBitmap:Dictionary;
		
		public function StarlingPlugin() {
			texturesByBitmap = new Dictionary();
		}
		
		public function getContainer():IContainer {
			return new StarlingContainer();
		}
		
		public function createTexture(bitmapData:BitmapData):Object {
			var image:Image = new Image(Texture.fromBitmapData(bitmapData));
			var texture:RenderTexture = new RenderTexture(bitmapData.width, bitmapData.height, true, 1);
			texture.draw(image);
			texturesByBitmap[bitmapData] = texture;
			return texture;
		}
		
		public function releaseTexture(bitmapData:BitmapData):void {
			delete texturesByBitmap[bitmapData];
		}
		
		public function getTexture(bitmapData:BitmapData):RenderTexture {
			var texture:RenderTexture = texturesByBitmap[bitmapData];
			if(!texture){
				texture = createTexture(bitmapData) as RenderTexture;	
			}
			return texture;
		}
		
		public function getImage(bitmapData:BitmapData):IImage {
			return new StarlingImage(getTexture(bitmapData), bitmapData);
		}
		
		public function setTexture(image:IImage, bitmapData:BitmapData):void {
			(image as StarlingImage).texture = Texture.fromBitmapData(bitmapData);
			(image as StarlingImage).bitmapData = bitmapData;
			(image as StarlingImage).readjustSize();
		}
		
		public function updateTexture(target:BitmapData, source:BitmapData):void {
			var texture:RenderTexture = texturesByBitmap[target];
			if(!texture){
				trace("[StarlingPlugin::updateTexture] ERROR: Can't find a texture for the supplied bitmapData.");
				return;
			}
			if(target != source){
				var s:Sprite = new flash.display.Sprite();
				s.graphics.beginBitmapFill(source);
				s.graphics.drawRect(0, 0, (texture as RenderTexture).width, (texture as RenderTexture).height);
				source = Display.cache(s);
			}
			var image:Image = new Image(Texture.fromBitmapData(source));
			(texture as RenderTexture).clear();
			(texture as RenderTexture).draw(image);
		}
		
		public function swapTextures(target:IImage, source:IImage):void {
			(target as StarlingImage).texture = (source as StarlingImage).texture;
			(target as StarlingImage).bitmapData = (source as StarlingImage).bitmapData;
			(target as StarlingImage).readjustSize();
		}
	}
}