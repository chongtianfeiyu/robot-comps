package org.robotcomps.core.utils
{
	import flash.ui.Mouse;
	
	import org.osflash.signals.Signal;

	public class MouseSignals
	{
		public var mouseDown:Signal;
		public var mouseUp:Signal;
		public var mouseClicked:Signal;
		
		public function MouseSignals(){
			
			mouseDown = new Signal(Object);
			mouseUp = new Signal(Object);
			mouseClicked = new Signal(Object);
			
			
		}
	}
}