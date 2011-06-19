package de.molehill.game.map {
	
	import de.molehill.game.map.field.Field;
	import de.molehill.game.map.field.FieldEvent;
	import de.molehill.game.units.Unit;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class Map extends EventDispatcher {
		
		protected var _controller : MapController;
		protected var _model : MapModel;
		protected var _view : MapView;

		public function Map(xml:XML) {
			_model = new MapModel(xml);
			_view = new MapView();
			_controller = new MapController(_model, _view);
			initListener();
		}

		private function initListener() : void {
			for (var j : uint = 0; j < _model.size; j++) {
				for (var i : uint = 0; i < _model.size; i++) {
					_model.getField(new Point(j, i)).addEventListener(FieldEvent.FIELD_SELCECTED, onFieldSelected);
				}
			}
		}

		protected function onFieldSelected(event : FieldEvent) : void {
			trace("Map.onFieldSelected(event)");
			dispatchEvent(event);
		}

		public function showReachableFields(unitPosition : Point, actionPoints : uint) : void {
			_controller.showReachableFields(unitPosition, actionPoints);
		}
		
		public function hideReachableFields() : void {
			_controller.hideReachableFields();
		}

		public function get view() : MapView {
			return _view;
		}

		public function handleAddUnit(position : Point) : void {
			_controller.handleAddUnit(position);
		}
		
		public function handleMoveUnit(oldPosition:Point, newPosition:Point):Vector.<Point>
		{
			return _controller.handleMoveUnit(oldPosition, newPosition);			
		}
	}
}