package de.molehill.game.army {

	import de.molehill.game.units.Unit;
	import de.molehill.game.units.UnitEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class Army extends EventDispatcher {

		protected var _controller : ArmyController;
		protected var _model : ArmyModel;
		protected var _view : ArmyView;
		
		public function Army(tanks : uint, humwees : uint, artilleries : uint) {
			_model = new ArmyModel();
			_view = new ArmyView();
			_controller = new ArmyController(_model, _view);
			createUnits(tanks, humwees, artilleries);
		}
		
		public function get units():Vector.<Unit> {
			return _model.unitVector;
		}
		
		public function get activeUnit():Unit {
			return _model.activeUnit;
		}
		
		private function createUnits(soldiers : uint, tanks : uint, artilleries : uint) : void {
			for (var i : uint = 0; i < 3; i++) {
				for (var j : uint = 0; j < 3; j++) {
					addUnit(i);
				}
			}
		}

		protected function onMouseOverUnit(event : UnitEvent) : void {
			dispatchEvent(event);
		}		
		
		public function addUnit(unitType : uint) : void {
			var unit:Unit = _model.addUnit(unitType);
			unit.addEventListener(UnitEvent.MOUSE_OVER_UNIT, onMouseOverUnit);
			unit.addEventListener(UnitEvent.UNIT_SELCECTED, onUnitSelected);
		}

		protected function onUnitSelected(event : UnitEvent) : void {
			_controller.handleUnitSelected(event);
			dispatchEvent(event);
		}
	}
}
