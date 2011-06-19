package de.molehill.game.units
{
	import away3d.events.MouseEvent3D;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class Unit extends EventDispatcher
	{
		protected var _controller:UnitController;
		protected var _model:UnitModel;
		protected var _view:UnitView;
						
		public function Unit(id:uint, lifePoints:uint, actionPoints:uint, attack:uint, defence:uint, range:uint)
		{
			_model = new UnitModel(id, lifePoints, actionPoints, attack, defence, range);
			_view = new UnitView();
			_controller = new UnitController(_model, _view);
			
			initListener();
		}
		
		private function initListener():void
		{			
			_view.addEventListener(MouseEvent3D.MOUSE_OVER, onMouseOver);
			_view.addEventListener(MouseEvent3D.CLICK, onMouseClick);
		}
		
		protected function onMouseClick(event:Event):void
		{
			dispatchEvent(new UnitEvent(UnitEvent.UNIT_SELCECTED,_model.id,view.position));
		}
		
		private function onMouseOver(event:MouseEvent3D):void {
			dispatchEvent(new UnitEvent(UnitEvent.MOUSE_OVER_UNIT,_model.id,view.position));
		}
			
		public function initiliaze(lights:Array):void {
			_view.initMesh(lights);
		}
		
		public function addToField(position:Point):void {
			_controller.handleAddToField(position);
		}
		
		public function moveToField(position:Point):void {
			_controller.handleMoveTo(position);
		}
		
		public function destroy():void {
			_controller.handleDestroy();
		}
		
		public function attack():void {
			
		}
		
		public function get position():Point { return _model.position; }
		public function set position(pos:Point):void {
			_model.position = pos;
		}
		
		public function resetActionPoints():void {
			_model.resetActionPoints();
		}

		public function get view():UnitView { return _view;	}
		
		public function get id():uint{
			return _model.id;
		}

	}
}