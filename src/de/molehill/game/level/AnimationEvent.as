package de.molehill.game.level
{
	import flash.events.Event;
	
	public class AnimationEvent extends Event
	{
		public static const ANIMATION_COMPLETE :String="animationComplete";
		
		public var rotation:uint;
		
		public function AnimationEvent(type:String, rotation:uint)
		{
			this.rotation = rotation;
			super(type);
		}
		
		override public function clone():Event
		{
			return new AnimationEvent(type,rotation);
		}
		
	}
}