package org.robotcomps.containers
{
	import org.robotcomps.containers.layouts.HorizontalLayout;
	import org.robotcomps.view.SizableView;
	
	public class HBox extends SizableView
	{
		public function HBox() {
			layout = new HorizontalLayout();
		}
	}
};