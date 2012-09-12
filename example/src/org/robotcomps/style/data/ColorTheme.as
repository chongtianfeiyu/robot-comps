package org.robotcomps.style.data
{
	public class ColorTheme
	{
		public var bg:uint;
		public var divider:uint;
		public var text:uint;
		public var accent:uint;
		
		public function ColorTheme(accent:uint, text:uint, divider:uint, bg:uint){
			this.accent = accent;
			this.text = text;
			this.divider = divider;
			this.bg = bg;
		}
	}
}