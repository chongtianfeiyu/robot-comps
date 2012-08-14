package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import org.robotcomps.RobotComps;
	import org.robotcomps.controls.BorderBox;
	import org.robotcomps.core.display.DisplayType;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	[SWF(width="700", height="500", frameRate="60", backgroundColor="#000000")]
	public class Main extends flash.display.Sprite
	{
		private var _starling:Starling;
		protected var sink:KitchenSink;
		
		public function Main(){
			
			RobotComps.init(stage, DisplayType.STARLING);
			
			if(RobotComps.renderMode == DisplayType.NATIVE){
				sink = new KitchenSink(this);
			} else {
				_starling = new Starling(starling.display.Sprite, stage);
				_starling.addEventListener(Event.ROOT_CREATED, function(){
					sink = new KitchenSink(Starling.current.root);
				})
				_starling.start();
			}
		}
		
	}
}