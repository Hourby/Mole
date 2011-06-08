package de.molehill.net {

	import de.molehill.data.user.MyUser;
	import de.molehill.data.user.UserVO;
	import de.molehill.logger.Logger;
	import de.molehill.net.valueObjects.ChatVO;
	import de.molehill.net.valueObjects.ValueObject;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	import flash.net.NetStream;
	import flash.net.SharedObject;
	
	import template.net.IAMFManager;
	
	public final class P2P_Manager extends EventDispatcher implements IAMFManager {
		
		static private var _instance:P2P_Manager;
		private const SERVER:String = "rtmfp://stratus.adobe.com/";
		private const DEVKEY:String = "b239b38ba0c69f0d3cb69aef-fe881de8052c";
		private var _netConnection:NetConnection;
		//private var _myPeerID:String;
		private var sendStream:NetStream;
		private var recvStream:NetStream;
		private var netGroup:NetGroup;		
		private const GROUP_ID:String="tactix";		
		private var sequenceNumber:uint = 0;
//		[Bindable]
//		private var connected:Boolean=false;
//		[Bindable]
//		private var joinedGroup:Boolean=false;


		public function P2P_Manager(singleton:SingletonEnforcer){
			super();
		}
		
		public static function get instance(): P2P_Manager {
			if (P2P_Manager._instance == null) P2P_Manager._instance = new P2P_Manager(new SingletonEnforcer());
			return P2P_Manager._instance;
		}

		public function doConnect():void {
			_netConnection=new NetConnection();
			_netConnection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_netConnection.connect(SERVER + DEVKEY);
		}
		
//		private function doDisconnect():void {
//			if (_netConnection)
//				_netConnection.close();
//		}
		
		private function onConnect(e:NetStatusEvent):void {
			initSendStream();
			joinNetGroup();
			dispatchEvent(new P2PConnectionEvent(P2PConnectionEvent.ON_CONNECT, _netConnection.nearID));
		}
				
		private function onDisonnect():void {
//			txtMessages.text+="Disconnected\n";
//			netConnection=null;
//			netGroup=null;
//			connected=false;
//			joinedGroup=false;
		}
		
		private function joinNetGroup():void {
			var gs:GroupSpecifier = new GroupSpecifier(GROUP_ID);
			gs.postingEnabled=true;
			gs.serverChannelEnabled=true;
			netGroup=new NetGroup(_netConnection, gs.groupspecWithAuthorizations());
			netGroup.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
		}

		private function onNetGroupConnect():void {
			netGroup.post(new UserVO(MyUser.instance.name, MyUser.instance.peerID));
			//send(new UserVO(MyUser.instance.name, MyUser.instance.peerID));
		}
		
		private function onNetGroupNeighborConnect(e:NetStatusEvent):void {
//			if (SharedObject.getLocal("userData").data.hasOwnProperty("userName"))
			netGroup.post(new UserVO(MyUser.instance.name, MyUser.instance.peerID));
			//send(new UserVO(MyUser.instance.name, MyUser.instance.peerID));
			//dispatchEvent(new P2PConnectionEvent(P2PConnectionEvent.ON_NEIGHBOR_CONNECT,e.info.peerID));
		}
		
		private function onNetGroupNeighborDisconnect(e:NetStatusEvent):void {
			//dispatchEvent(new P2PConnectionEvent(P2PConnectionEvent.ON_NEIGHBOR_DISCONNECT,e.info.peerID));
		}
		
		public function post(vo:ValueObject):void {
			//message.sender=netConnection.nearID;
			vo.sequenceNumber = sequenceNumber++;
			netGroup.post(vo);
		}
		
		private function initSendStream():void{		
			sendStream = new NetStream(_netConnection,NetStream.DIRECT_CONNECTIONS);
			sendStream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			sendStream.client = this;
			sendStream.publish("data");
		}
		
		private function initRecvStream():void{
//			for(var i:uint=0;i<_users.length;i++){
//				recvStream = new NetStream(_netConnection,_users[i][1]);
//				recvStream.addEventListener(NetStatusEvent.NET_STATUS,netStatusHandler);
//				recvStream.client = this;
//				recvStream.play("data");
//			}
		}
		
		public function send(vo:ValueObject):Boolean{
			sendStream.send("receive",vo);
			return true;
		}
		
		private function receive(vo:ValueObject):void{
			dispatchEvent(new AMFDataEvent(AMFDataEvent.ON_RECEIVE_DATA, vo));
		}
		
		private function netStatusHandler(e:NetStatusEvent):void {
			dispatchEvent(e);
			Logger.instance.addLog("NetStatusEvent", e.info.code);
			switch (e.info.code) {
				case "NetConnection.Connect.Success":
					onConnect(e);
					break;
				case "NetConnection.Connect.Closed":
					onDisonnect();
					break;
				case "NetStream.Connect.Success":
					break;
				case "NetStream.Connect.Closed":
					break;
				case "NetGroup.Connect.Success":
					onNetGroupConnect();
					break;
				case "NetGroup.Connect.Failed":
					doConnect();
					break;
				case "NetGroup.Neighbor.Connect":
					onNetGroupNeighborConnect(e);
					break;
				case "NetGroup.Neighbor.Disconnect":
					onNetGroupNeighborDisconnect(e);
					break;
				case "NetGroup.Posting.Notify":
					receive(e.info.message);
					break;
				default:
					break;
			}
		}

		public function get nc():NetConnection{
			return _netConnection;
		}			
		
//		public function get myPeerID():String{
//			return _myPeerID;
//		}
	}
}

class SingletonEnforcer {}