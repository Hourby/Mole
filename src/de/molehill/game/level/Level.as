package de.molehill.game.level {
	
	import de.molehill.game.army.Army;
	import de.molehill.game.map.Map;
	import de.molehill.game.map.field.FieldEvent;
	import de.molehill.game.units.Unit;
	import de.molehill.game.units.UnitEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class Level extends EventDispatcher {
		
		protected var _controller : LevelController;
		protected var _model : LevelModel;
		protected var _view : LevelView;
		private var _animator:Animator;
		private var _lights:Array;
		private var _activeArmy:Army;
		private var _blueArmy:Army;
		private var _redArmy:Army;
		
		private var _map : Map;
		
		private var _isAnimation:Boolean;

		public function Level(xml:XML) {
			//_redArmy = new Army(4,3,2);
			_model = new LevelModel();
			_view = new LevelView();
			_controller = new LevelController(_model, _view);
			_map = new Map(xml);
			_view.addChild(_map.view);
			_map.addEventListener(FieldEvent.FIELD_SELCECTED, onFieldSelected);
		}

		public function initialize(lights : Array) : void {
			_animator = new Animator();
			_animator.addEventListener(AnimationEvent.ANIMATION_COMPLETE,onAnimationComplete);
			var lig:LevelItemGenerator = new LevelItemGenerator(_view, lights);
			lig.initTerrain(16, 500);
			lig.initBuildings();
			initUnits();
			_activeArmy = _blueArmy;
		}

		protected function onAnimationComplete(event : AnimationEvent) : void {
			_activeArmy.activeUnit.view.rotationY = event.rotation;
			_blueArmy.addEventListener(UnitEvent.UNIT_SELCECTED, onUnitSelected);
		}
		
		private function initUnits() : void {
			_blueArmy = new Army(4,3,2);
			_blueArmy.addEventListener(UnitEvent.MOUSE_OVER_UNIT, onMouseOverUnit);
			_blueArmy.addEventListener(UnitEvent.UNIT_SELCECTED, onUnitSelected);
			var units : Vector.<Unit> = _blueArmy.units;
			for each (var unit : Unit in units) {
				addUnit(unit, new Point(uint(Math.random()*16),uint(Math.random()*16)));
			}
		}

		protected function onUnitSelected(event : Event) : void {
			dispatchEvent(event);
			_map.hideReachableFields();
			_map.showReachableFields(_blueArmy.activeUnit.position, 10);
		}

		protected function onMouseOverUnit(event : UnitEvent) : void {
			dispatchEvent(event);
		}
		
		protected function onFieldSelected(event : FieldEvent) : void {
			_map.hideReachableFields();
			_isAnimation = true;
			_blueArmy.removeEventListener(UnitEvent.UNIT_SELCECTED, onUnitSelected);
			var wayPoints:Vector.<Point> = _map.handleMoveUnit(_activeArmy.activeUnit.position, event.position); 
			_activeArmy.activeUnit.moveToField(event.position);
			_animator.initAnimation(_activeArmy.activeUnit.view, wayPoints);
			dispatchEvent(event);
		}
		
		public function addUnit(unit : Unit, position : Point) : void {
			unit.initiliaze(_lights);
			unit.position = position;
			unit.view.x = 500 * position.x;
			unit.view.z = 500 * position.y;
			_view.addChild(unit.view);
			_map.handleAddUnit(position);
		}

		public function get view() : LevelView {
			return _view;
		}

		public function handleEnterFrame() : void {
			if(_isAnimation){
				_animator.animatePath();
			}
		}
	}
}
