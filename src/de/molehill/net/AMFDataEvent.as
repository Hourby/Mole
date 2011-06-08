package de.molehill.net{
	
	
	import de.molehill.net.valueObjects.ValueObject;
	
	import flash.events.Event;

	public class AMFDataEvent extends Event {
		
		public static const ON_RECEIVE_DATA:String="onReceiveData";

		public var vo:ValueObject;
		
		public function AMFDataEvent(type:String, vo:ValueObject) {
			super(type);
			this.vo = vo;
		}

		public override function clone():Event {
			return new AMFDataEvent(type, vo);
		}
	}
}