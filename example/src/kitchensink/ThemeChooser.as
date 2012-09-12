package kitchensink
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	import org.robotcomps.Device;
	import org.robotcomps.Display;
	import org.robotcomps.RobotComps;
	import org.robotcomps.TextFields;
	import org.robotcomps.controls.BorderBox;
	import org.robotcomps.core.display.IImage;
	import org.robotcomps.core.view.SizableView;
	import org.robotcomps.style.Themes;
	import org.robotcomps.style.data.ColorTheme;
	
	import starling.display.Image;

	public class ThemeChooser extends SizableView {
		
		protected var swatchSize:int;
		protected var swatches:Array;
		protected var swatchByImage:Dictionary;
		protected var borderBox:BorderBox;
		
		public var themeChanged:Signal;
		
		
		public function ThemeChooser(){
		
			themeChanged = new Signal(ColorTheme);
			
			swatchSize = Device.hitSize;
			
			swatches = [
				Themes.getTheme(Themes.BLUE), 
				Themes.getTheme(Themes.GREEN), 
				Themes.getTheme(Themes.RED),
				Themes.getTheme(Themes.WHITE_BLUE), 
				Themes.getTheme(Themes.WHITE_GREEN), 
				Themes.getTheme(Themes.WHITE_RED)
			];
			
			swatchByImage = new Dictionary();
			for(var i:int = 0; i < swatches.length; i++){
				var image:IImage = Display.getImage(createSquare(swatches[i]));
				image.x = (image.width * 1.1) * i;
				image.mouseClicked.add(onMouseClicked);
				display._addChild(image);	
				swatchByImage[image] = swatches[i];
			}
			
			borderBox = new BorderBox(2);
			borderBox.setSize(swatchSize, swatchSize);
			display._addChild(borderBox.display);
			
			selectTheme(RobotComps.theme);
		}
		
		protected function selectTheme(theme:ColorTheme):void {
			for(var image:* in swatchByImage){
				var i:IImage = image as IImage;
				var ct:ColorTheme = swatchByImage[image];
				if(ct.accent == theme.accent && ct.bg == theme.bg){
					borderBox.x = i.x;
					borderBox.y = i.y;
					break;
				}
			}
		}
		
		protected function onMouseClicked(target:Object):void {
			themeChanged.dispatch(swatchByImage[target]);
			selectTheme(swatchByImage[target]);
		}
		
		protected function createSquare(theme:ColorTheme):BitmapData {
			var bitmapData:BitmapData = new BitmapData(swatchSize, swatchSize, false, theme.divider);
			bitmapData.fillRect(new Rectangle(1, 1, swatchSize - 2, swatchSize - 2), theme.bg);
			bitmapData.fillRect(new Rectangle(swatchSize/2 + 1, 1, swatchSize/2 - 1, swatchSize/2), theme.divider);
			bitmapData.fillRect(new Rectangle(1, 1, swatchSize/2, swatchSize/2), theme.accent);
			return bitmapData;
		}
	}
}