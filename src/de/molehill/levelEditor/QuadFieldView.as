package de.molehill.levelEditor {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class QuadFieldView extends Sprite {

		private var _undergroundMaterial:BitmapData;
		private var _environmentMaterial:BitmapData;
		private var _material:BitmapData;
		
		public function QuadFieldView(width:uint, height:uint) {
			_material = new BitmapData(width, height);
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, onClickView);
		}
		
		public function getUnderground():String {
			return null;
		}

		public function setTexture(material:BitmapData):void {
			_material.draw(material);
			graphics.beginBitmapFill(material);
			graphics.lineStyle(0.5,0x666666);
			graphics.drawRect(0, 0, material.width, material.height);
		}

		public function get undergroundMaterial():BitmapData {
			return _material;
		}

		public function setEnvironmentMaterial(material:BitmapData):void {

		}

		protected function onClickView(event:MouseEvent):void {
			dispatchEvent(new Event("fieldViewClicked"));
		}
	}
}