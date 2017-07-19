package scene
{
	import aoba.*;
	import aoba.AOBA_Scene;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.engine.TextJustifier;
	import scene.scene3.Cell;
	import scene.scene3.Heart;
	import scene.scene3.Ingridient;
	import scene.scene3.Liver;
	import scene.scene3.Result;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Scene_3 extends Scene 
	{
		private var img_cell_t:AOBA_Image;
		private var img_cell_c:AOBA_Image;
		private var img_cell_b:AOBA_Image;
		private var img_liver:AOBA_Image;
		private var img_inject:AOBA_ImageButton;
		private var img_syringes:AOBA_Image;
		private var txt_hint:AOBA_TextField = new AOBA_TextField;
		private var img_heart:Heart;
		private var liver:Liver;
		private var cells:Array = [];
		private var mc_result:Result;
		private var img_hint:AOBA_Image;
		private var spr_ingridients:Sprite;
		public function Scene_3(_onNextScene:Function=null){ super(_onNextScene); }
		public override function init():void{
			
			super.init();
			
			liver = new Liver();
			liver.onFull = onResult;
			liver.x = 568;
			liver.y = 256;
			addChild(liver);
			
			img_syringes = new AOBA_Image("scene_3/syringes.png");
			img_syringes.x = 898;
			img_syringes.y = 120;
			addChild(img_syringes);
						
			img_inject = new AOBA_ImageButton("scene_3/insertbtn.png","scene_3/insertbtn_hover.png");
			img_inject.addEventListener(MouseEvent.CLICK, onShoot);
			img_inject.x = 840;
			img_inject.y = 860;
			addChild(img_inject);
			
			img_cell_t = new Cell("t");
			img_cell_c = new Cell("c");
			img_cell_b = new Cell("b");
			addChild(img_cell_t);
			addChild(img_cell_c);
			addChild(img_cell_b);
			cells = [img_cell_t,img_cell_c,img_cell_b];
			
			img_hint = new AOBA_Image("scene_3/gameintro.png", function():void{
				img_hint.x = ( Main.W - img_hint.width) / 2;
			});
			img_hint.y = 956;
			addChild(img_hint);
			
			var tf:TextFormat = txt_hint.getTextFormat();
			tf.align = TextFormatAlign.CENTER;
			tf.color = 0xFFFFFF;
			tf.leading = 10;
			tf.size = 24;
			txt_hint.setTextFormat(tf);
			
			var msg:String = "請避開免疫細胞的巡邏，按下「注射」";
			msg += "\n將胰島細胞移植至胰臟內";
			txt_hint.draggable = true;
			txt_hint.setText(msg);
			txt_hint.x = 770;
			txt_hint.y = 980;
			// addChild(txt_hint);
			
			img_heart = new Heart;
			img_heart.x = 958;
			img_heart.y = 540;
			addChild(img_heart);
			
			spr_ingridients = new Sprite;
			addChild(spr_ingridients);
			
			mc_result = new Result;
			addChild(mc_result);
			mc_result.ib_end.addEventListener(MouseEvent.CLICK, onEnd);
		}
		private function onEnd(e:MouseEvent):void {
			AOBA_Idler.reset();
			onNextScene();
		}
		private function onShoot(e:MouseEvent):void {
			AOBA_Idler.reset();
			var ing:Ingridient = new Ingridient(img_syringes, img_heart, cells);
			ing.onHit = onHit;
			spr_ingridients.addChild(ing);
		}
		private function onHit():void {
			liver.fill();
		}
		public override function show():void {
			mc_result.visible = false;
			liver.reset();
			super.show();
		}
		private function onResult():void {
			mc_result.visible = true;
			AOBA_Idler.reset();
		}
	}
}