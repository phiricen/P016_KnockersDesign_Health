package aoba
{
	import aoba.main.NativeWindowResizer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.system.Capabilities;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class AOBA_Main extends AOBA_Sprite 
	{
		private var winSizes:Array;
		private var winSizesMH:int = 0;
		private var shape_mask:Shape;
		private var ready_count:int = 3;
		public static var WIDTH:int = 1920;
		public static var HEIGHT:int = 1080;
		protected var preloader:AOBA_Preloader;
		protected var mc_idler:AOBA_Idler;
		public function AOBA_Main(p:Object=null){
			super();
			if ( p != null ){
				AOBA_Main.WIDTH  = p.w == undefined ? AOBA_Main.WIDTH  : p.w;
				AOBA_Main.HEIGHT = p.h == undefined ? AOBA_Main.HEIGHT : p.h;
			}
			winSizes = [
				{ name: "HD"    , w : 1920 , h : 1080 },
				{ name: "HD720" , w : 1280 , h :  720 },
				{ name: "WVGA"  , w :  854 , h :  480 }
			];
			set_bg();
			set_preloader();
			set_idler();
			set_mask();
			set_func_keys();
		}
		protected function onIdlerZero():void {}
		protected function onStageReady():void {}
		private function ready_check():void {
			ready_count--;
			if (ready_count == 0){
				onStageReady();
			}
		}
		private function set_bg():void{
			var bg:Shape = new Shape;
			bg.graphics.beginFill(0x0A0A0C);
			bg.graphics.drawRect(0, 0, AOBA_Main.WIDTH, AOBA_Main.HEIGHT);
			bg.graphics.endFill();
			addChild(bg);
		}
		private function set_preloader():void {
			preloader = new AOBA_Preloader( AOBA_Main.WIDTH, AOBA_Main.HEIGHT, ready_check);
			addChild(preloader);
		}
		private function set_idler():void {
			mc_idler = new AOBA_Idler(60,10);
			mc_idler.onZero = onIdlerZero;
			addChild(mc_idler);
			ready_check();
		}
		private function set_mask():void {
			shape_mask = new Shape;
			shape_mask.graphics.beginFill(0x000000);
			shape_mask.graphics.drawRect(0, 0, AOBA_Main.WIDTH, AOBA_Main.HEIGHT);
			addChild(shape_mask);
			mask = shape_mask;
			ready_check();
		}
		private function set_func_keys():void {
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			function onKeyUp(e:KeyboardEvent):void {
				switch(e.keyCode){
					case 114:
						winSizesMH = winSizesMH + 1 == winSizes.length ? 0 : winSizesMH + 1;
						switch ( Capabilities.playerType ){
							case "Desktop": // Adobe AIR
								new NativeWindowResizer(stage, winSizes[winSizesMH]);
								break;
							case "StandAlone": // Adobe Flash Player
							case "ActiveX":
							case "PlugIn": // Browser
							case "External":
								break;
						}
						break;
				}
			}
		}
		protected function raise_mask():void {
			setChildIndex(shape_mask, numChildren-1);
		}
	}
}