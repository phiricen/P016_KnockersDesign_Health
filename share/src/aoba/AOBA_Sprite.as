package aoba
{
	import caurina.transitions.Tweener;
	import caurina.transitions.TweenListObj;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.net.LocalConnection;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.net.LocalConnection;
	import flash.system.System;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class AOBA_Sprite extends Sprite
	{
		private var transparent:Boolean = false;
		public var draggable:Boolean = false;
		private var mc_move:Sprite;
		protected var THIS:AOBA_Sprite;
		private var ct:ColorTransform;
	
		public var title:String = '-';
		public var clickabled:Boolean = true;
		
		public static var RESET_FOCUS:String = "ResetFocus";
		
		public function AOBA_Sprite(){
			THIS = this;
			
			mc_move = new Sprite;
			mc_move.visible = false;
			addChild(mc_move);
			
			if ( stage !== null ){
				init();
			}
			else {
				addEventListener(Event.ADDED_TO_STAGE, onATS);
				addEventListener(Event.REMOVED_FROM_STAGE, onRFS);
			}
		}
		
		private function onATS(evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onATS);
			if (draggable) set_move();
			init();
		}
		
		private function onRFS(evt:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRFS);
			if (mc_move != null)
			{
				removeChild(mc_move);
				mc_move = null;
			}
			THIS = null;
		}
		
		public function enableDrag():void { set_move(); }
		private function set_move():void
		{
			var block:Shape = new Shape;
			block.graphics.beginFill(0x000000);
			block.graphics.drawRect(0, 0, 150, 150);
			block.graphics.endFill();
			mc_move.addChild(block);
			
			var tf:TextFormat = new TextFormat;
			var txt:TextField = new TextField;
			tf.font = AOBA_TextField.FONT_CH;
			tf.color = 0xFFFFFF;
			tf.size = 36;
			txt.selectable = false;
			txt.defaultTextFormat = tf;
			txt.setTextFormat(tf);
			txt.autoSize = 'left';
			txt.width = 150;
			mc_move.addChild(txt);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, OnToggle);
			mc_move.addEventListener(MouseEvent.MOUSE_DOWN, OnMove);
			
			function OnToggle(evt:KeyboardEvent):void
			{
				if (evt.keyCode == 116){
					refresh();
					mc_move.visible = !mc_move.visible;
					setChildIndex(mc_move, THIS.numChildren - 1);
				}
			}
			function OnMove(evt:MouseEvent):void
			{
				var oX:Number = THIS.x;
				var oY:Number = THIS.y;
				
				stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
				addEventListener(Event.ENTER_FRAME, refresh);
				startDrag();
			}
			function OnMouseUp(evt:MouseEvent):void
			{
				stopDrag();
				removeEventListener(Event.ENTER_FRAME, refresh);
				stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			}
			function refresh(evt:Event = null):void
			{
				var pos:String = '';
				pos += 'X : ' + Math.floor(x) + "\n";
				pos += 'Y : ' + Math.floor(y) + "\n";
				pos += 'D : ' + parent.getChildIndex(THIS) + "\n";
				txt.text = pos;
			}
		}
		
		public function init():void
		{
			ct = this.transform.colorTransform;
			// set_focus_highlight();
		}
		private function set_focus_highlight():void {
			addEventListener(MouseEvent.CLICK, onFocus);
			addEventListener(AOBA_Sprite.RESET_FOCUS, onBlur);
			function onFocus(e:MouseEvent):void {
				trace(e.currentTarget.title);
				dispatchEvent(new Event(AOBA_Sprite.RESET_FOCUS, true));
			}
			function onBlur(e:Event):void {
			}
		}
		public function clickable():void{
			if (!clickabled){
				this.transform.colorTransform = ct;
				clickabled = true;	
			}
		}
		public function unclickable():void{
			this.transform.colorTransform = new ColorTransform(0.2, 0.2, 0.2, 0, 0, 0, 0,0.5);
			clickabled = false;
		}
		public function recycle():void
		{
			try
			{
				new LocalConnection().connect("foo");
				new LocalConnection().connect("foo");
			}
			catch (error:Error)
			{
			}
			System.gc();
		}
	}
}