package org.robotcomps.controls
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import org.robotcomps.Display;
	import org.robotcomps.RobotComps;
	import org.robotcomps.core.display.IImage;
	import org.robotcomps.core.view.SizableView;
	import org.robotcomps.style.data.ColorTheme;
	
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
		
		public function setImageType(type:String):void {
			//var image:IImage = Display.getImageByType(type);
			//Display.updateImage(
		}
		
		public function get bitmapData():BitmapData { return _borderData; }
		public function set bitmapData(value:BitmapData):void {
			_borderData = value;
			if(_borderData){
				Display.updateImage(lB, _borderData);
				Display.updateImage(rB, _borderData);
				Display.updateImage(tB, _borderData);
				Display.updateImage(bB, _borderData);
				updateLayout();
			}
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