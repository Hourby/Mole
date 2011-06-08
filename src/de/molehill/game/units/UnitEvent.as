package de.molehill.game.units
{
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	public class UnitEvent extends Event
	{
		public static const UNIT_SELCECTED :String="unitSelected";
		public static const UNIT_DESELCECTED :String="unitDeselected";
		public static const MOUSE_OVER_UNIT :String="mouseOverUnit";
		public static const MOUSE_OUT_UNIT :String="mouseOutUnit";
		
		public var unitID:uint;
		public var position:Vector3D;
		
		public function UnitEvent(type:String, unitID:uint, position:Vector3D)
		{
			this.unitID = unitID;
			this.position = position;
			super(type);
		}
		
		override public function clone():Event
		{
			return new UnitEvent(type,unitID,position);
		}
		
	}
}