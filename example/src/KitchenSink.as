package
{
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.easing.Quadratic;
	
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import flashx.textLayout.formats.TextAlign;
	
	import kitchensink.ThemeChooser;
	
	import org.robotcomps.Device;
	import org.robotcomps.Display;
	import org.robotcomps.RobotComps;
	import org.robotcomps.TextFields;
	import org.robotcomps.controls.BorderBox;
	import org.robotcomps.controls.SimpleButton;
	import org.robotcomps.controls.Slider;
	import org.robotcomps.core.display.IContainer;
	import org.robotcomps.core.display.IImage;
	import org.robotcomps.core.display.data.RenderMode;
	import org.robotcomps.dialogs.DialogManager;
	import org.robotcomps.style.Animations;
	import org.robotcomps.style.Themes;
	import org.robotcomps.style.data.ColorTheme;
	
	import starling.core.Starling;

	public class KitchenSink
	{
		
		[Embed(source="assets/bgStrip.png")]
		public var BgStrip:Class;
		
		[Embed(source="assets/iconArrow.png")]
		public var Arrow:Class;
		
		public static var width:int;
		public static var height:int;
		
		protected var root:*;
		
		protected var menu:IContainer;
		protected var box:BorderBox;
		
		protected var stage:Stage;
		private var menuButtons:Array;

		protected var themeChooser:ThemeChooser;

		protected var bg:IImage;

		private var sanityTest:SanityTests;
		
		public function KitchenSink(root:*, stage:Stage){
			this.root = root;
			this.stage = stage;
			
			width = stage.stageWidth;
			height = stage.stageHeight;
			
			RobotComps.stageResized.add(onStageResized);
			//TextFields.showOutlines = true;
			
			//Add BG (for dark themes only)
			bg = Display.getImage(new BgStrip().bitmapData);
			bg.width = width;
			bg.height = height;
			root.addChild(bg);
			
			//Add Bottom Menu
			createMenu();
			
			//Add Logo
			createLogo();
			
			//Sanity Test
			sanityTest = new SanityTests();
			root.addChild(sanityTest.display);
			
			//Add Theme Choose
			themeChooser = new ThemeChooser();
			themeChooser.themeChanged.add(onThemeChanged);
			root.addChild(themeChooser.display);
			
			/*
			var slider:Slider = new Slider(.5, "Slider");
			slider.setSize(400, 100);
			slider.x = 50;
			slider.y = 100;
			root.addChild(slider.display);
			*/
			
			onStageResized(width, height);
			
			new GTween(themeChooser, 1, {x: themeChooser.x}, {delay: 1, ease:Quadratic.easeOut});
			themeChooser.x += themeChooser.width * 2;
		}
		
		protected function onThemeChanged(theme:ColorTheme):void {
			
			RobotComps.setTheme(theme);
			
			if(theme.bg == Themes.getTheme(Themes.BLUE).bg){
				bg.visible = true;
			} else {
				bg.visible = false;
			}
		}
		
		protected function onStageResized(width:int, height:int):void {
			KitchenSink.height = height;
			KitchenSink.width = width;
			
			themeChooser.x = width - themeChooser.width - 10;
			themeChooser.y = 5;
			
			menu.y = KitchenSink.height - menu._getChildAt(0).height;
			
			bg.width = width;
			bg.height = height;
			
			
			sanityTest.x = 10;
			sanityTest.y = 50;
			sanityTest.setSize(width - sanityTest.x * 2, height - sanityTest.y - menu.height);
			
			var buttonWidth:int = width / menuButtons.length;
			for(var i:int = 0; i < menuButtons.length; i++){
				var button:SimpleButton = menuButtons[i];
				button.x = buttonWidth * i;
				button.setSize(buttonWidth, button.height);
			}
			
			//Resize starling viewport to match stage
			if(RobotComps.renderMode == RenderMode.STARLING){
				
				var viewPortRectangle:Rectangle = new Rectangle();
				viewPortRectangle.width = width;
				viewPortRectangle.height = height;
				Starling.current.stage.stageWidth = width;
				Starling.current.stage.stageHeight = height;
				Starling.current.viewPort = viewPortRectangle;
		
			}
		}
		
		protected function createLogo():void {
			
			//Create Logo Text and register textfields so they are updated when the theme color is changed.
			var logoText:TextField = TextFields.getBold("RobotComps", RobotComps.fontSize, RobotComps.theme.accent);
			logoText.x = logoText.y = 10;
			logoText.width = 500;
			
			var logoImage:IImage = Display.getImage();
			root.addChild(logoImage);
			TextFields.updateImage(logoImage, logoText);
			TextFields.register(logoText, logoImage);
			
			logoText = TextFields.getRegular(": Kitchen Sink", RobotComps.fontSize, RobotComps.theme.accent);
			logoText.x = logoImage.x + logoImage.width|0;
			logoText.y = 10;
			logoText.width = 200;
			
			var logoImage2:IImage = Display.getImage();
			root.addChild(logoImage2);
			TextFields.updateImage(logoImage2, logoText);
			TextFields.register(logoText, logoImage2);
		}
		
		protected function createMenu():void {
			
			menu = Display.getContainer();
			menuButtons = [];
			
			var menuItems:Array = ["Controls", "Dialogs", "Lists", "Layouts"];
			var width:int = width/menuItems.length;
			var height:int = Device.hitSize * 2;
			
			for(var i:int = 0, l:int = menuItems.length; i < l; i++){
				var button:SimpleButton = new SimpleButton(menuItems[i], null, Display.ACCENT);
				button.borders.imageType = Display.DIVIDER;
				
				button.setSize(width, height);
				button.align = TextAlign.CENTER;
				
				button.x = i * width;
				
				if(i < l - 1){	
					button.borders.show(false, true, true, false);
				} else {
					button.borders.show(false, false, true, false);
				}
				
				button.mouseClicked.add(onButtonClicked);
				menu._addChild(button.display);
				
				new GTween(button.display, Animations.SHORT, {y: button.y}, {delay: i * Animations.SHORT * .5, ease: Animations.EASE_OUT});
				button.y += button.height;
				menuButtons[i] = button;
			}
			
			box = new BorderBox(1);
			box.setSize(button.width * i, button.height);
			box.show(false, false, true, false);
			box.x = -box.width;
			
			menu._addChild(box.display);
			new GTween(box.display, Animations.SHORT, {x: 0}, {delay: .8, ease: Animations.EASE_OUT});
			
			menu.y = KitchenSink.height - button.height;
			root.addChild(menu);
		}
		
		protected function onButtonClicked(target:Object):void {
			DialogManager.alert("Hello World!", "Maecenas volutpat porta elit, sit amet porttitor nunc lacinia ut. Mauris ornare bibendum nulla eu porta. Curabitur sed convallis urna.");
		}
	}
}