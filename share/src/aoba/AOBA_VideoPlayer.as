package aoba
{
	import fl.video.FLVPlayback;
	import fl.video.VideoError;
	import fl.video.VideoEvent;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class AOBA_VideoPlayer extends AOBA_Sprite
	{
		private var _HT:int;
		public var source:String = '';
		private var ready:Boolean = false;
		public var vertical:Boolean = false;
		public var auto_loop:Boolean = false;
		public var auto_play:Boolean = false;
		public var player:FLVPlayback = null;
		
		public var onPlayComplete:Function = new Function;
		public var onLoadComplete:Function = new Function;
		
		private var show_video_msg:Boolean;
		private var seek_to_sec:Number;
		
		public function AOBA_VideoPlayer(_source:String="")
		{
			source = _source;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.load(new URLRequest('swf/FLVPlayBack.swf'));
			addChild(loader);
			function onComplete(evt:Event):void
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
				player = Sprite(loader.content).getChildByName('player') as FLVPlayback;
				init_player();
			}
		}
		
		private function init_player():void
		{
			load();
		}
		
		public override function init():void
		{
			super.init();
			
			show_video_msg = false;
			seek_to_sec = 0;
		}
		
		public function load():void
		{
			if (source == '') return;
			player.addEventListener(VideoEvent.READY, onReady);
			player.addEventListener(IOErrorEvent.IO_ERROR, onError);
			player.addEventListener(VideoEvent.COMPLETE, onVideoPlayComplete);
			player.load(source);
		}
		
		private function onReady(evt:VideoEvent):void
		{
			player.removeEventListener(VideoEvent.READY, onReady);
			if (vertical){
				rotation = 90;
				x = 1080;
			}
			onLoadComplete(this);
			
			ready = true;
			player.x = 0;
			player.y = 0;
			player.autoRewind = auto_loop;
			if (auto_play) replay();
			recycle();
		}
		
		private function onVideoPlayComplete(evt:VideoEvent):void
		{
			// trace('播放完畢 ( ' + player.playheadTime + ' / ' + player.totalTime + ' )\n' + source);
			if ( onPlayComplete != null ) onPlayComplete(this);
			if ( auto_loop ) replay();
		}
		private function onError(e:IOErrorEvent):void {}
		public function replay():void
		{
			player.play();
			// trace('重新播放 ( ' + player.playheadTime + ' / ' + player.totalTime + ' )\n' + source);
		}
		public function play():void {
			replay();
		}
		public function stop():void
		{
			if (!ready) return;
			// trace('停止播放 ' + source);
			player.stop();
		}
	}
}