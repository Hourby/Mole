package de.molehill.game.army 
{
	import flash.events.Event;

	public class ArmyEvent extends Event {
		
//		public static const UNIT_SELCECTED:String="unitSelected";
//		public static const UNIT_DESELCECTED:String="unitDeselected";
//		public static const MOUSE_OVER_UNIT:String="mouseOverUnit";
//		public static const MOUSE_OUT_UNIT:String="mouseOutUnit";

		public var unitID:uint;

		public function ArmyEvent(type:String, unitID:uint) {
			this.unitID=unitID;
			super(type);
		}
	}
}
