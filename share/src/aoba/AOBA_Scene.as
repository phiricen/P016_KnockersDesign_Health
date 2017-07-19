package aoba
{
	import aoba.*;
	/**
	 * ...
	 * @author Phiricen
	 */
	public class AOBA_Scene extends AOBA_Sprite
	{
		public var onNextScene:Function;
		public function AOBA_Scene(_onNextScene:Function = null) 
		{
			if (_onNextScene) onNextScene = _onNextScene;
			visible = false;
		}
		public function show():void { visible = true; }
		public function hide():void { visible = false; }
	}
}