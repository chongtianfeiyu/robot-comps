package org.robotcomps.dialogs
{
	import org.robotcomps.Display;
	import org.robotcomps.core.display.IImage;
	import org.robotcomps.core.view.SizableView;

	public class DialogBackground extends SizableView
	{
		public var outer:IImage;
		public var inner:IImage;
		
		public function DialogBackground() {
			
			outer = Display.getImageByType(Display.DIVIDER);
			display._addChild(outer);
			
			inner = Display.getImageByType(Display.BG);
			display._addChild(inner);
		}
		
		override public function updateLayout():void {
			outer.width = viewWidth;
			outer.height = viewHeight;
			inner.x = inner.y = 1;
			inner.width = viewWidth - 2;
			inner.height = viewHeight - 2;
		}
	}
}