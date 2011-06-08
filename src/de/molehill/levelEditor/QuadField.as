package de.molehill.levelEditor {	
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class QuadField extends EventDispatcher {	
		
		private var _cost:uint;
		private var _view:QuadFieldView;
		private var _free:Boolean;
		private var _heightMapInMeter:Number;
		private var _isStartField:Boolean;
		private var _coordinates:Point;
		
		public function QuadField(coordinates:Point,width:uint, height:uint) {
			_coordinates = coordinates;
			_view = new QuadFieldView(width,height);
			_view.addEventListener("fieldViewClicked", onClickedView);
		}	
		
/*------------------------------------------------------------------------------------------*/
/*------------------------------------- Event Handler --------------------------------------*/
/*------------------------------------------------------------------------------------------*/
		
		protected function onClickedView(event:Event):void {
			dispatchEvent(new LevelEditorFieldEvent(LevelEditorFieldEvent.ON_MOUSE_CLICK, this));
		}
		
/*------------------------------------------------------------------------------------------*/
/*----------------------------------- Getter und Setter ------------------------------------*/
/*------------------------------------------------------------------------------------------*/
		
		public function get view():QuadFieldView { return _view; }
			
		public function get coordinates():Point { return _coordinates; }

		
		public function get cost():uint { return _cost; }
		public function set cost(cost:uint):void { 
			_cost = cost;
		}
		
		public function get free():Boolean { return _free; }
		public function set free(isFree:Boolean):void {
			_free = free;
		}

		public function get heightMapInMeter ():Number {	return _heightMapInMeter; }
		public function set heightMapInMeter (meter:Number):void {
			_heightMapInMeter = heightMapInMeter;
		}
		
		public function get underground():BitmapData { return _view.undergroundMaterial; }
		public function setUndergroundMaterial (underground:BitmapData):void{
			_view.setTexture(underground);
		}

		public function get isStartField ():Boolean { return _isStartField; }
		public function set isStartField (isStartField:Boolean):void {
			_isStartField = isStartField;
		}
	}
}