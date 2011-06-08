package login
{
	import flash.events.Event;
	
	public class LoginEvent extends Event
	{
		public var userName:String;
		public var password:String;
		public static var LOGIN:String = "login";
		
		public function LoginEvent(type:String, name:String, password:String, bubbles:Boolean=true)
		{
			this.userName = name;
			this.password = password;
			trace(this.userName + this.password);
			
			//TODO: implement function
			super(type, bubbles);
		}
		
		override public function clone():Event
		{
			// TODO Auto Generated method stub
			return new LoginEvent(userName, password, type, bubbles);
		}
		
		
	}
}