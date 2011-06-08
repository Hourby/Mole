package de.molehill.levelEditor{
	
	import flash.events.Event;
	import flash.geom.Point;

	public class LevelEditorFieldEvent extends Event {
		
		public static const ON_MOUSE_OVER :String="onMouseOver";
		public static const ON_MOUSE_OUT  :String="onMouseOut";
		public static const ON_MOUSE_CLICK:String="onMouseClick";

		public var field:QuadField;
		
		public function LevelEditorFieldEvent(type:String, field:QuadField, bubbles:Boolean=true) {
			this.field = field;
			super(type,bubbles);
		}

		public override function clone():Event {
			return new LevelEditorFieldEvent(type, field, bubbles);
		}
	}
}