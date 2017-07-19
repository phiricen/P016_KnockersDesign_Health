package aoba
{
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class AOBA_TextField extends AOBA_Sprite
	{
		/*
		[Embed(source="../../font/HEI00MP.ttf", 
                fontName = "myFont", 
                mimeType = "application/x-font", 
                fontWeight="normal", 
                fontStyle="normal", 
                advancedAntiAliasing="true", 
                embedAsCFF = "false")
		]
        private var myEmbeddedFont:Class;
		*/
		public static var FONT_CH:String = "文鼎新粗黑";
		
		public var txt:TextField;
		
		
		public function AOBA_TextField()
		{
			txt = new TextField;
			txt.autoSize = "left";
			txt.selectable = false;
			addChild(txt);
			
			var tf:TextFormat = txt.defaultTextFormat;
			tf.align = TextFormatAlign.CENTER;
			tf.font = AOBA_TextField.FONT_CH;
			
			txt.defaultTextFormat = tf;
		}
		public function addTextShadow(angle:int = 45):void
		{
			var filter:DropShadowFilter = new DropShadowFilter(3, angle, 0x0, 0.5);
			var filters:Array = txt.filters;
			filters.push(filter);
			txt.filters = filters;
		}
		public function setText(_str:String=null):void{
			if (_str == null) return;
			txt.text = _str;
		}
		public function setTextFormat(_tf:TextFormat=null):void{
			if (_tf == null) return;
			txt.defaultTextFormat = _tf;
			txt.setTextFormat(_tf);
		}
		public function setWidth(_width:int=300):void{
			if (_width == 0) return;
			txt.width = _width;
		}
		public function getTextFormat():TextFormat {
			return txt.defaultTextFormat;
		}
	}
}