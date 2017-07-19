package scene.scene4
{
	import aoba.*;
	import caurina.transitions.Tweener;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import scene.Scene_4;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Message extends AOBA_Sprite 
	{
		private var msg:String;
		public var txt_msg:AOBA_TextField;
		private var img_bg:AOBA_Image;
		public var img_close:AOBA_Image;	
		public var onFadeOuted:Function;	
		public function Message(_msg:String="") {
			msg = _msg;
			visible = false;
		}
		public function say(_str:String=""):void {
			txt_msg.setText(_str);
			alpha = 0;
			visible = true;
			Tweener.removeTweens(this);
			Tweener.addTween(this, {time:1, alpha: 1});
		}
		private function onClose(e:MouseEvent):void {
			AOBA_Idler.reset();
			Tweener.removeTweens(this);
			Tweener.addTween(this, {time:0.5, alpha: 0, onComplete: onComplete});
			function onComplete():void {
				Scene_4.isInjecting = false;
				visible = false;
				onFadeOuted();
			}
		}
		public override function init():void {
			super.init();
			img_bg = new AOBA_Image("img/message.png");
			addChild(img_bg);
			
			txt_msg = new AOBA_TextField();
			txt_msg.txt.wordWrap = true;
			var tf:TextFormat = txt_msg.txt.defaultTextFormat;
			tf.color = 0xFFFFFF;
			tf.align = TextFormatAlign.LEFT;
			tf.leading = 10;
			tf.size = 28;
			txt_msg.x = 180;
			txt_msg.y = 60;
			txt_msg.setWidth(1920);
			txt_msg.setTextFormat(tf);
			txt_msg.setText(msg);
			addChild(txt_msg);
			
			img_close = new AOBA_Image("img/close.png");
			img_close.x = 964;
			img_close.y = 34;
			img_close.addEventListener(MouseEvent.CLICK, onClose);
			addChild(img_close);
		}		
	}
}