package org.robotcomps.controls
{
	
	import flash.display.BitmapData;
	
	import org.robotcomps.Display;
	import org.robotcomps.core.display.IImage;
	import org.robotcomps.core.view.SizableView;
	
	public class BorderBox extends SizableView
	{
		protected var lB:IImage;
		protected var rB:IImage;
		protected var tB:IImage;
		protected var bB:IImage;
		
		protected var _borderData:BitmapData;
		public var borderSize:int = 1;
		
		public function BorderBox(borderSize:int = 1, borderType:String = null){
			
			var type:String = (borderType)? borderType : Display.ACCENT;
			lB = Display.getImageByType(type);
			rB = Display.getImageByType(type);
			tB = Display.getImageByType(type);
			bB = Display.getImageByType(type);
			
			display._addChild(lB);
			display._addChild(rB);
			display._addChild(tB);
			display._addChild(bB);
			
			this.borderSize = borderSize;
		}
		
		public function set imageType(value:String):void {
			var image:IImage = Display.getImageByType(value);
			if(!image){ return; }
			
			Display.swapTextures(lB, image);
			Display.swapTextures(rB, image);
			Display.swapTextures(tB, image);
			Display.swapTextures(bB, image);
		}
		
		public function show(left:Boolean = true, right:Boolean = true, top:Boolean = true, bottom:Boolean = true):void {
			lB.visible = left;
			rB.visible = right;
			tB.visible = top;
			bB.visible = bottom;
		}
		
		public function hide(left:Boolean = true, right:Boolean = true, top:Boolean = true, bottom:Boolean = true):void {
			lB.visible = !left;
			rB.visible = !right;
			tB.visible = !top;
			bB.visible = !bottom;
		}
		
		override public function updateLayout():void {
			lB.width = borderSize;
			lB.height = viewHeight;
			
			rB.x = viewWidth - borderSize;
			rB.width = borderSize;
			rB.height = viewHeight;
			
			tB.width = viewWidth;
			tB.height = borderSize;
			
			bB.y = viewHeight - borderSize;
			bB.width = viewWidth;
			bB.height = borderSize;
		}
	}
}