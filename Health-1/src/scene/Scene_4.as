package scene
{
	import aoba.*;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import scene.scene4.Burette;
	import scene.scene4.Message;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Scene_4 extends Scene 
	{
		public static var isInjecting:Boolean = false;
		private var burettes:Array = [];
		private var mc_msgBox:Message;
		public function Scene_4(){}
		public override function init():void {
			super.init();
			
			mc_msgBox = new Message();
			mc_msgBox.x = 600;
			mc_msgBox.y = 308;
			
			for (var i:int = 0; i < 6; i++){
				var burette:Burette = new Burette();
				burette.x = 600 + 200 * i;
				burette.y = 250;
				burette.index = i;
				burette.messager = mc_msgBox;
				burettes.push(burette);
				addChild(burette);
			}
			txt_hint.x = 660;
			txt_hint.y = 170;
			setHint("請點選試管中血清位置，採取血清中樣本進行檢測");
			
			addChild(mc_msgBox);
			mc_msgBox.onFadeOuted = onCaptureComplete;
		}	
		public function show():void {
			mc_msgBox.visible = false;
			txt_hint.visible = true;
			for (var i:int = 0; i < burettes.length; i++){
				burettes[i].visible = true;
			}
			visible = true;
			AOBA_Idler.reset();
		}
		public function hide():void {
			visible = false;
			txt_hint.visible = false;
			hide_burettes();
		}
		public function hide_burettes():void{
			for (var i:int = 0; i < burettes.length; i++){
				burettes[i].reset();
				burettes[i].visible = false;
			}
		}
		private function onCaptureComplete():void {
			var amount:int = 0;
			for (var i:int = 0; i < burettes.length; i++){
				amount += burettes[i].captured ? 1 : 0;
			}
			if (amount == 6){
				onNextScene();
			}		
		}
	}
}