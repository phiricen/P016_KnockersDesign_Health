package scene 
{
	import aoba.*;
	import caurina.transitions.Tweener;
	import flash.events.MouseEvent;
	import flash.system.ImageDecodingPolicy;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Scene_1 extends Scene
	{
		private var index:int = 1;
		private var imgs:Array = [];
		private var ib_start:AOBA_ImageButton;
		public function Scene_1(_onNextScene:Function = null):void { super(_onNextScene); }
		public override function show():void {
			super.show();
			AOBA_Idler.pause();
		}
		public override function init():void {
			
			var img:AOBA_Image = new AOBA_Image("scene_1/image.jpg");
			img.x = (1920 - 1080) / 2;
			addChild(img);
			
			super.init();
			
			ib_start = new AOBA_ImageButton("scene_1/btn.png", "scene_1/btn_hover.png");
			ib_start.addEventListener(MouseEvent.CLICK, onNextScene);
			ib_start.x = 843;
			ib_start.y = 830;
			addChild(ib_start);
			
			var title_1:AOBA_Image = new AOBA_Image("scene_1/title1.png");
			title_1.x = 635;
			title_1.y = 105;
			addChild(title_1);
			
			var title_2:AOBA_Image = new AOBA_Image("scene_1/title2.png");
			title_2.x = 670;
			title_2.y = 460;
			addChild(title_2);
			
			var title_3:AOBA_Image = new AOBA_Image("scene_1/intro.png");
			title_3.x = 700;
			title_3.y = 950;
			addChild(title_3);
		}	
	}
}