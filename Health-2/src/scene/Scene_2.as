package scene
{
	import aoba.*;
	import caurina.transitions.Tweener;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.IMEEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import scene.scene2.CountdownTimer;
	import scene.scene2.Nucleotides;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Scene_2 extends AOBA_Scene 
	{	
		private var numPicked:int = 3;
		private var numTarget:int = 3;
		private var ct:CountdownTimer;
		private var isEnd:Boolean = false;
		private var back:Shape = new Shape;
		private var newNucFreq:int = 300;
		public static const R:int = 215;
		public var amount:int = 0;
		public var nucls:Array = [];
		public var mc_top:AOBA_Sprite= new AOBA_Sprite;
		public var mc_bottom:AOBA_Sprite= new AOBA_Sprite;
		public var mc_magnifier:AOBA_Sprite;
		private var img_hint:AOBA_Image;
		private var img_magnifier:AOBA_Image;
		private var img_result:AOBA_Image;
		private var txt_hint:AOBA_TextField;
		public var backToIndex:Function;
		public function Scene_2(_onNextScene:Function = null):void { super(_onNextScene); }	
		public override function init():void {
			
			mc_bottom.y = AOBA_Main.HEIGHT / 2 + 80;
			addChild(mc_bottom);
			
			addChild(back);
			
			set_magnify();
			
			mc_top.y = AOBA_Main.HEIGHT / 2 + 80;
			mc_top.x = -15;
			addChild(mc_top);
			
			var timer:Timer = new Timer(newNucFreq);
			timer.addEventListener(TimerEvent.TIMER, onSchedule);
			timer.start();
			
			set_countdown_timer();
			set_result();
			
			img_hint = new AOBA_Image("scene_2/hint.png");
			img_hint.x = 46;
			img_hint.y = 62;
			img_hint.draggable = true;
			addChild(img_hint);
			/*
			txt_hint = new AOBA_TextField;
			txt_hint.setText("請試試你的眼力，看是否能找到基因序列的差異。");
			txt_hint.draggable = true;
			txt_hint.x = 50;
			txt_hint.y = 90;
			addChild(txt_hint);
			var tf:TextFormat = txt_hint.getTextFormat();
			tf.color = 0xFFFFFF;
			tf.size = 48;
			txt_hint.setTextFormat(tf);
			*/
		}
		private function onSchedule(e:TimerEvent):void { 
			newNucleotides();
		}
		public override function show():void {
			img_result.visible = false;
			AOBA_Idler.pause();
			isEnd = false;
			numPicked = 0;
			super.show();
			ct.reset();
		}
		public override function hide():void {
			super.hide();
			ct.stopTimer();
		}
		private function set_countdown_timer():void {
			ct = new CountdownTimer();
			ct.onComplete = function():void {
				ct.stopTimer();
				doEnd();
			}
			ct.x = 1610;
			ct.y = 12;
			addChild(ct);
		}
		private function set_result():void {
			img_result = new AOBA_Image("scene_2/end-text.png");
			img_result.visible = false;
			img_result.y = 280;
			addChild(img_result);
			
			var img_close:AOBA_ImageButton = new AOBA_ImageButton(
				"scene_2/end-btn.png",
				"scene_2/end-btn-hover.png"
			);
			img_close.x = 870;
			img_close.y = 336;
			img_result.addChild(img_close);
			img_close.addEventListener(MouseEvent.CLICK, onNextScene);
		}
		private function set_magnify():void {
			mc_magnifier = new AOBA_Sprite;
			mc_magnifier.x = 1000;
			mc_magnifier.y = 610;
			addChild(mc_magnifier);
			
			img_magnifier = new AOBA_Image("scene_2/magnify_glass.png");
			img_magnifier.draggable = true;
			img_magnifier.x = -818;
			img_magnifier.y = -352;
			mc_magnifier.addChild(img_magnifier);
			
			back.x = mc_magnifier.x;
			back.y = mc_magnifier.y;
			back.graphics.beginFill(0x0A0A0C, 1);
			back.graphics.drawCircle(0, 0, Scene_2.R);
			back.graphics.endFill();
			
			var circle:Shape = new Shape;
			circle.x = mc_magnifier.x;
			circle.y = mc_magnifier.y;
			circle.graphics.copyFrom(back.graphics);
			addChild(circle);
			
			mc_top.mask = circle;
		}
		public function newNucleotides():void {
			amount++;
			var n:Nucleotides = new Nucleotides(amount, this);
			nucls.push(n);
			n.onSelected = function():void {
				numPicked++;
				if ( numPicked == numTarget ){
					ct.stopTimer();
					doEnd();
				}
			};
		}
		private function doEnd():void {
			if (!isEnd){
				img_result.visible = true;
				AOBA_Idler.reset();
				isEnd = true;
			}
		}
	}
}