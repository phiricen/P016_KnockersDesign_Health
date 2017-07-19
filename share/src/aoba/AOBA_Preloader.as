package aoba
{
	import flash.desktop.NotificationType;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class AOBA_Preloader extends AOBA_Sprite
	{
		public static var DONE:Boolean = false;
		public var delay:int = 1;
		public static var self:AOBA_Preloader;
		private var list:Array = new Array;
		
		private var bar_back:Shape;
		private var bar_front:Shape;
		private var bar:AOBA_Sprite;
		
		private var txt_progress:AOBA_TextField;
		private var txt_source:AOBA_TextField;
		private var enable:Boolean;
		private var now:int = 0;
		
		private var bg:Shape = new Shape;
		
		private var mc_logo:AOBA_Image;
		
		
		public var w:int = 1920;
		public var h:int = 1080;
		
		private var onPreloadComplete:Function;
		
		public function AOBA_Preloader(_w:int,　_h:int,　_onPreloadComplete:Function = null )
		{
			AOBA_Preloader.self = this;
			title = "Preloader";
			enable = true;
			w = _w;
			h = _h;
			
			bg = new Shape;
			bar = new AOBA_Sprite;
			bar_back = new Shape;
			bar_front = new Shape;
			txt_source = new AOBA_TextField;
			txt_progress = new AOBA_TextField;
			onPreloadComplete = _onPreloadComplete;
		}
		
		public override function init():void
		{
			super.init();
			txt_source.visible = true;
			set_ui();
			if (enable)
				recall();
		}
		
		private function set_ui():void
		{
			var sW:int = stage.stageWidth;
			var sH:int = stage.stageHeight;
			var tf:TextFormat = new TextFormat;
			tf.font = AOBA_TextField.FONT_CH;
			tf.align = 'center';
			tf.color = 0xDDDDDD;
			tf.size = 32;
			
			// 縮小至中央
			var scale_to_center:Number = 0.6;
			
			// Background
			bg.graphics.beginFill(0x000000);
			bg.graphics.drawRect(0, 0, w, h);
			bg.graphics.endFill();
			addChild(bg);
			
			// Bar_back
			bar_back.graphics.beginFill(0xDDDDDD);
			bar_back.graphics.drawRect(0, 0, w * scale_to_center, 10);
			bar_back.graphics.endFill();
			
			// Bar_front
			bar_front.graphics.beginFill(0x16897D);
			bar_front.graphics.drawRect(0, 0, w * scale_to_center, 10);
			bar_front.graphics.endFill();
			bar_front.scaleX = 0;
			
			bar.addChild(bar_back);
			bar.addChild(bar_front);
			bar.x = bg.x + (bg.width - bar_back.width) / 2
			bar.y = (sH - bar.height) / 2;
			addChild(bar);
			
			// txt_progress
			txt_progress.txt.defaultTextFormat = tf;
			txt_progress.txt.width = bar.width;
			txt_progress.txt.autoSize = "center";
			txt_progress.txt.border = true;
			txt_progress.x = bar.x;
			txt_progress.y = bar.y - txt_progress.height + 50;
			addChild(txt_progress);
			
			// txt_source
			txt_source.txt.defaultTextFormat = tf;
			txt_source.txt.width = bar.width;
			txt_source.txt.autoSize = "center";
			txt_source.txt.border = true;
			txt_source.x = bar.x;
			txt_source.y = bar.y + bar.height + 20;
			// addChild(txt_source);
		}
		
		private function recall():void
		{
			var remain:int = delay * 30;
			this.addEventListener(Event.ENTER_FRAME, OnEnterFrame);
			function OnEnterFrame(evt:Event):void
			{
				remain--;
				if (remain == 0)
				{
					THIS.removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
					start_queue();
				}
			}
			function reset_frames():void
			{
				remain = delay * 30;
			}
		}
		
		private function start_queue():void
		{
			now = 0;
			queue();
		}
		
		private function queue():void
		{
			now++;
			if ( now > list.length ) {
				trace('全數載入完成');
				visible = false; 
				AOBA_Preloader.DONE = true;
				if ( onPreloadComplete != null ) onPreloadComplete();
			}
			else {
				// trace('載入進度 : ' + now + '/' + list.length);
				bar_front.scaleX = now / list.length;
				load(list[now - 1]);
			}
		}
				
		public function load(p:Object):void
		{
			// trace('【開始載入】' + p.src,p.target);
			txt_source.txt.text = p.src;
			txt_progress.txt.text = Math.floor(now / list.length * 100) + ' %';
			var loader:Loader;
			if (p.target is Loader)
			{
				loader = p.target;
			}
			else if ( p.target is AOBA_Image ){
				loader = p.target.loader;
			}
			else {
				// trace('【物件無效】' + p.src);
				queue();
				return;
			}
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, OnIOError);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnComplete);
			loader.load(new URLRequest(p.src));
			function OnIOError(evt:IOErrorEvent):void {
				loader.removeEventListener(IOErrorEvent.IO_ERROR, OnIOError);
				loader.removeEventListener(Event.COMPLETE, OnComplete);
				trace('【查無檔案】' + p.src);
				queue();
			}
			function OnComplete(evt:Event):void {
				loader.removeEventListener(IOErrorEvent.IO_ERROR, OnIOError);
				loader.removeEventListener(Event.COMPLETE, OnComplete);
				// trace('【載入完成】' + p.src);
				queue();
			}
		}
		
		public static function add(_target:*, _src:String):void
		{
			var PL:AOBA_Preloader = AOBA_Preloader.self as AOBA_Preloader;
			var obj:Object = {target: _target, src: _src};
			if (PL.enable){
				PL.list.push(obj);
			}
			else {
				PL.load(obj);
			}
		}
	}
}