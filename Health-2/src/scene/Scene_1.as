package scene 
{
	import aoba.*;
	import caurina.transitions.Tweener;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.system.ImageDecodingPolicy;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Scene_1 extends AOBA_Scene
	{
		private var tweenTimer:Timer = new Timer(10 * 1000);
		public var index:int = 1;
		private var imgs:Array = [];
		private var vp_play:AOBA_VideoPlayer;
		private var vp_gene:AOBA_VideoPlayer;
		private var vp_popup:AOBA_VideoPlayer;
		public function Scene_1(_onNextScene:Function = null):void { super(_onNextScene); }
		public override function init():void {
			super.init();
			for (var i:int = 0; i < 4; i++) {
				var ext:String = i == 3 ? '.jpg' : '.png';
				var img:AOBA_Image = new AOBA_Image("scene_1/" + (i + 1) + ext);
				addChild(img);
				imgs.push(img);
			}
			
			vp_play = new AOBA_VideoPlayer("scene_1/play.flv");
			vp_play.addEventListener(MouseEvent.CLICK, onNext);
			vp_play.title = "vp_play";
			vp_play.auto_loop = true;
			vp_play.auto_play = true;
			vp_play.x = 1760;
			vp_play.y = 486;
			addChild(vp_play);
			
			vp_gene = new AOBA_VideoPlayer("scene_1/glow_gene.flv");
			vp_gene.addEventListener(MouseEvent.CLICK, onPopup);
			vp_gene.draggable = true;
			vp_gene.title = "vp_gene";
			vp_gene.auto_loop = true;
			vp_gene.auto_play = true;
			vp_gene.x = 972;
			vp_gene.y = 476;
			addChild(vp_gene);
			
			vp_popup = new AOBA_VideoPlayer("scene_1/popup.flv");
			vp_popup.onPlayComplete = function(vp:AOBA_VideoPlayer):void { onNext(); }
			vp_popup.title = "vp_popup";
			vp_popup.x = 425;
			addChild(vp_popup);
			
			tweenTimer.addEventListener(TimerEvent.TIMER, onTween);
			tweenTimer.start();
		}	
		public override function show():void {
			vp_gene.visible = false;
			vp_popup.visible = false;
			vp_play.visible = true;
			for (var i:int = 0; i < imgs.length; i++){
				imgs[i].visible = true;
				imgs[i].alpha = 1;
			}
			vp_popup.player.seek(0);
			AOBA_Idler.pause();
			slide_to(1);
			super.show();
		}
		private function slide_to(_index:int):void {
			var i:int;
			index = _index;
			switch(index){
				case 1:
				case 2:
					for ( i = 2; i < imgs.length;i++){
						imgs[i].visible = false;
						imgs[i].alpha = 0;
					}
					imgs[0].visible = true;
					imgs[1].visible = true;
					
					break;
				default:
					for ( i = 0; i < imgs.length;i++){
						Tweener.removeTweens(imgs[i]);
						imgs[i].visible = index == i + 1;
						imgs[i].alpha = 1;
					}
					vp_gene.visible = index == 3;
					break;
			}
		}
		private function onTween(e:TimerEvent):void {
			var a1:int = tweenTimer.currentCount % 2 == 0 ? 0 : 1;
			var a2:int = tweenTimer.currentCount % 2 == 0 ? 1 : 0;
			Tweener.removeTweens(imgs[1]);
			imgs[1].alpha = a1;
			Tweener.addTween(imgs[1], { alpha: a2, time:3});
		}
		private function onPopup(e:MouseEvent):void {
			AOBA_Idler.pause();
			vp_popup.replay();
			vp_popup.alpha = 1;
			vp_popup.visible = true;
		}
		private function onNext(e:Event=null):void {
			index++;
			switch(index){
				case 1:
					AOBA_Idler.pause();
					vp_play.visible = true;
					break;
				case 2:
					AOBA_Idler.reset();
					slide_to(3);
					vp_play.visible = false;
					vp_gene.visible = true;
					break;
				case 3:
					AOBA_Idler.pause();
					break;
				case 4:
					slide_to(4);
					imgs[imgs.length - 1].alpha = 0;
					Tweener.addTween(vp_popup, { time:1, alpha:0 });
					Tweener.addTween(imgs[imgs.length - 1], { time:1, alpha:1, onComplete: onComplete });
					break;
				case 5:
					onNextScene();
					break;
			}
			function onComplete():void {
				vp_play.alpha = 0;
				AOBA_Idler.pause();
				vp_play.visible = true;
				Tweener.addTween(vp_play, { time:1, alpha:1 });
			}
		}
	}
}