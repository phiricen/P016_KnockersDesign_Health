package scene
{
	import aoba.*;
	import caurina.transitions.Tweener;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.IMEEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Scene_2 extends Scene 
	{	
		private var img_liver:AOBA_Image;
		private var img_inject:AOBA_Image;
		private var img_hint:AOBA_Image;
		private var txt_hint:AOBA_TextField;
		private var ib_start:AOBA_ImageButton;
		public function Scene_2(_onNextScene:Function = null):void { super(_onNextScene); }	
		public override function init():void {
			super.init();
			var msg:String = "胰島細胞可藉由注射方式，經由肝門靜脈，移植到患者胰臟內。";
			msg+="\n移植後，必須保護新細胞不會被免疫系統排斥。";
			txt_hint = new AOBA_TextField;
			txt_hint.x = 532;
			txt_hint.y = 496;
			txt_hint.setText(msg);
			// addChild(txt_hint);
			
			var tf:TextFormat = txt_hint.getTextFormat();
			tf.size = 32;
			tf.leading = 30;
			tf.align = TextFormatAlign.CENTER;
			tf.color = 0xFFFFFF;
			txt_hint.setTextFormat(tf); 
			
			img_hint = new AOBA_Image("scene_2/intro1.png", function():void{
				img_hint.x = ( Main.W - img_hint.width) / 2;
			});
			img_hint.draggable = true;
			img_hint.y = 490;
			addChild(img_hint);
			
			ib_start = new AOBA_ImageButton("scene_1/btn.png", "scene_1/btn_hover.png");
			ib_start.addEventListener(MouseEvent.CLICK, onNextScene);
			ib_start.x = 843;
			ib_start.y = 797;
			addChild(ib_start);
		}
		public override function show():void {
			super.show();
			AOBA_Idler.reset();
		}
	}
}