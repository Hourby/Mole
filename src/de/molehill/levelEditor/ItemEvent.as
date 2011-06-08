package de.molehill.levelEditor{
	
	import de.molehill.levelEditor.items.MapItem;
	
	import flash.events.Event;
	import flash.geom.Point;

	public class ItemEvent extends Event {
		
		public static const SELCECT :String="select";

		public var item:MapItem;
		
		public function ItemEvent(type:String, mapItem:MapItem,bubbles:Boolean=true) {
			item = mapItem;
			super(type,bubbles);
		}

		public override function clone():Event {
			return new ItemEvent(type, item, bubbles);
		}
	}
}