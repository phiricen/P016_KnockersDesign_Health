package scene
{
	import aoba.*;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import caurina.transitions.Tweener;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Scene_6 extends Scene 
	{
		private var msgs:Array=[];
		private var txt_msg:AOBA_TextField = new AOBA_TextField;
		private var img_again:AOBA_ImageButton;
		public function Scene_6() {}
		public override function init():void {
			super.init();
			
			for (var i:int = 0; i < 4;i++ ){
				var img_info:AOBA_Image = new AOBA_Image("img/info_0" + (i + 1) + ".png");
				img_info.draggable = true;
				switch(i){
					case 0:
						img_info.x = 840;
						img_info.y = 140;
						break;
					case 1:
						img_info.x = 840;
						img_info.y = 317;
						break;
					case 2:
						img_info.x = 840;
						img_info.y = 476;
						break;
					case 3:
						img_info.x = 840;
						img_info.y = 643;
						break;
				}
				msgs.push(img_info);
				addChild(img_info);
			}
			
			img_again = new AOBA_ImageButton("img/end-btn.png", "img/end-btn-hover.png");
			img_again.x = 1640;
			img_again.y = 842;
			addChild(img_again);
			img_again.addEventListener(MouseEvent.CLICK, onNextScene);		
		}
		public function show():void {
			do_fadeIn();
			visible = true;
		}
		public function hide():void {
			visible = false;
			for (var i:int = 0; i <= msgs.length; i++) {
				Tweener.removeTweens(msgs[i]);
			}
		}
		private function do_fadeIn():void {
			var now:int = -1;
			var items:Array = [];
			for (var i:int = 0; i < msgs.length; i++) { msgs[i].alpha = 0; }
			img_again.alpha = 0;
			next();
			function next():void {
				now++;
				switch(now) {
					case 0:
					case 1:
					case 2:
					case 3:
						msgs[now].alpha = 0;
						Tweener.addTween(msgs[now], { alpha:1, time:3, transition:"linear", onComplete:next } );
						break;
					case 4:
						img_again.alpha = 0;
						Tweener.addTween(img_again, { alpha:1, time:1, transition:"linear", onComplete:next } );
						break;
					case 5:
						AOBA_Idler.reset();
						break;
				}
			}
		}
	}
}