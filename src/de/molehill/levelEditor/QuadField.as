package de.molehill.levelEditor {	
	
	import de.molehill.game.map.field.Field;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class QuadField extends EventDispatcher {	
		

		private var _view:QuadFieldView;
		private var _coordinates:Point;
		private var _field:Field;
		
		public function QuadField(coordinates:Point,width:uint, height:uint) {
			_coordinates = coordinates;
			_field = new Field(coordinates,0,true);
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

		
		public function get type():uint { return _field.type; }
		public function set type(type:uint):void { 
			_field.type = type;
		}
		
		public function get free():Boolean { return _field.isFree; }
		public function set free(isFree:Boolean):void {
			_field.isFree = free;
		}
		
		public function get underground():BitmapData { return _view.undergroundMaterial; }
		public function setUndergroundMaterial (underground:BitmapData):void{
			_view.setTexture(underground);
		}

		public function get isTargetPoint ():Boolean { return _field.isTargetPoint; }
		public function set isTargetPoint (isTargetPoint:Boolean):void {
			_field.isTargetPoint = isTargetPoint;
		}
		
		public function get isEntryPoint ():Boolean { return _field.isEntryPoint; }
		public function set isEntryPoint (isEntryPoint:Boolean):void {
			_field.isEntryPoint = isEntryPoint;
		}


		public function get field():Field
		{
			return _field;
		}

		public function set field(value:Field):void
		{
			_field = value;
		}

	}
}