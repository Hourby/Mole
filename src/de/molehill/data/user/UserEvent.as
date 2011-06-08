package de.molehill.data.user{
	
	
	import flash.events.Event;

	public class UserEvent extends Event {
		
		public static const CHANGE:String="change";
		public static const REQUEST:String="request";
		public static const SELECT:String="select";
		
		public var user:User;

		public function UserEvent(type:String, user:User=null, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.user=user;
		}

		public override function clone():Event {
			return new UserEvent(type, user, bubbles, cancelable);
		}
	}
}