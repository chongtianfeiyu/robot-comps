package
{
	import org.robotcomps.RobotComps;
	import org.robotcomps.controls.BaseButton;
	import org.robotcomps.controls.BorderBox;
	import org.robotcomps.core.display.DisplayType;
	
	import starling.display.Sprite;

	public class KitchenSink
	{
		protected var starlingRoot:starling.display.Sprite;
		private var root:*;
		
		public function KitchenSink(root:*){
			this.root = root;
			
			if(RobotComps.renderMode == DisplayType.STARLING){
				starlingRoot = root;
			}
			
			var b:BaseButton = new BaseButton();
			b.setSize(200, 100);
			b.x = 100;
			b.y = 20;
			trace(b.width, b.height);
			root.addChild(b.display);
		}
	}
}