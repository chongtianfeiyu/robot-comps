package org.robotcomps.controls
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import org.robotcomps.core.Colors;
	import org.robotcomps.core.Display;
	import org.robotcomps.core.display.IImage;
	import org.robotcomps.style.ColorTheme;
	import org.robotcomps.view.SizableView;
	
	public class BorderBox extends SizableView
	{
		protected var lB:IImage;
		protected var rB:IImage;
		protected var tB:IImage;
		protected var bB:IImage;
		
		public var borderSize:int = 1;
		
		public function BorderBox(borderSize:int = 1, borderData:BitmapData = null){
			this.borderSize = borderSize;
			
			if(!borderData){
				lB = Display.getImageByType(Display.ACCENT);
				rB = Display.getImageByType(Display.ACCENT);
				tB = Display.getImageByType(Display.ACCENT);
				bB = Display.getImageByType(Display.ACCENT);
			} else {
				lB = Display.getImage(borderData);
				rB = Display.getImage(borderData);
				tB = Display.getImage(borderData);
				bB = Display.getImage(borderData);
			}
			display._addChild(lB);
			display._addChild(rB);
			display._addChild(tB);
			display._addChild(bB);
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