package scene.scene3
{
	import aoba.*;
	import caurina.transitions.Tweener;
	import flash.display.Shape;
	import flash.events.Event;
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Heart extends AOBA_Sprite
	{
		public var core:Shape;
		private var img_1:AOBA_Image;
		private var img_2:AOBA_Image;
		private var speed:int = 2;
		public function Heart() {}
		public override function init():void {
			img_1 = new AOBA_Image("scene_3/circle.png", onComplete);
			img_2 = new AOBA_Image("scene_3/circle_spin.png", onComplete);
			addChild(img_1);
			addChild(img_2);
			super.init();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			core = new Shape;
			core.graphics.beginFill(0xFF0000, 0.5);
			core.graphics.drawCircle(0, 0, 1);
			addChild(core);
		}
		private function onEnterFrame(e:Event):void {
			rotation += speed;
			rotation = rotation > 360 ? rotation - 360 : rotation;
		}
		private function onComplete(i:AOBA_Image):void {
			i.x = i.width / -2;
			i.y = i.height / -2;
		}
	}

}