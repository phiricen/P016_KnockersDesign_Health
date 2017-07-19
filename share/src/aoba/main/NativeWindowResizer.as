package aoba.main
{
	import flash.display.NativeWindow;
	import flash.desktop.NativeApplication;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Phiricen
	 */
	public class NativeWindowResizer
	{
		public function NativeWindowResizer(stage:Stage, res:Object) 
		{
			var window:NativeWindow = NativeApplication.nativeApplication.activeWindow;
			window.x = (stage.fullScreenWidth - res.w) / 2;
			window.y = (stage.fullScreenHeight - res.h) / 2;
			window.height = res.h;
			window.width = res.w;
		}		
	}
}