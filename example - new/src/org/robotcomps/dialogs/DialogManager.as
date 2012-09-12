package org.robotcomps.dialogs
{
	
	import flash.display.Stage;
	import flash.events.Event;
	
	import org.robotcomps.Device;
	import org.robotcomps.Display;
	import org.robotcomps.RobotComps;
	import org.robotcomps.core.display.IContainer;
	import org.robotcomps.core.display.IImage;

	public class DialogManager 
	{
		protected static var root:*;
		protected static var underlay:IImage;
		
		protected static var viewWidth:int;
		protected static var viewHeight:int;
		protected static var stage:Stage;
		
		public static var underlayAlpha:Number = .65;
		
		public static function init(rootView:*, stage:Stage):void {
			root = rootView;
			viewWidth = stage.stageWidth;
			viewHeight = stage.stageHeight;
			
			RobotComps.stageResized.add(onStageResized);
			DialogManager.stage = stage;
			
			underlay = Display.getImageByType(Display.BG_DARK);
			underlay.mouseClicked.add(onUnderlayClicked);
			underlay.alpha = underlayAlpha;
		}
		
		protected static function onUnderlayClicked(target:*):void {
			if(!lockModal){
				removeDialogs();
			}
		}
		
		protected static function onStageResized(width:int, height:int):void {
			viewWidth = width;
			viewHeight = height;
			setSize(viewWidth, viewHeight);
		}
		
		public static function get currentDialog():BaseDialog { return topDialog as BaseDialog; }
		
		protected static var topDialog:BaseDialog;
		public static var lockModal:Boolean;
		public static var closeCallback:Function;
		
		public static function removeDialogs():void {
			if(topDialog && root.contains(topDialog.display)){
				topDialog.buttonClicked.removeAll();
				root.removeChild(topDialog.display);
				topDialog = null;
				if(closeCallback != null){
					closeCallback();
					closeCallback = null;
				}
			}
			if(root.contains(underlay)){
				root.removeChild(underlay);
			}
		}
		
		public static function showDialog(dialog:BaseDialog, lockModal:Boolean=false, showOverlay:Boolean=true):BaseDialog {
			if(!root){
				trace("[DialogManager] 'rootView' is undefined, make sure you called DialogManaer.init(root)");
				return null; 
			}
			
			removeDialogs();
			if(showOverlay){
				root.addChild(underlay);
			}
			
			DialogManager.lockModal = lockModal;
			
			DialogManager.topDialog = dialog;
			root.addChild(dialog.display);
			if(viewWidth <= 0){
				setSize(root.width, root.height);
			} else {
				setSize(viewWidth, viewHeight);
			}
			return dialog;
		}
		
		protected static function onDialogCancel(event:Event):void {
			
		}
		
		public static function setSize(width:int=0, height:int=0):void {
			viewWidth = width;
			viewHeight = height;
			
			underlay.width = width;
			underlay.height = height;
			if(topDialog){
				var orgWidth:int = width;
				if(topDialog.width > viewWidth || topDialog.height > viewHeight){
					topDialog.setSize(width, height);
				} 
				center();
			}
		}
		
		public static function center():void {
			if(!topDialog || !underlay){ return; }
			topDialog.x = underlay.width - topDialog.width >> 1;
			topDialog.y = underlay.height - topDialog.height >> 1;
		}
		
		public static function alert(title:String, message:String):TitleDialog {
		
			var dialog:TitleDialog = new TitleDialog(Device.dialogWidth, Device.dialogHeight, title, message);
			dialog.setButtons(["Ok"]);
			dialog.buttonClicked.add(alertClicked);
			DialogManager.showDialog(dialog);
			return dialog;
		
		}
		
		public static function alertClicked(label:String):void {
			removeDialogs();
		}
		
	}
}