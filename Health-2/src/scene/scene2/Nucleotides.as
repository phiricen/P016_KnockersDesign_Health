package scene.scene2
{
	import aoba.*;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import scene.Scene_2;
	import flash.filters.BitmapFilterQuality;    
	import flash.filters.GlowFilter;    
	
	/**
	 * ...
	 * @author Phiricen
	 */
	public class Nucleotides extends AOBA_Sprite 
	{
		public var index:int;
		private var S2:Scene_2;
		private var error:Boolean;
		public var lines:Array = [];
		public var onDestroy:Function;
		public var onSelected:Function;
		private var isSelected:Boolean = false;
		private var speed:Number = 8;
		public var nW:int = 15;
		public var nH:int = 400;
		private var error_ratio:Number = 0.5;
		private var oColor:uint = 0x000000;
		private var nColor:uint = 0xFFFFFF;
		private var colors:Array = [
			{ title: "紅", color: 0xEE2329},
			{ title: "藍", color: 0x4683C2},
			{ title: "橘", color: 0xF7974B},
			{ title: "褐", color: 0x948D56},
			{ title: "綠", color: 0x9BBD5C}
		];		
		public function Nucleotides(_amount:int,_S2:Scene_2) 
		{
			super();
			S2 = _S2;
			index = _amount;
			error = Math.random() <= error_ratio;
			
			for (var i:int = 0; i < 4; i++){
				var shape:Shape = new Shape;
				var shape_hta:Shape = new Shape;
				var sprite:Sprite = new Sprite;
				switch(i){
					case 0:
						nColor = newColor();
						S2.mc_bottom.addChild(sprite);
						break;
					case 1:
						nColor = error ? newColor() : nColor;
						S2.mc_bottom.addChild(sprite);
						break;
					case 2:
						nColor = lines[0].color;
						S2.mc_top.addChild(sprite);
						if ( error ) sprite.addEventListener(MouseEvent.CLICK, onClick);
						break;
					case 3:
						nColor = lines[1].color;
						S2.mc_top.addChild(sprite);
						if ( error ) sprite.addEventListener(MouseEvent.CLICK, onClick);
						break;
				}
				shape.graphics.beginFill(nColor);
				shape.graphics.drawRect(0, 0, nW, nH);
				shape.graphics.endFill();
				
				shape_hta.graphics.beginFill(0xFF00000, 0);
				shape_hta.graphics.drawRect(-20, 50, nW+40, nH);
				shape_hta.graphics.endFill();
				
				sprite.x = AOBA_Main.WIDTH;
				sprite.y  = i % 2 == 0 ? nH *-1 - 10 : 10;
				sprite.x += i < 2 ? 0 : 0;
				sprite.y += i == 2 ? -5 : 0;
				sprite.y += i == 3 ? +5 : 0;
				sprite.scaleX = i < 2 ? 1 : 3;
				sprite.addChild(shape);
				if(error) sprite.addChild(shape_hta);
				lines.push({ n: sprite, color: nColor });
			}
			addEventListener(Event.ENTER_FRAME, onRun);
		}
		private function onClick(e:MouseEvent):void {
			if (isSelected) return;
			isSelected = !isSelected;
			doHalo();
			onSelected();
		}
		private function onRun(e:Event):void {			
			for (var i:int = 0; i < lines.length; i++){
				lines[i].n.x -= speed;
			}
			if ( lines[0].n.x <= 0) destroy();
		}
		public function destroy():void{
			S2.amount--;
			S2.nucls[S2.nucls.indexOf(this)] = null;
			removeEventListener(Event.ENTER_FRAME, onRun);
			for (var i:int = 0; i < lines.length; i++){
				lines[i].n.parent.removeChild(lines[i].n);
				lines[i].n.removeEventListener(MouseEvent.CLICK, onClick);
			}
			lines = null;
		}
		private function doHalo():void {
			var glow:GlowFilter = new GlowFilter ( 0xFFFF00, 1, 25, 25 );
			glow.quality = BitmapFilterQuality.HIGH;    
			for (var i:int = 0; i < lines.length; i++){
				lines[i].n.filters = [glow];
			}
		}
		private function newColor():uint {
			oColor = nColor;
			while (oColor === nColor ){
				nColor = colors[Math.floor(Math.random() * colors.length)].color;
			}
			return nColor;
		}
	}
}