package scene
{
	import aoba.*;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import scene.scene4.Message;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Scene_5 extends Scene 
	{
		private var mc_msgBox:Message;
		public function Scene_5(){}
		public override function init():void {
			super.init();
			img_bg.visible = false;
		}	
		public function show():void {
			visible = true;
			AOBA_Idler.reset();
		}
		public function hide():void {
			visible = false;
		}
	}
}