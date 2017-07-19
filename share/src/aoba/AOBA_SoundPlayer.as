package aoba
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class AOBA_SoundPlayer extends Sprite
	{
		public static var body:AOBA_SoundPlayer;
		private var SE_sc:SoundChannel = new SoundChannel;
		private var BGM_sc:SoundChannel = new SoundChannel;
		private var bgm:Sound;
		
		public function AOBA_SoundPlayer()
		{
			AOBA_SoundPlayer.body = this;
		}
		
		public function setBGM(_volume:Number):void
		{
			BGM_sc.addEventListener(Event.SOUND_COMPLETE, onPlayed);
			
			bgm = new Sound();
			bgm.load(new URLRequest("sound/BGM.mp3"));
			bgm.addEventListener(Event.COMPLETE, onLoaded);
			
			function onLoaded(e:Event):void
			{
				bgm.removeEventListener(Event.COMPLETE, onLoaded);
				BGM_sc = bgm.play();
				BGM_sc.soundTransform = new SoundTransform(_volume);
				BGM_sc.addEventListener(Event.SOUND_COMPLETE, onPlayed);
			}
			function onPlayed(e:Event):void
			{
				BGM_sc.removeEventListener(Event.SOUND_COMPLETE, onPlayed);
				BGM_sc = bgm.play();
				BGM_sc.soundTransform = new SoundTransform(_volume);
				BGM_sc.addEventListener(Event.SOUND_COMPLETE, onPlayed);
			}
		}
		
		public static function playSE(_src:String):void
		{
			AOBA_SoundPlayer.body.playSE(_src);
		}
		
		public function playSE(_src:String):void
		{
			SE_sc.stop();
			SE_sc.removeEventListener(Event.SOUND_COMPLETE, onPlayed);
			SE_sc.addEventListener(Event.SOUND_COMPLETE, onPlayed);
			
			var se:Sound = new Sound();
			se.load(new URLRequest(_src));
			se.addEventListener(IOErrorEvent.IO_ERROR, onError);
			se.addEventListener(Event.COMPLETE, onLoaded);
			
			function onError(e:IOErrorEvent):void
			{
				trace('查無此音檔 : ' + _src);
				se.removeEventListener(Event.COMPLETE, onLoaded);
				se.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			}
			function onLoaded(e:Event):void
			{
				se.removeEventListener(Event.COMPLETE, onLoaded);
				SE_sc = se.play();
				SE_sc.addEventListener(Event.SOUND_COMPLETE, onPlayed);
			}
			function onPlayed(e:Event):void
			{
				SE_sc.removeEventListener(Event.SOUND_COMPLETE, onPlayed);
				SE_sc.stop();
			}
		}
	}

}