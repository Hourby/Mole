package de.molehill.game.map.field {
	
	import flash.geom.Point;
	import de.molehill.game.map.field.Field;
	
	public class FieldModel {
		
		private var _position : Point;
		private var _type : uint;
		private var _isFree : Boolean;
		private var _parent:Field;
		private var _remainedActionPoints	:uint;	
		private var _isEntryPoint:Boolean;
		private var _isTargetPoint:Boolean;
		

		public function FieldModel(position:Point, type:uint, isFree:Boolean) {
			_position = position;
			_type = type;
			_isFree = isFree;
		}

		public function get position() : Point { return _position; }
		public function set position(value : Point) : void {
			_position = value;
		}

		public function get type() : uint { return _type; }
		public function set type(value : uint) : void {
			_type = value;
		}

		public function get isFree() : Boolean { return _isFree;}
		public function set isFree(value : Boolean) : void {
			_isFree = value;
		}
		
		public function get parent():Field { return _parent; }
		public function set parent(parentField:Field):void {
			_parent = parentField;
		}

		public function get remainedActionPoints():uint { return _remainedActionPoints; }
		public function set remainedActionPoints(value:uint):void {
			_remainedActionPoints = value;
		}

		public function get isEntryPoint():Boolean { return _isEntryPoint; }
		public function set isEntryPoint(value:Boolean):void {
			_isEntryPoint = value;
		}

		public function get isTargetPoint():Boolean { return _isTargetPoint; }
		public function set isTargetPoint(value:Boolean):void {
			_isTargetPoint = value;
		}
	}
}
