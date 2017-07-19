package scene
{
	import aoba.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	/**
	 * 
	 * @author Phiricen
	 */
	public class Scene_2 extends Scene 
	{
		private var vp_burettes_play:AOBA_VideoPlayer;
		private var vp_burettes_in:AOBA_VideoPlayer;
		public function Scene_2(){}
		public override function init():void {
			super.init();
			
			vp_burettes_play = new AOBA_VideoPlayer("flv/burettes_play.flv");
			vp_burettes_play.x = 620;
			vp_burettes_play.y = 200;
			vp_burettes_play.visible = false;
			vp_burettes_play.addEventListener(MouseEvent.MOUSE_UP, onPlayVideo);
			vp_burettes_play.onPlayComplete = onNextScene;
			addChild(vp_burettes_play);
			
			vp_burettes_in = new AOBA_VideoPlayer("flv/burettes_in.flv");
			vp_burettes_in.x = 620;
			vp_burettes_in.y = 200;
			vp_burettes_in.onPlayComplete = function():void { 
				vp_burettes_in.visible = false;
				vp_burettes_play.visible = true;
			};
			addChild(vp_burettes_in);
			
			txt_hint.x = 878;
			txt_hint.y = 132;
			setHint("請點選針筒，將血液注入試管內");
		}
		private function onPlayVideo(e:Event):void{
			AOBA_Idler.reset();
			vp_burettes_play.replay();
		}
		public function show():void {
			vp_burettes_in.replay();
			visible = true;
			AOBA_Idler.reset();
		}
		public function hide():void {
			visible = false;
			vp_burettes_in.player.seek(0);
			vp_burettes_play.player.seek(0);
		}
	}
}