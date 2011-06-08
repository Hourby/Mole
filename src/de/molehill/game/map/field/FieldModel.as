package de.molehill.game.map.field {
	
	import flash.geom.Point;
	import de.molehill.game.map.field.Field;
	
	public class FieldModel {
		
		private var _position : Point;
		private var _wayCost : uint;
		private var _isFree : Boolean;
		private var _doHideView : Boolean;
		private var _parent:Field;
		private var _remainedActionPoints	:uint;	
		

		public function FieldModel(position:Point, wayCost:uint, isFree:Boolean, doHideView:Boolean) {
			_position = position;
			_wayCost = wayCost;
			_isFree = isFree;
			_doHideView = doHideView;
		}

		public function get position() : Point { return _position; }
		public function set position(value : Point) : void {
			_position = value;
		}

		public function get wayCost() : uint { return _wayCost; }
		public function set wayCost(value : uint) : void {
			_wayCost = value;
		}

		public function get isFree() : Boolean { return _isFree;}
		public function set isFree(value : Boolean) : void {
			_isFree = value;
		}

		public function get doHideView() : Boolean { return _doHideView; }
		public function set doHideView(value : Boolean) : void {
			_doHideView = value;
		}
		
		public function get parent():Field { return _parent; }
		public function set parent(parentField:Field):void {
			_parent = parentField;
		}

		public function get remainedActionPoints():uint { return _remainedActionPoints; }
		public function set remainedActionPoints(value:uint):void {
			_remainedActionPoints = value;
		}

	}
}
