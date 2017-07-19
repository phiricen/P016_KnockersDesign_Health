package scene.scene3 
{
	import aoba.*;
	import caurina.transitions.Tweener;
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Cell extends AOBA_Image 
	{
		private var x1:int;
		private var x2:int;
		private var y1:int;
		private var y2:int;
		private var speed:int;
		public var core:Shape;
		private var reversing:Boolean = false;
		public var type:String;
		public function Cell(_type:String=""){
			super("scene_3/" + _type+".png");
			type = _type;
						
			core = new Shape();
			core.graphics.beginFill(0xFF0000, 0);
			core.graphics.drawCircle(0, 0, 20);
			core.graphics.endFill();
			addChild(core);
			
			x1 = 714;
			y1 = 426;
			x2 = 1298;
			y2 = 390;
			core.x = 30;
			core.y = 70;
			switch(type){
				case "t":
					speed = 5;
					break;
				case "c":
					speed = 7;
					break;
				case "b":
					speed = 9;
					break;
			}
			x = x1;
			y = y1;
		}
		public override function init():void {
			super.init();
			run();
		}
		private function run():void {
			var param:Object = { time: speed, transition:"linear", onComplete: onTweenComplete };
			param.x = reversing ? x2 : x1;
			param.y = reversing ? y2 : y1;
			Tweener.addTween(this, param);
		}
		private function onTweenComplete():void {
			reversing = !reversing;
			run();
		}
	}

}