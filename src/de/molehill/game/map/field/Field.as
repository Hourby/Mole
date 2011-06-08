package de.molehill.game.map.field
{
	import away3d.events.MouseEvent3D;
	
	import de.molehill.game.map.field.Field;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class Field extends EventDispatcher
	{
		protected var _controller : FieldController;
		protected var _model : FieldModel;
		protected var _view : FieldView;
		
		public function Field(position:Point, wayCost:uint, isFree:Boolean, doHideView:Boolean)
		{
			_model = new FieldModel(position, wayCost, isFree, doHideView);
			_view = new FieldView();
			_controller = new FieldController(_model, _view);
			_view.addEventListener(MouseEvent3D.CLICK, onFieldSelected);
		}
		
		protected function onFieldSelected(event:MouseEvent3D):void
		{
			dispatchEvent(new FieldEvent(FieldEvent.FIELD_SELCECTED,_model.position));
		}
		
		public function get isFree():Boolean { return _model.isFree; }
		public function set isFree(isFree:Boolean):void {
			_model.isFree = isFree;
		}
		
		public function get wayCost():uint { return _model.wayCost; }
		
		public function set parent(currentField:Field):void {
			_model.parent = currentField;
		}
		
		public function get remainedActionPoint():uint { return _model.remainedActionPoints; }
		public function set remainedActionPoint(remainedActionPoint:uint):void {
			_model.remainedActionPoints = remainedActionPoint;
		}
		
		public function get position():Point { return _model.position; }
		
		public function get view():FieldView { return _view; }
		public function set view(view:FieldView):void {
			_view = view;
		}
	}
}