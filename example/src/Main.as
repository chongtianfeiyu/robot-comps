package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import org.robotcomps.RobotComps;
	import org.robotcomps.controls.BorderBox;
	import org.robotcomps.core.display.data.RenderMode;
	import org.robotcomps.dialogs.DialogManager;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	[SWF(width="1280", height="720", frameRate="60", backgroundColor="#f2f2f2")]
	public class Main extends flash.display.Sprite
	{
		public static var _starling:Starling;
		protected var sink:KitchenSink;
		
		public function Main(){
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var renderMode:String = RenderMode.NATIVE;
			renderMode = RenderMode.STARLING;
			
			if(renderMode == RenderMode.NATIVE){
				//Init Normal Mode
				RobotComps.init(stage, this, renderMode);
				sink = new KitchenSink(this, stage);
			} 
			else {
				_starling = new Starling(starling.display.Sprite, stage);
				_starling.addEventListener(Event.ROOT_CREATED, function():void {
					
					//Init starling mode
					RobotComps.init(stage, Starling.current.root, renderMode);
					sink = new KitchenSink(Starling.current.root, stage);
					
				})
				_starling.start();
			}
		}
		
	}
}