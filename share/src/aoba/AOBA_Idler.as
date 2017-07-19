package aoba
{	
	import caurina.transitions.Tweener;
	import flash.display.Shape;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Phiricen
	 */
	public class AOBA_Idler extends AOBA_Sprite 
	{
		private var now:int;
		public var max:int = 15;
		public var hint:int = 10;
		private var timer:Timer;
		private var mask:Shape;
		public var onZero:Function;
		public static var body:AOBA_Idler;
		private var bg:Shape = new Shape;
		private var mc_timer:AOBA_Sprite;
		private var txt_time:AOBA_TextField;
		private var img_continue:AOBA_Image;
		private static const IDLE:String  = " 待機";
		private static const HINT:String  = " 提示";
		private static const PAUSE:String = " 暫停";
		public function AOBA_Idler(_max:int = 0, _hint:int = 0){
			max = _max == 0 ? max : _max;
			hint = _hint == 0 ? hint : _hint;
			AOBA_Idler.body = this;
			visible = false;
			now = max;
		}
		public override function init():void {
			super.init();
			
			mc_timer = new AOBA_Sprite;
			addChild(mc_timer);
			
			bg.graphics.beginFill(0xFFFF00, 0);
			bg.graphics.drawRect(0, 0, AOBA_Main.WIDTH, AOBA_Main.HEIGHT);
			bg.graphics.endFill();
			mc_timer.addChild(bg);
			
			img_continue = new AOBA_Image("img/timeout.png", function():void {
				img_continue.y = ( AOBA_Main.HEIGHT - img_continue.height ) / 2;
			});
			addEventListener(MouseEvent.CLICK, onContinue);
			addChild(img_continue);
			
			txt_time = new AOBA_TextField();
			txt_time.visible = false;
			var tf:TextFormat = txt_time.txt.defaultTextFormat;
			tf.align = "center";
			tf.color = 0xFFFFFF;
			tf.size = 72;
			txt_time.setText(AOBA_Idler.IDLE);
			txt_time.setWidth(AOBA_Main.WIDTH);
			txt_time.setTextFormat(tf);
			mc_timer.addChild(txt_time);
			
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyDown);
		}
		private function onKeyDown(e:KeyboardEvent):void {
			switch(e.keyCode){
				case 120:
					alpha = 1;
					visible = !visible;
					txt_time.visible = visible;
					break;
			}
		}
		private function onTimer(e:TimerEvent):void {
			now--;
			if ( now <= 0 ){
				doIdle();
			}
			else if ( now == hint ){
				doHint();
			}
			else {
				doTimePassed();
			}
		}
		public function pause():void {
			txt_time.setText ( AOBA_Idler.PAUSE );
			timer.stop();
		}
		public function reset():void {
			now = max;
			doTimePassed();
			if ( timer.running ) return;
			timer.start();
		}
		public static function start():void {
			var i:AOBA_Idler = AOBA_Idler.body;
			i.parent.setChildIndex(i, i.parent.numChildren - 1);
		} 
		public static function reset():void { AOBA_Idler.body.reset(); } 
		public static function pause():void { AOBA_Idler.body.pause(); } 
		
		private function doTimePassed(_text:String=""):void {
			txt_time.setText(now+_text);
		}
		private function doIdle():void {
			doTimePassed(AOBA_Idler.IDLE);
			visible = false;
			alpha = 1;
			onZero();
			pause();
		}
		private function doHint():void {
			alpha = 0;
			visible = true;
			Tweener.removeTweens(this);
			Tweener.addTween(this, { time : 1, alpha : 1 });
			doTimePassed(AOBA_Idler.HINT);
		}
		private function onContinue(e:MouseEvent):void {
			alpha = 1;
			Tweener.removeTweens(this);
			Tweener.addTween(this, { time : 1, alpha : 0, onComplete : onComplete });
			function onComplete():void {
				visible = false;
				reset();
			}
		}
	}
}