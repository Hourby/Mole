package de.molehill.game.map {
	
	import de.molehill.game.map.field.Field;
	
	import flash.geom.Point;

	public class MapController {
		
		private var _model : MapModel;
		private var _view : MapView;

		public function MapController(model : MapModel, view : MapView) {
			_model = model;
			_view = view;
		}

		public function handleAddUnit(position : Point) : void {
			_model.handleAddUnit(position);
		}

		public function showReachableFields(unitPosition : Point, actionPoints : uint) : void {
			var fields : Vector.<Field>; 
			fields = _model.computeReachableFields(unitPosition, actionPoints);
			_view.showFields(fields);
		}

		public function hideReachableFields() : void {
			var fields : Vector.<Field> = _model.getCurrentReachableFields();
			_model.clearCurrentReachableFields();
			_view.hideFields(fields);
		}
		
		public function handleMoveUnit(oldPosition : Point, newPosition : Point) : Vector.<Point> {
			return _model.handleMoveUnit(oldPosition, newPosition);
		}
	}
}
