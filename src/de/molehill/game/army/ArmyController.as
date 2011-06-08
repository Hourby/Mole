package de.molehill.game.army {

	import away3d.events.MouseEvent3D;
	
	import de.molehill.game.units.Unit;
	import de.molehill.game.units.UnitEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class ArmyController {
		private var _model:ArmyModel;
		private var _view:ArmyView;

		public function ArmyController(model:ArmyModel, view:ArmyView) {
			_model=model;
			_view=view;
		}

				
		public function handleDestroy():void {
			_model=null;
			_view=null;
		}
		
		public function handleUnitSelected(event:UnitEvent):void
		{
			_model.setActiveUnit(event);
			
		}
	}
}
