package scene.scene2 
{
	import aoba.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class CountdownTimer extends AOBA_Sprite 
	{
		public static var MAX:int = 3;
		private var timer:Timer;
		private var txt:AOBA_TextField;
		private var img_bg:AOBA_Image;
		public var onComplete:Function;
		public function CountdownTimer() 
		{
			super();
						
			img_bg = new AOBA_Image("scene_2/timer.png");
			addChild(img_bg);
			
			txt = new AOBA_TextField;
			var tf:TextFormat = txt.getTextFormat();
			tf.align = TextFormatAlign.CENTER;
			tf.color = 0xFFFFFF;
			tf.size = 72;
			
			txt.y = 66;
			txt.x = 52;
			txt.txt.autoSize = TextFieldAutoSize.NONE;
			txt.setWidth(200);
			txt.setTextFormat(tf);
			addChild(txt);
			
			timer = new Timer(1000, CountdownTimer.MAX);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			timer.start();
		}		
		private function onTimer(e:TimerEvent):void {
			var num:int = CountdownTimer.MAX - timer.currentCount;
			txt.setText(num.toString());
		}
		private function onTimerComplete(e:TimerEvent):void {
			txt.setText("0");
			onComplete();
		}
		public function stopTimer():void {
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
		}
		public function reset():void {
			stopTimer();
			txt.setText(CountdownTimer.MAX.toString());
			timer = new Timer(1000, CountdownTimer.MAX);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			timer.start();
		}
	}
}