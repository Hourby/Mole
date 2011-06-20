package login
{
	import flash.events.Event;
	
	public class LoginEvent extends Event
	{
		public static var OK:String = "ok";
		
		public function LoginEvent(type:String,  bubbles:Boolean=true)
		{
			super(type, bubbles);
		}
		
		override public function clone():Event
		{
			return new LoginEvent(type, bubbles);
		}
		
	}
}