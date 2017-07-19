package
{
	import aoba.*;
	import scene.*;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import scene.scene2.CountdownTimer;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Main extends AOBA_Main 
	{
		private var scene_idx:int=1;
		private var scene_1:Scene_1;
		private var scene_2:Scene_2;
		private var scenes:Array = [];
		public static const WIDTH:int = 1920;
		public static const HEIGHT:int = 1080;
		public function Main(){
			CountdownTimer.MAX = 30;
			AOBA_TextField.FONT_CH = "文鼎新中黑";
			set_scene();
		}
		private function onNextScene(e:Event = null ):void {
			scene_idx = scene_idx == 2 ? 1 : 2;
			scene_to(scene_idx);
		}
		private function scene_to(_idx:int):void {
			scene_idx = _idx;
			for (var i:int = 0; i < scenes.length;i++){
				if ( i + 1 == _idx ){
					scenes[i].show();
				}
				else {
					scenes[i].hide();
				}
			}
		}
		private function set_scene():void {
			scene_1 = new Scene_1(onNextScene);
			scene_2 = new Scene_2(onNextScene);
			scene_2.backToIndex = function():void { scene_to(1); }
			scenes.push(scene_1);
			scenes.push(scene_2);
			addChild(scene_1);
			addChild(scene_2);
		}
		protected override function onIdlerZero():void {
			if (scene_1.index == 1) return;
			scene_to(1);
		}
		protected override function onStageReady():void {
			scene_to(1);
			AOBA_Idler.start();
		}
	}	
}