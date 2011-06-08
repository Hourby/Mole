package de.molehill.game.level {
	
	import away3d.animators.PathAnimator;
	import away3d.extrusions.PathDuplicator;
	import away3d.extrusions.PathExtrude;
	import away3d.extrusions.utils.Path;
	import away3d.materials.BitmapMaterial;
	import away3d.primitives.Plane;
	
	import de.molehill.game.army.Army;
	import de.molehill.game.environment.Building;
	import de.molehill.game.map.Map;
	import de.molehill.game.map.field.Field;
	import de.molehill.game.map.field.FieldEvent;
	import de.molehill.game.units.Unit;
	import de.molehill.game.units.UnitEvent;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;

	public class Level extends EventDispatcher {
		
		protected var _controller : LevelController;
		protected var _model : LevelModel;
		protected var _view : LevelView;
		private var _lights:Array;
		private var _activeArmy:Army;
		private var _blueArmy:Army;
		private var _redArmy:Army;
		
		private var _map : Map;
		
		private var _path : Path;
		private var _animTime:Number = 0;

		[Embed(source = "assets/textures/underground/tesssss.jpg")]
		private var Albedo : Class;
		private var _pathExtrude:PathExtrude;
		private var _pathAnimator:PathAnimator;

		public function Level() {
			
			//armyRed = new Army(4,3,2);
			_model = new LevelModel();
			_view = new LevelView();
			_controller = new LevelController(_model, _view);
			_map = new Map(16, 16);
			//_map.showReachableFields(new Point(2, 2), 10);
			_view.addChild(_map.view);
			initTerrain(16, 500);
			_map.addEventListener(FieldEvent.FIELD_SELCECTED, onFieldSelected);
			populate();
		}

		public function initialize(lights : Array) : void {
			_lights = lights;
			initBuildings();
			initUnits();
			_activeArmy = _blueArmy;
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
			_map.showReachableFields(_blueArmy.activeUnit.position, 10);
		}

		protected function onMouseOverUnit(event : UnitEvent) : void {
			dispatchEvent(event);
		}
		
		protected function onFieldSelected(event : FieldEvent) : void {
			_map.handleMoveUnit(_activeArmy.activeUnit.position, event.position);
//			_blueArmy.activeUnit.position = event.position;
//			_blueArmy.activeUnit.view.x = 500 * event.position.x;
//			_blueArmy.activeUnit.view.z = 500 * event.position.y;
			initAnimation();
			dispatchEvent(event);
		}
		
		private function initTerrain(size : uint, tileSize : uint) : void {
			var material : BitmapMaterial;
			material = new BitmapMaterial(new Albedo().bitmapData);
			material.ambientColor = 0x202030;

			var underground : Plane = new Plane(material, size * tileSize, size * tileSize);
			underground.pitch(90);
			underground.x = size * 0.5 * tileSize - tileSize * 0.5;
			underground.z = size * 0.5 * tileSize - tileSize * 0.5;
			_view.addChild(underground);

			var bmpData : BitmapData = new BitmapData(512, 512, false, 0x000000);
			bmpData.fillRect(new Rectangle(8, 8, 240, 496), 0x00FF00);
			bmpData.fillRect(new Rectangle(264, 8, 240, 496), 0x00FF00);
			material = new BitmapMaterial(bmpData);
			material.bothSides = true;

			var centerX : Plane = new Plane(material, 1000, 1000);
			centerX.yaw(90);
			_view.addChild(centerX);

			var centerZ : Plane = new Plane(material, 1000, 1000);
			_view.addChild(centerZ);
		}

		private function initBuildings() : void {
			var building : Building = new Building();
			building.x = 500;
			building.z = 500;
			building.initialize(_lights);
			_view.addChild(building);

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
		
		private function populate() : void
		{
			//single segment
			// var data:Array = [	-1000, 0, 0,    0, 500, 500,    1000, 0, 0];
			
			//4 segments
			var data:Array = [	-1000, 0, 0,    -750, 0, 0,    -500, 0, 0, 
								-500, 0, 0,     -250,0,0,       0,0,0,
								0,0,0, 			250, 0, 0, 		500,0,0,
								500,0,0, 		750, 0, 0, 		1000,0,0 ];
			
			var pathData:Vector.<Vector3D> = new Vector.<Vector3D>();
			
			// building the required Vector.<Vector3D>, a series of vector3d's as Prefab spits out the an array of Numbers
			for(var i:uint = 0;i<data.length;i+=3){
				pathData.push(new Vector3D(data[i],data[i+1], data[i+2]));
			}
			
			_path = new Path(pathData);
			
			// the profile, the shape definition projected along the path, in this case a circle
			var profile:Vector.<Vector3D> = new Vector.<Vector3D>();
			
			var vector3d:Vector3D;
			var step:Number = 360/36;
			var angle:Number ;
			
			for(i = 0;i<37;++i){
				angle = 90+(step*i);
				vector3d = new Vector3D();
				vector3d.x = Math.cos(angle/180*Math.PI) * 200;
				vector3d.y = Math.sin(-angle/180*Math.PI) * 200;
				profile.push(vector3d);
			} 
		}
				
		private function initAnimation():void
		{
			// the obecjt we want to animate
//			var target:Cube = new Cube(new BitmapMaterial(new BitmapData(256, 256, false, 0x00FF00)), 50, 50, 100 );
//			_view.scene.addChild(target);
			
			// the object will be on y axis, 300 units higher than the path
			var offset:Vector3D = new Vector3D(0, 300, 0);
			
			// To force animated object to look at it while moving.
			/*var lookatObject:Sphere = new Sphere(new BitmapMaterial(new BitmapData(256, 256, false, 0xCCCC99)), 100);
			_view.scene.addChild(lookatObject);
			lookatObject.x = lookatObject.z = 1000;
			lookatObject.y = 200;
			//_pathAnimator = new PathAnimator(_path, target, offset, false, lookatObject, null);*/
			_pathAnimator = new PathAnimator(_path, _activeArmy.activeUnit.view, offset, true, null, null);
			
			//pathEvents:
			// changeSegment: if for instance you build rails, and want to trigger the sound "tada" of a train when wheel change of rail
			//_pathAnimator.addOnChangeSegment(onChangeSegment);
			// to trigger something when in a given range. (todo: add a series of ranges, only one atm)
			//_pathAnimator.addOnRange(onRange, 0.24, 0.25);
			// triggers each time the pointer goes back to 0
			//_pathAnimator.addOnCycle(onCycle);
		}
		
		private function animatePath() : void
		{
			if(_pathAnimator){
				_animTime += 0.005;
				_pathAnimator.updateProgress(_animTime);
				if(_animTime> 1) _animTime = 0;
				//trace(_pathAnimator.target.position);
			}
		}
		
		public function handleEnterFrame():void
		{
			animatePath();
			
		}
	}
}
