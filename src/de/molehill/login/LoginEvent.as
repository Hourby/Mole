package de.molehill.login{
	
	import flash.events.Event;

	public class LoginEvent extends Event {
		
		public static const LOGIN:String="login";
		
		public var name:String;
		public var pw:String;

		public function LoginEvent(type:String, name:String, pw:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.name = name;
			this.pw = pw;
		}

		public override function clone():Event {
			return new LoginEvent(type, name, pw, bubbles, cancelable);
		}
	}
}