package scene
{
	import caurina.transitions.Tweener;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;
	import flash.utils.Timer;
	import aoba.*;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Scene_1 extends Scene 
	{
		private var timer:Timer;
		private var mc_bg:AOBA_Image;
		private var vp_start:AOBA_VideoPlayer;
		private var no:int = 1;
		private var sliders:Array = [];
		public function Scene_1(){}	
		public override function init():void {
			super.init();
			
			img_bg.visible = false;
			
			set_sliders();
			set_start();
		}
		private function set_start():void {
			vp_start = new AOBA_VideoPlayer("flv/play.flv");
			vp_start.auto_loop = true;
			vp_start.x = 1744;
			vp_start.y = 512 ;
			vp_start.addEventListener(MouseEvent.CLICK, onNextScene);
			addChild(vp_start);			
		}
		private function set_sliders():void {
			for (var i:int = 1; i <= 12;i++){
				var img_slide:AOBA_Image = new AOBA_Image();
				addChild(img_slide);
				sliders.push(img_slide);
				img_slide.alpha = i == 1 ? 1 : 0;
				AOBA_Preloader.add(img_slide, "img/slide/slide" + i + ".jpg");
			}
			timer = new Timer(2 * 1000);
			timer.addEventListener(TimerEvent.TIMER, slide);
			timer.start();
		}
		private function slide(e:TimerEvent=null):void{
			var old:AOBA_Image = sliders[no - 1];
			no = no + 1 > 12 ? 1 : no + 1;
			var now:AOBA_Image = sliders[no - 1];
			now.alpha = 0;
			old.alpha = 1;
			Tweener.removeTweens(now, old);
			if ( no == 1 ){
				for (var i:int = 0; i < sliders.length; i++ ){ sliders[i].alpha = 0; }
				Tweener.addTween(now, {alpha:1, time:2});
			}
			else {
				Tweener.addTween(now, {alpha:1, time:2, onComplete: onComplete});
				function onComplete():void {
					for (var i:int = 0; i < sliders.length; i++ ){
						sliders[i].alpha = sliders[i] == now ? now.alpha : 0;
					}
				}
			}
		}
		public function show():void{
			vp_start.play();
			visible = true;
		}
		public function hide():void{
			visible = false;
			vp_start.stop();
			no = 1;
			slide();
		}
	}
}