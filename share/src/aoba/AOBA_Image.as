package aoba
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class AOBA_Image extends AOBA_Sprite
	{
		public var src:String = "";
		public var loader:Loader = new Loader;
		public var onLoadComplete:Function;
		
		public function AOBA_Image(_src:String="", _onComplete:Function=null):void {
			src = _src;
			addChild(loader);
			if (_onComplete != null){
				onLoadComplete = _onComplete;
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			}
			if ( src == "" ) return;
			if (AOBA_Preloader.DONE){
				loader.load(new URLRequest(_src));
			}
			else {
				addEventListener(Event.ADDED_TO_STAGE, onATS);
			} 
		}
		private function onATS(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onATS);
			AOBA_Preloader.add(this, src);
		}
		private function onComplete(e:Event):void {
			if ( onLoadComplete != null ){
				onLoadComplete(this);
			}
		}
	}
}