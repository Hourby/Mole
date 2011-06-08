package de.molehill.game.level
{
	public class LevelController
	{
		private var _model : LevelModel;
		private var _view : LevelView;
		
		public function LevelController(model : LevelModel, view : LevelView) {
			_model = model;
			_view = view;
		}
	}
}