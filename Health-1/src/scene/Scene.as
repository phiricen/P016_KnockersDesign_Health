package scene
{
	import aoba.*;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Scene extends AOBA_Sprite 
	{
		public var str_hint:String="";
		public var onNextScene:Function;
		public var txt_hint:AOBA_TextField;
		public var img_bg:AOBA_Image;
		public function Scene(){ super(); }
		
		public override function init():void {
			img_bg = new AOBA_Image("img/background.jpg");
			addChild(img_bg); 
			
			txt_hint = new AOBA_TextField();
			var tf:TextFormat = txt_hint.txt.defaultTextFormat;
			tf.color = 0xFFFFFF;
			tf.size = 48;
			txt_hint.setWidth(1920);
			txt_hint.setTextFormat(tf);
			addChild(txt_hint);
		}
		public function setHint(_str:String):void {
			txt_hint.setText(_str);
		}
	}

}