package de.molehill.game.map.field
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	public class FieldEvent extends Event
	{
		public static const FIELD_SELCECTED :String="fieldSelected";
		public static const MOUSE_OVER_FIELD :String="mouseOverField";
		public static const MOUSE_OUT_FIELD :String="mouseOutField";
		
		public var position:Point;
		
		public function FieldEvent(type:String, position:Point)
		{
			this.position = position;
			super(type);
		}
		
		override public function clone():Event
		{
			return new FieldEvent(type,position);
		}
		
	}
}