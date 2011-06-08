package de.molehill.game.units {
	import flash.geom.Point;

	public class UnitModel {
		private var _id:uint;
		private var _lifePoints:uint;
		private var _actionPoints:uint;
		private var _remainingActionPoints:uint;
		private var _attack:uint;
		private var _defence:uint;
		private var _range:uint;
		private var _position:Point;

		public function UnitModel(id:uint, lifePoints:uint, actionPoints:uint, attack:uint, defence:uint, range:uint) {
			_id=id;
			_lifePoints=lifePoints;
			_actionPoints=actionPoints;
			_attack=attack;
			_defence=defence;
			_range=range;
			_remainingActionPoints = _actionPoints;
		}

		public function resetActionPoints():void {
			_remainingActionPoints = _actionPoints;
		}

		public function get id():uint {	return _id; }
		public function set id(value:uint):void {
			_id=value;
		}

		public function get lifePoints():uint {	return _lifePoints;}
		public function set lifePoints(value:uint):void {
			_lifePoints=value;
		}

		public function get actionPoints():uint {return _actionPoints; }
		public function set actionPoints(value:uint):void {
			_actionPoints=value;
		}

		public function get attack():uint {	return _attack;	}
		public function set attack(value:uint):void {
			_attack=value;
		}

		public function get defence():uint { return _defence; }
		public function set defence(value:uint):void {
			_defence=value;
		}

		public function get range():uint { return _range; }
		public function set range(value:uint):void {
			_range=value;
		}

		public function get position():Point { return _position; }
		public function set position(value:Point):void {
			_position = value;
		}
	}
}
