package scene
{
	import aoba.*;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Scene_3 extends Scene 
	{
		private var vp_centrifuge:AOBA_VideoPlayer;
		private var img_centrifuge:AOBA_Image;
		private var img_start:AOBA_Image;
		public function Scene_3(){}
		public override function init():void {		
			super.init();	
			vp_centrifuge = new AOBA_VideoPlayer("flv/burettes_centrifuge.flv");
			vp_centrifuge.visible = false;
			vp_centrifuge.x = 671;
			vp_centrifuge.y = 66;
			vp_centrifuge.onPlayComplete = onNextScene;
			addChild(vp_centrifuge);
			
			img_centrifuge = new AOBA_Image("img/burettes_centrifuge.png");
			img_centrifuge.x = 671;
			img_centrifuge.y = 66;
			addChild(img_centrifuge);
			
			img_start = new AOBA_Image("img/start.png");
			img_start.x = 1628;
			img_start.y = 910;
			img_start.draggable = true;
			img_start.addEventListener( MouseEvent.CLICK, startCentrifuge);
			addChild(img_start);
			
			txt_hint.x = 680;
			txt_hint.y = 132;
			txt_hint.enableDrag();
			setHint("請按下離心機旁的啟動按鈕，啟動血液分離步驟");
		}
		private function startCentrifuge(e:MouseEvent):void {
			img_centrifuge.visible = false;
			vp_centrifuge.visible = true;
			img_start.visible = false;
			vp_centrifuge.play();
			AOBA_Idler.pause();
		}
		public function show():void{
			img_centrifuge.visible = true;
			vp_centrifuge.visible = false;
			img_start.visible = true;
			visible = true;
			AOBA_Idler.reset();
		}
		public function hide():void{
			visible = false;
			vp_centrifuge.player.seek(0);
		}
	}
}