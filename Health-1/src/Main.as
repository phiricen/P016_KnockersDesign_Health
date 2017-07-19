package
{
	import aoba.*;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.Font;
	import scene.*;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Main extends AOBA_Main 
	{	
		public var mc_idler:AOBA_Idler;
		private var preloader:AOBA_Preloader;
		private var scenes:Array = [];
		private var steps:Array = [];
		private var mc_steps:AOBA_Sprite = new AOBA_Sprite;
		private var now_scene:int;
		public static const WIDTH:int = 1920;
		public static const HEIGHT:int = 1080;
		public function Main() {
			AOBA_TextField.FONT_CH = "文鼎新粗黑";
			set_scenes();
			set_steps();
		}		
		protected override function onIdlerZero():void { scene_to(1); }
		protected override function onStageReady():void { init();}
		private function init():void{
			scene_to(1);
			AOBA_Idler.start();
		}
		private function set_scenes():void {
			var mc_S1:Scene_1 = new Scene_1();
			var mc_S2:Scene_2 = new Scene_2();
			var mc_S3:Scene_3 = new Scene_3();
			var mc_S4:Scene_4 = new Scene_4();
			var mc_S5:Scene_5 = new Scene_5();
			var mc_S6:Scene_6 = new Scene_6();
			scenes.push(mc_S1, mc_S2, mc_S3, mc_S4, mc_S5, mc_S6);
			for (var i:int = 0; i < scenes.length;i++){ scenes[i].visible = false; }
			
			mc_S1.onNextScene = function():void {
				scene_to(2);
				AOBA_Idler.reset();
			}
			mc_S2.onNextScene = function():void { scene_to(3); }
			mc_S3.onNextScene = function():void { scene_to(4); }
			mc_S4.onNextScene = function():void { 
				step_to(4);
				mc_S4.hide();
				mc_S6.show();
				AOBA_Idler.pause();
				/*
				step_to(4);
				mc_S5.show();
				*/
			}
			mc_S5.onNextScene = function():void {
				mc_S4.hide();
				mc_S5.hide();
				mc_S6.show();
			}
			mc_S6.onNextScene = function():void {
				scene_to(1);
				AOBA_Idler.pause();
			}
			
			addChild(mc_S1);
			addChild(mc_S2);
			addChild(mc_S3);
			addChild(mc_S4);
			addChild(mc_S5);
			addChild(mc_S6);
		}
		private function set_steps():void {
			steps.push(
				new AOBA_ImageButton("img/button_1.png", "img/button_active_1.png"),
				new AOBA_ImageButton("img/button_2.png", "img/button_active_2.png"),
				new AOBA_ImageButton("img/button_3.png", "img/button_active_3.png"),
				new AOBA_ImageButton("img/button_4.png", "img/button_active_4.png")
			);
			for (var i:int = 0; i < steps.length; i++){
				var top:int = 20;
				switch(i){
					case 0:
						steps[i].y = top;
						break;
					case 1:
						steps[i].y = top+251;
						break;
					case 2:
						steps[i].y = top+251+238;
						break;
					case 3:
						steps[i].y = top+251+238+243;
						break;
				}
				mc_steps.addChild(steps[i]);
			}
			mc_steps.x = 20;
			mc_steps.y = 18;
			mc_steps.visible = false;
			addChild(mc_steps);
		}
		private function scene_to(_no:int=1):void{
			now_scene = _no;
			mc_steps.visible = _no > 1;
			for (var i:int = 0; i < scenes.length; i++){
				if(_no == i + 1){
					scenes[i].show();
				}
				else {
					scenes[i].hide();
				}
			}
			if ( _no > 1 ) step_to(_no - 1);
		}
		private function step_to(_step:int):void {
			for (var i:int = 0; i < steps.length; i++){
				if ( _step == i+1 ){
					steps[i].focus();
				}
				else {
					steps[i].blur();
				}
			}
		}
	}	
}