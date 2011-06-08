package de.molehill.components.chat {
	
	import flash.events.Event;
	
	public class ChatEvent extends Event {
		
		public static const MESSAGE :String="message";

		public var message:String;
		
		public function ChatEvent(type:String, message:String) {
			this.message = message;
			super(type);
		}

		public override function clone():Event {
			return new ChatEvent(type, message);
		}
	}
}