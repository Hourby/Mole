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
			var fields : Vector.<Field> = _model.getCurrentReachableFields();
			_view.hideFields(fields);
			fields = _model.computeReachableFields(unitPosition, actionPoints);
			_view.showFields(fields);
		}

		public function handleMoveUnit(oldPosition : Point, newPosition : Point) : void {
			_model.handleMoveUnit(oldPosition, newPosition);
		}
	}
}
