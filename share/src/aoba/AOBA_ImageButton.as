package aoba
{	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	/**
	 * ...
	 * @author Phiricen
	 */
	public class AOBA_ImageButton extends AOBA_Sprite 
	{		
		private var count: int = 0;
		private var src_idle:String;
		private var src_hover:String;
		private var img_idle:AOBA_Image;
		private var img_hover:AOBA_Image;
		public var onLoadComplete:Function;
		public function AOBA_ImageButton(_idle:String,_hover:String) 
		{
			src_idle = _idle;
			src_hover = _hover;
			super();
		}
		public override function init():void {
			img_idle = new AOBA_Image(src_idle, onComplete);
			img_hover = new AOBA_Image(src_hover, onComplete);
			addChild(img_idle);
			addChild(img_hover);
			img_hover.visible = false;
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		}
		private function onComplete(e:AOBA_Image):void {
			count++;
			if ( count == 2 && onLoadComplete != null ){
				onLoadComplete();
			}
		}
		private function onMouseOver(e:MouseEvent):void {
			Mouse.cursor = MouseCursor.BUTTON;
			focus();
		}
		private function onMouseOut(e:MouseEvent): void {
			Mouse.cursor = MouseCursor.AUTO;
			blur();			
		}
		public function focus():void {
			img_idle.visible = false;
			img_hover.visible = true;
		}
		public function blur():void {
			img_idle.visible = true;
			img_hover.visible = false;
		}
	}
}