package scene.scene4
{
	import aoba.*;
	import flash.events.MouseEvent;
	import scene.Scene_4;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Burette extends AOBA_Sprite 
	{
		public var index:int;
		public var msg:String;
		private var msg_x:int;
		private var msg_y:int;
		private var img_serum:AOBA_Image;
		private var vp_serum:AOBA_VideoPlayer;
		private var vp_burette:AOBA_VideoPlayer;
		public var captured:Boolean = false;
		public var messager:Message;
		public function Burette() 
		{
			super();
		}
		public override function init():void {
			vp_burette = new AOBA_VideoPlayer("flv/burettes_capture.flv");
			vp_burette.onPlayComplete = onPlayComplete;
			addChild(vp_burette);
			
			vp_serum = new AOBA_VideoPlayer("flv/serum.flv");
			vp_serum.auto_loop = true;
			vp_serum.x = 45;
			vp_serum.y = 423;
			addChild(vp_serum);
			
			img_serum = new AOBA_Image("img/serum.png");
			img_serum.draggable = true;
			img_serum.x = 98;
			img_serum.y = 461;
			img_serum.alpha = 0;
			img_serum.addEventListener(MouseEvent.MOUSE_UP, onStartCapture);
			addChild(img_serum);
				
			switch(index){
				default:
				case 0:
				case 2:
				case 5:
					msg_x = 180;
					msg_y = 120;
					msg = "無異常數值";
					break;
					
				case 1:
					msg_x = 180;
					msg_y = 58;
					msg = "CA-125 指數偏高"
					msg += "\r";
					msg += "\rCA-125是檢查婦女生殖器官的腫瘤標記。當發生卵巢上皮腫瘤、";
					msg += "\r良性畸形瘤、輸卵管瘤、子宮內膜腺瘤、子宮內膜異位，以及女性";
					msg += "\r生理期、停經婦女等，CA-125指數可能偏高。另 CA-125 也可以";
					msg += "\r診斷腸胃道的癌症。";
					msg += "\r";
					msg += "\r如果CA - 125檢驗數值偏高，建議至婦科進一步追蹤。";
					break; 
					
				case 3:
					msg_x = 180;
					msg_y = 120;
					msg = "CA-153 指數偏高"
					msg += "\r";
					msg += "\rCA-153可以檢查卵巢癌及乳癌的腫瘤標記，";
					msg += "\r如果指數偏高，建議至乳房外科進一步追蹤。";
					break;

				case 4:
					msg_x = 180;
					msg_y = 80;
					msg = "CEA 指數偏高"
					msg += "\r";
					msg += "\r大腸癌的病人，CEA 指數會增加外，在胃癌、";
					msg += "\r乳癌、胰臟癌及肺癌等都會增高，抽菸者數值";
					msg += "\r也會有偏高現象。";
					msg += "\r";
					msg += "\r如果 CEA 檢查數值偏高，建議進一步檢查。";
					break;
			}
		}
		public function reset():void{
			captured = false;
			vp_serum.visible = true;
			img_serum.visible = true;
			vp_burette.player.seek(0);
			vp_serum.replay();
			visible = true;
		}
		private function onStartCapture(e:MouseEvent):void {
			if (Scene_4.isInjecting) return;
			Scene_4.isInjecting = true;
			vp_serum.visible = false;
			img_serum.visible = false;
			vp_burette.play();
			vp_serum.stop();
			AOBA_Idler.reset();
		}
		private function onPlayComplete(_vp:AOBA_VideoPlayer):void{
			captured = true;
			messager.say(msg);
			messager.txt_msg.x = msg_x;
			messager.txt_msg.y = msg_y;
			AOBA_Idler.reset();
		}
	}
}