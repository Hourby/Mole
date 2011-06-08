package de.molehill.net{
	
	import flash.events.Event;

	public class P2PConnectionEvent extends Event {
		
		public static const ON_CONNECT:String="connect";
		public static const ON_NEIGHBOR_DISCONNECT:String="onNeighborDisconnect";
		public static const ON_NEIGHBOR_CONNECT:String="onNeighborConnect";

		public var peerID:String;
		
		public function P2PConnectionEvent(type:String, peerID:String) {
			super(type);
			this.peerID = peerID;
		}

		public override function clone():Event {
			return new P2PConnectionEvent(type, peerID);
		}
	}
}