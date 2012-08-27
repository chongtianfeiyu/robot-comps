package
{
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.easing.Quadratic;
	
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	
	import flashx.textLayout.formats.TextAlign;
	
	import org.robotcomps.Device;
	import org.robotcomps.Display;
	import org.robotcomps.RobotComps;
	import org.robotcomps.TextFields;
	import org.robotcomps.controls.BorderBox;
	import org.robotcomps.controls.SimpleButton;
	import org.robotcomps.core.display.IImage;
	import org.robotcomps.core.display.data.RenderMode;
	import org.robotcomps.dialogs.DialogManager;
	import org.robotcomps.dialogs.TitleDialog;
	import org.robotcomps.style.Animations;
	import org.robotcomps.style.Themes;
	import org.robotcomps.style.data.ColorTheme;
	
	import starling.display.Sprite;

	public class KitchenSink
	{
		
		[Embed(source="assets/bgStrip.png")]
		public var BgStrip:Class;
		
		[Embed(source="assets/iconArrow.png")]
		public var Arrow:Class;
		
		public static var width:int;
		public static var height:int;
		
		protected var box:BorderBox;
		protected var starlingRoot:starling.display.Sprite;
		protected var root:*;
		protected var stage:Stage;
		
		public function KitchenSink(root:*, stage:Stage){
			this.root = root;
			this.stage = stage;
			
			width = stage.stageWidth;
			height = stage.stageHeight;
			
			if(RobotComps.renderMode == RenderMode.STARLING){
				starlingRoot = root;
			}
			
			//Add BG
			var bg:IImage = Display.getImageFromBitmap(new BgStrip());
			bg.width = width;
			bg.height = height;
			bg.visible = false;
			root.addChild(bg);
			
			//Add Bottom Menu
			createMenu();
			
			//Add Logo
			createLogo();
			
			setTimeout(function(){
				
				var theme:ColorTheme = Themes.getTheme(Themes.BLUE);
				//RobotComps.setTheme(theme);
				
				//bg.visible = true;
				
			}, 3000);
			
		}
		
		protected function createLogo():void {
			var logo:TextField = TextFields.getBold(RobotComps.fontSize, RobotComps.theme.accent);
			logo.width = 500;
			logo.text = "RobotComps";
			
			var logoImage:IImage = Display.getImage(TextFields.cache(logo, true));
			logoImage.x = logoImage.y = 10;
			root.addChild(logoImage);
			
			logo = TextFields.getRegular(RobotComps.fontSize, RobotComps.theme.accent);
			logo.width = 200;
			logo.text = ': Kitchen Sink';
			
			var logoImage2:IImage = Display.getImage(TextFields.cache(logo, true));
			logoImage2.x = logoImage.x + logoImage.width|0;
			logoImage2.y = 10;
			root.addChild(logoImage2);
		}
		
		protected function createMenu():void {
			var menu:Array = ["Controls", "Dialogs", "Lists", "Layouts", "Themes"];
			var width:int = width/menu.length;
			var height:int = Device.hitSize * 2;
			
			for(var i:int = 0, l:int = menu.length; i < l; i++){
				
				var button:SimpleButton = new SimpleButton(menu[i], null, Display.BG_LIGHT);
				button.setSize(width, height);
				button.align = TextAlign.CENTER;
				
				button.x = i * width;
				button.y = stage.stageHeight - button.height;
				
				if(i < l - 1){	
					button.borders.show(false, true, true, false);
				} else {
					button.borders.show(false, false, true, false);
				}
				button.borders.setImageType(Display.BG_LIGHT);
				
				button.mouseClicked.add(onButtonClicked);
				root.addChild(button.display);
				
				new GTween(button.display, Animations.SHORT, {y: button.display.y}, {delay: i * Animations.SHORT * .5, ease: Animations.EASE_OUT});
				button.y += button.height;
			}
			
			box = new BorderBox(1);
			box.setSize(button.width * i, button.height);
			box.show(false, false, true, false);
			box.x = -box.width;
			box.y = button.y - button.height;
			root.addChild(box.display);
			new GTween(box.display, Animations.SHORT, {x: 0}, {delay: .5, ease: Animations.EASE_OUT});
		}
		
		protected function onButtonClicked(target:Object):void {
			var dialog:TitleDialog = new TitleDialog(600, 350, "Hello World!", "Maecenas volutpat porta elit, sit amet porttitor nunc lacinia ut. Mauris ornare bibendum nulla eu porta. Curabitur sed convallis urna.");
			dialog.x = width - dialog.width >> 1;
			dialog.y = height - dialog.height - box.height >> 1;
			dialog.setButtons(["Cancel", "Ok"]);
			dialog.buttonClicked.add(function(label:String){
				DialogManager.removeDialogs();
			});
			DialogManager.showDialog(dialog);
			
		}
	}
}