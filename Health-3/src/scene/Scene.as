package scene 
{
	import aoba.*;
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Scene extends AOBA_Scene
	{
		private var circle:Shape = new Shape;
		public function Scene(p:Object=null) 
		{
			super(p);
		}
		public override function init():void {
			circle.y = 540;
			circle.x = 960;
			circle.graphics.lineStyle(1, 0xFFFFFF);
			circle.graphics.drawCircle(0, 0, 540);
			addChild(circle);
			super.init();	
		}
	}
}