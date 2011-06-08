package components.videoPhone
{
	import flash.events.Event;
	
	public class VideoPhoneEvent extends Event
	{
		public static const CALLSTATE_CHANGED:String = "callstate_changed";
		public static const REMOTE_VIDEO:String = "remote_video";
		public static const LOCAL_VIDEO:String = "local_video";
		public static const INCOMING_MESSAGE:String = "incoming_message";
		
		public var data:*;
		
		public function VideoPhoneEvent(type:String,data:*)
		{
			this.data = data;
			super(type, data);
		}
		
		public override function clone():Event {
			return new VideoPhoneEvent(type, data);
		}
	}
}