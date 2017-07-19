package scene.scene3
{
	import aoba.AOBA_Image;
	import aoba.AOBA_Sprite;
	import caurina.transitions.Tweener;
	import flash.display.Shader;
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Liver extends AOBA_Sprite 
	{
		private var level:int = 0;
		private var liver_1:AOBA_Image;
		private var liver_2:AOBA_Image;
		private var msk:Shape = new Shape;
		public var onFull:Function;
		public function Liver() 
		{
			super();			
		}
		public function reset():void {
			level = -1;
			msk.scaleY = 1;
			fill();
		}
		public override function init():void {
			liver_1 = new AOBA_Image("scene_3/good.png");
			liver_2 = new AOBA_Image("scene_3/bad.png", onComplete);
			liver_2.mask = msk;
			addChild(liver_1);
			addChild(liver_2);
		}		
		private function onComplete(i:AOBA_Image):void {
			msk.graphics.beginFill(0xFF0000, 0.5);
			msk.graphics.drawRect(0, 0, i.width, i.height);
			addChild(msk);
		}
		public function fill():void {
			level++;
			var sy:Number;
			switch(level){
				case 0:
					sy = 1;
					break;
				case 1:
					sy = 0.6;
					break;
				case 2:
					sy = 0.4;
					break;
				case 3:
					sy = 0;
					onFull();
					break;
			}
			Tweener.addTween(msk, {time:1, scaleY:sy});
		}
	}
}