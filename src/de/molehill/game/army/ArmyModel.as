package de.molehill.game.army {
	
	import de.molehill.game.units.Unit;
	import de.molehill.game.units.UnitEvent;
	
	import flash.events.Event;

	public class ArmyModel {

		private var _activeUnit : Unit;
		private var _unitVector : Vector.<Unit>;
		private var _uniqueUnitID : uint;
		private var _unitFactory : UnitFactory;

		public function ArmyModel() {
			_uniqueUnitID = 0;
			_unitVector = new Vector.<Unit>();
			//_activeUnit = _unitVector[0];
		}


		
		private function createUnit():void {
			
		}

		public function get activeUnit() : Unit {
			return _activeUnit;
		}

		public function set activeUnit(value : Unit) : void {
			_activeUnit = value;
		}

		public function resetRestAktionspunkte() : void {
			for each (var unit : Unit in _unitVector) {
				unit.resetActionPoints();
			}
		}

		public function get unitVector() : Vector.<Unit> {
			return _unitVector;
		}

		public function addUnit(unitType : uint) : Unit {
			var unit:Unit = UnitFactory.createUnit(unitType);
			_unitVector.push(unit);
			return unit;
		}

		public function removeUnit(unit : Unit) : void {
			unit.destroy();
			var index : uint = _unitVector.indexOf(unit);
			_unitVector.splice(index, 1);
		}

		public function getUnitByPosition(pos : uint) : Unit {
			return _unitVector[pos];
		}

		public function getUnitByID(id : uint) : Unit {
			for each (var unit : Unit in _unitVector) {
				if (unit.id == id) {
					break;
				}
			}
			return unit;
		}
		
		public function setActiveUnit(event:UnitEvent):void
		{
			_activeUnit = getUnitByID(event.unitID);
		}
	}
}
