package
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	import org.robotcomps.Display;
	import org.robotcomps.RobotComps;
	import org.robotcomps.TextFields;
	import org.robotcomps.core.display.IContainer;
	import org.robotcomps.core.display.IImage;
	import org.robotcomps.core.view.SizableView;

	public class SanityTests extends SizableView
	{
		protected var colorLabelText:TextField;
		protected var colorLabelImage:IImage;
		protected var colorContainer:IContainer
		protected var colorImages:Array = [];
		
		protected var textLabelText:TextField;
		protected var textLabelImage:IImage;
		
		protected var padding:int = 10;
		private var leftText:TextField;
		private var centerText:TextField;
		private var rightText:TextField;
		private var leftTextImage:IImage;
		private var centerTextImage:IImage;
		private var rightTextImage:IImage;
		private var multiLineText:TextField;
		private var multiLineTextImage:IImage;
		
		public function SanityTests(){
			
			createChildren();
			
		}
		
		protected function createChildren():void {
			
			colorContainer = Display.getContainer();
			display._addChild(colorContainer);
			
			//Color Strip to test the getImageByColor API
			colorLabelText = TextFields.getBold("getImageByColor()", -1, RobotComps.theme.text);
			colorLabelImage = Display.getImage();
			TextFields.register(colorLabelText, colorLabelImage);
			TextFields.update(colorLabelText);
			colorContainer._addChild(colorLabelImage);
			
			var colors:Array = makeColorGradient(.3,.3,.3,0,2,4);
			for(var i:int = 0; i < colors.length; i++){
				var image:IImage = Display.getImageByColor(colors[i]);
				image.width = image.height = 40;
				colorContainer._addChild(image);
				colorImages[i] = image;
			}
			
			textLabelText = TextFields.getBold("Textfields", -1, RobotComps.theme.text);
			textLabelImage = Display.getImage();
			TextFields.register(textLabelText, textLabelImage);
			TextFields.update(textLabelText);
			display._addChild(textLabelImage);
			
			leftText = TextFields.getRegular("Left Text Regular", RobotComps.fontSize, RobotComps.theme.text, TextFormatAlign.LEFT);
			leftTextImage = Display.getImage();
			TextFields.register(leftText, leftTextImage);
			TextFields.update(leftText);
			display._addChild(leftTextImage);
			
			centerText = TextFields.getBold("Center Text Bold", RobotComps.fontSize, RobotComps.theme.text, TextFormatAlign.CENTER);
			centerText.autoSize = TextFieldAutoSize.NONE;
			centerTextImage = Display.getImage();
			TextFields.register(centerText, centerTextImage);
			TextFields.update(centerText, false);
			display._addChild(centerTextImage);
			
			rightText = TextFields.getBold("Right Text Regular", RobotComps.fontSize, RobotComps.theme.text, TextFormatAlign.RIGHT);
			rightText.autoSize = TextFieldAutoSize.NONE;
			rightTextImage = Display.getImage();
			TextFields.register(rightText, rightTextImage);
			TextFields.update(rightText, false);
			display._addChild(rightTextImage);
			
			multiLineText = TextFields.getBold("Paragraph: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae erat sed leo bibendum dapibus blandit a lacus. Mauris vitae congue velit. Nam congue diam augue, vitae tempus libero. In facilisis luctus lectus id suscipit. Nunc lectus leo, scelerisque ac commodo nec,", RobotComps.fontSize * .65, RobotComps.theme.text, TextFormatAlign.LEFT);
			multiLineText.width = 600;
			multiLineText.wordWrap = true;
			multiLineText.multiline = true;
			multiLineTextImage = Display.getImage();
			TextFields.register(multiLineText, multiLineTextImage);
			TextFields.update(multiLineText);
			display._addChild(multiLineTextImage);
			
		}
		
		override public function updateLayout():void {
			var imageWidth:Number = viewWidth / colorImages.length;
			
			for(var i:int = 0; i < colorImages.length; i++){
				var image:IImage = colorImages[i];
				image.width = imageWidth;
				image.height = 40;
				image.y = colorLabelImage.height + padding;
				image.x = image.width * i;
				colorContainer._addChild(image);
			}
			
			textLabelText.y = colorContainer.y + colorContainer.height + padding * 3;
			Display.match(textLabelImage, textLabelText);
			
			leftText.y = textLabelText.y + textLabelText.height + padding;
			Display.match(leftTextImage, leftText);
			
			centerText.y = leftText.y + leftText.height + padding;
			centerText.width = viewWidth;
			TextFields.update(centerText, false);
			Display.match(centerTextImage, centerText);
			
			rightText.y = centerText.y + centerText.height + padding;
			rightText.width = viewWidth;
			TextFields.update(rightText, false);
			Display.match(rightTextImage, rightText);
			
			multiLineText.y = rightText.y + rightText.height + padding;
			TextFields.update(multiLineText, false);
			Display.match(multiLineTextImage, multiLineText);
		}
		
		protected function makeColorGradient(frequency1:Number, frequency2:Number, frequency3:Number, 
								   phase1:int, phase2:int, phase3:int, 	
								   center:int = 128, width:int = 127, len:int = 24):Array {
			var colors:Array = [];
			for (var i:int = 0; i < len; ++i){
				var red:int = Math.sin(frequency1*i + phase1) * width + center;
				var grn:int = Math.sin(frequency2*i + phase2) * width + center;
				var blu:int = Math.sin(frequency3*i + phase3) * width + center;
				colors.push(red << 16 | grn << 8 | blu);
			}
			return colors;
		}
	}
}