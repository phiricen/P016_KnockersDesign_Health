package
{
	import aoba.*;
	import scene.*;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Main extends AOBA_Main 
	{
		private var scene_idx:int=1;
		private var scene_1:Scene_1;
		private var scene_2:Scene_2;
		private var scene_3:Scene_3;
		private var scenes:Array = [];
		public static var W:int = 1920;
		public static var H:int = 1080;
		public function Main() {
		trace('A');	
			super({ w:Main.W, h:Main.H });
			set_scene();
			raise_mask();
		}
		private function onNextScene(e:Event = null ):void {
			scene_idx = scene_idx == scenes.length ? 1 : scene_idx+1;
			scene_to(scene_idx);
		}
		private function scene_to(_idx:int):void {
			scene_idx = _idx;
			AOBA_Idler.reset();
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
			scene_3 = new Scene_3(onNextScene);
			scenes.push(scene_1);
			scenes.push(scene_2);
			scenes.push(scene_3);
			addChild(scene_1);
			addChild(scene_2);
			addChild(scene_3);
		}
		protected override function onIdlerZero():void {
			scene_to(1);
		}
		protected override function onStageReady():void {
			scene_to(1);
			AOBA_Idler.start();
		}
	}	
}