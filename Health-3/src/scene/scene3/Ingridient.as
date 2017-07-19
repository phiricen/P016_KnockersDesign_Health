package scene.scene3
{
	import aoba.*;
	import caurina.transitions.Tweener;
	import flash.events.Event;
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Ingridient extends AOBA_Sprite
	{
		private var cells:Array;
		private var img_heart:Heart;
		public var onHit:Function;
		public function Ingridient(_syringes:AOBA_Image, _heart:Heart, _cells:Array){
			cells = _cells;
			img_heart = _heart;
			x = _syringes.x + 21;
			y = _syringes.y + _syringes.height;
		}
		public override function init():void {
			var img:AOBA_Image = new AOBA_Image("scene_3/ingridient.png");
			addChild(img);
			addEventListener(Event.ENTER_FRAME, onRun);
		}
		private function onRun(e:Event):void {
			y += 10;
			
			for (var i:int = 0; i < cells.length;i++){
				if ( hitTestObject(cells[i].core)){
					removeEventListener(Event.ENTER_FRAME, onRun);
					Tweener.addTween(this, {
						time : 1,
						alpha : 0,						
						onComplete:destroy
					});
				}
			}
			if ( hitTestObject(img_heart.core)){
				removeEventListener(Event.ENTER_FRAME, onRun);
				Tweener.addTween(this, {
					time : 1,
					alpha : 0,						
					onComplete: destroy
				});
				onHit();
			}
		}
		public function destroy():void {
			removeEventListener(Event.ENTER_FRAME, onRun);
			Tweener.removeTweens(this);
			parent.removeChild(this);
		}
	}
}