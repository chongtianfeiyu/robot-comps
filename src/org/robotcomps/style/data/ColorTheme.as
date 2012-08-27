package org.robotcomps.style.data
{
	public class ColorTheme
	{
		public var bgDark:uint;
		public var bgLight:uint;
		public var text:uint;
		public var accent:uint;
		
		public function ColorTheme(accent:uint, text:uint, bgLight:uint, bgDark:uint){
			this.accent = accent;
			this.text = text;
			this.bgLight = bgLight;
			this.bgDark = bgDark;
		}
	}
}