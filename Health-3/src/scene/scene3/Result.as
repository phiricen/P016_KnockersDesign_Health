package scene.scene3
{
	import aoba.*;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Result extends AOBA_Sprite 
	{
		private var txt:AOBA_TextField;
		private var bg1:Shape = new Shape;
		private var bg2:Shape = new Shape;
		public var img_hint:AOBA_Image;
		public var ib_end:AOBA_ImageButton;
		public function Result(){
			super();
			bg1.graphics.beginFill(0x000000, 0);
			bg1.graphics.drawRect(0, 0, Main.W, Main.H);
			bg2.graphics.beginFill(0x000000, 0.8);
			bg2.graphics.drawRect(0, 0, Main.W, 400);
			addChild(bg1);
			// addChild(bg2);
			bg2.y = ( Main.H - bg2.height) / 2;
		}
		public override function init():void {
			super.init();
			txt = new AOBA_TextField;
			txt.draggable = true;
			txt.x = 478;
			txt.y = 440;
			

			var tf:TextFormat = txt.getTextFormat();
			tf.size = 32;
			tf.leading = 30;
			tf.align = TextFormatAlign.CENTER;
			tf.color = 0xFFFFFF;
			txt.setTextFormat(tf); 
			
			var msg:String = "以移植方式治療糖尿病，所需胰島細胞的來源，除了由";
			msg += "\n幹細胞分化生成外，也可從豬隻取得，植入人體皮下。";
			
			txt.setText(msg);
			txt.draggable = true;
			// addChild(txt);
						
			img_hint = new AOBA_Image("scene_3/end.png", function():void {
				img_hint.x = ( Main.W - img_hint.width) / 2;
				img_hint.y = ( Main.H - img_hint.height) / 2;
			});
			img_hint.draggable = true;
			addChild(img_hint);
			
			ib_end = new AOBA_ImageButton("scene_3/endbtn.png", "scene_3/endbtn_hover.png");
			ib_end.draggable = true;
			ib_end.x = 862;
			ib_end.y = 570;
			addChild(ib_end);
		}
	}

}