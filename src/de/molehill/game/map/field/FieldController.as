package de.molehill.game.map.field {

	public class FieldController {
		
		private var _model : FieldModel;
		private var _view : FieldView;

		public function FieldController(model : FieldModel, view : FieldView) {
			_model = model;
			_view = view;
		}
	}
}
