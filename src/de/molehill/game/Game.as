package de.molehill.game {
	
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.View3D;
	import away3d.lights.PointLight;
	
	import de.molehill.game.level.Level;
	import de.molehill.game.units.UnitEvent;
	import de.molehill.temp.FlightController;
	import de.molehill.temp.HoverDragController;
	import de.molehill.util.GameAssetLoader;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.utils.Timer;
	
	import mx.effects.Tween;
	import mx.events.TweenEvent;

	public class Game {
		
		private var _view : View3D;
		private var _level:Level;
		private var _lights:Array;
		private var _light : PointLight;
		private var _ambientLight:PointLight;
		private var _firstPersonController : FlightController;
		private var _camController : HoverDragController;
		private var _cameraTarget:Vector3D;
		
		private var _timer:Timer;
		private var _cameraSpeed:uint = 200;
		private var _tween:Tween;
		
		private var velocity:Vector3D;

		public function Game(view : View3D) {
			GameAssetLoader.instance.loadAssets();
			GameAssetLoader.instance.addEventListener("GAME_ASSETS_LOADED", onAssetsLoaded);

			_view = view;
			_view.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);

			_level = new Level();
			//_level.addEventListener(UnitEvent.MOUSE_OVER_UNIT, onMouseOverUnit);
			_level.addEventListener(UnitEvent.UNIT_SELCECTED, onUnitSelected);
			view.scene.addChild(_level.view);

			setupCamera();
			setupLight();
			
			

		}
		
		protected function onUnitSelected(event:UnitEvent):void
		{
			_cameraTarget = event.position;
			fade(20,40);			
		}
		
		protected function onAssetsLoaded(event : Event) : void {
			_level.initialize(_lights);
		}
		
		protected function onMouseOverUnit(event : UnitEvent) : void {
			_cameraTarget = event.position;
			//_tween = new Tween(this,_view.camera.x, _cameraTarget.x);
		}

		private function setupCamera() : void {
			_view.camera.x = 4000;
			_view.camera.y = 7000;
			_view.camera.z = -10000;
			_view.camera.lens = new PerspectiveLens(20);
			//_view.camera.lens = new OrthographicLens(3000);
			//_view.camera.lens = new OrthographicOffCenterLens(450,1500,450,6000);
			_view.camera.lens.far = 30000;
			_view.camera.lookAt(new Vector3D(4000, 0, 0));
			_firstPersonController = new FlightController(_view.camera, _view.stage);
			_firstPersonController.moveSpeed = 20;
//			_camController = new HoverDragController(_view.camera, _view.stage);
		}

		private function setupLight() : void {
			_lights = [];
			_light = new PointLight();
			_light.x = 15000;
			//_light.z = 15000;
			_light.z = 15000;
			_light.color = 0xffddbb;
			//_light.diffuse = 0.6;
			_ambientLight = new PointLight();
			//_ambientLight.x = 5000;
			_ambientLight.y = 5000;
			//_ambientLight.z = 5000;
			_ambientLight.color = 0xffddbb;
			_ambientLight.diffuse = 0.6;		
			_lights.push(_light);
			_lights.push(_ambientLight);
			_view.scene.addChild(_light);
			_view.scene.addChild(_ambientLight);
		}

		private function onEnterFrame(e : Event) : void {
			_view.render();
			_level.handleEnterFrame();

		}
		
		private function fade(delay:Number, repeat:Number):void
		{
			// = computeVelocity();
			var tmp:Vector3D = _view.camera.position;
			tmp.z += 10000;
			velocity = _cameraTarget.subtract( tmp);
			var len:Number = velocity.length;
			velocity.scaleBy( 1.0/len * (len / repeat));
			velocity.y = 0.0;
			_timer = new Timer(delay,repeat);
			_timer.reset();
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, onTimerTick);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
		}
		
		protected function onTimerComplete(event:TimerEvent):void
		{
			_timer.removeEventListener(TimerEvent.TIMER, onTimerTick);
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);			
		}
		
		private function computeVelocity():void {
			
		}
		
		private function onTimerTick(e:TimerEvent):void
		{
			_view.camera.position = _view.camera.position.add(velocity);
			
		}
		
	}
}