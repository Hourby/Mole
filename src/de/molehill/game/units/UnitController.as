package de.molehill.game.units {

	import away3d.events.MouseEvent3D;
	import away3d.extrusions.utils.Path;
	
	import de.molehill.game.units.UnitModel;
	
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class UnitController {
		private var _model:UnitModel;
		private var _view:UnitView;

		public function UnitController(model:UnitModel, view:UnitView) {
			_model=model;
			_view=view;
		}
		
		public function handleMoveTo(position:Point):void {
			_model.position=position;
		}

		public function handleAddToField(position:Point):void {
			_model.position=position;

		}

		public function handleDestroy():void {
			_model=null;
			_view=null;
		}
		
	}
}
