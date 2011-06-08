package components.videoPhone {

	import de.molehill.data.user.MyUser;
	import de.molehill.data.user.User;
	import de.molehill.data.user.UserManager;
	import de.molehill.logger.Logger;
	import de.molehill.net.P2PConnectionEvent;
	import de.molehill.net.P2P_Manager;
	
	import flash.events.ActivityEvent;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SampleDataEvent;
	import flash.events.StatusEvent;
	import flash.events.TextEvent;
	import flash.events.TimerEvent;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundCodec;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.SharedObject;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	
	import mx.charts.chartClasses.StackedSeries;
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.events.ItemClickEvent;
	import mx.events.SliderEvent;
	import mx.formatters.DateFormatter;

	public class VideoPhoneModel extends EventDispatcher {
		
		private var netConnection:NetConnection;

		// after connection to rtmfp server, publish listener stream to wait for incoming call 
		private var listenerStream:NetStream;

		// caller's incoming stream that is connected to callee's listener stream
		private var controlStream:NetStream;

		// outgoing media stream (audio, video, text and some control messages)
		private var outgoingStream:NetStream;

		// incoming media stream (audio, video, text and some control messages)
		private var incomingStream:NetStream;

		private var _remoteVideo:Video;

		// login/registration state machine

		private var _loginState:int;

		private const LoginNotConnected:int = 0;
		private const LoginConnecting:int = 1;
		private const LoginConnected:int = 2;
		private const LoginDisconnecting:int = 3;

		// call state machine
		private var _callState:int;

		private const CallNotReady:int = 0;
		private const CallReady:int = 1;
		private const CallCalling:int = 2;
		private const CallRinging:int = 3;
		private const CallEstablished:int = 4;
		private const CallFailed:int = 5;

		// available microphone devices

		private var _micNames:Array;
		private var _micIndex:int = 0;

		private var _cameraNames:Array;

		private var cameraIndex:int = 0;

		private var activityTimer:Timer;

		// user name is saved in local shared object
		private var localSO:SharedObject;

		private var _remoteName:String = "";

		private var callTimer:int;
		
		private var _isSendAudio:Boolean;
		private var _isReceiveAudio:Boolean;
		
		private var _isSendVideo:Boolean;
		private var _isReceiveVideo:Boolean;


		private const defaultMacCamera:String = "USB Video Class Video";

		private var _p2pManager:P2P_Manager;
		private var _userManager:UserManager;

		private var _userNames:Array;
		private var ringer:Sound;
		private var ringerChannel:SoundChannel;

		private var _callPartner:User;

		public function VideoPhoneModel() {
			init();
		}
		
		// called when application is loaded            		
		private function init():void {
			_p2pManager = P2P_Manager.instance;
			_p2pManager.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusChange);

			_userManager = UserManager.instance;
			_userNames = _userManager.getUserNames();

			netConnection = _p2pManager.nc;

			_loginState = LoginConnected;
			_callState = CallNotReady;
			onChangeCallState(_callState);

			var mics:Array = Microphone.names;
			if (mics) {
				_micNames = mics;
			} else {
				changeStatus("No microphone available.\n");
			}

			var cameras:Array = Camera.names;
			if (cameras) {
				_cameraNames = cameras;
			} else {
				changeStatus("No camera available.\n");
			}

			// statistics timer
			activityTimer = new Timer(1000);
			activityTimer.addEventListener(TimerEvent.TIMER, onActivityTimer);
			activityTimer.start();

			localSO = SharedObject.getLocal("videoPhoneSettings");

			// selected mic device
			_micIndex = 0;
			if (localSO.data.hasOwnProperty("micIndex")) {
				_micIndex = localSO.data.micIndex;
			}

//			micSelection.selectedIndex = micIndex;

			// set Mac default camera
			if (Capabilities.os.search("Mac") != -1) {
				for (cameraIndex = 0; cameraIndex < cameras.length; cameraIndex++) {
					if (cameras[cameraIndex] == defaultMacCamera) {
						break;
					}
				}
			}

			// selected camera device
			if (localSO.data.hasOwnProperty("cameraIndex")) {
				cameraIndex = localSO.data.cameraIndex;
			}

//			cameraSelection.selectedIndex = cameraIndex;

			// mic volume
			var micVolume:int = 50;
			if (localSO.data.hasOwnProperty("micVolume")) {
				micVolume = localSO.data.micVolume;
			}

//			micVolumeSlider.value = micVolume;

			// speaker volume
			var speakerVolume:Number = 0.8;
			if (localSO.data.hasOwnProperty("speakerVolume")) {
				speakerVolume = localSO.data.speakerVolume;
			}

//			speakerVolumeSlider.value = speakerVolume;

			// configure audio and video
			var mic:Microphone = Microphone.getMicrophone(_micIndex);
			if (mic) {
				mic.codec = SoundCodec.SPEEX;
				mic.setSilenceLevel(0);
				mic.framesPerPacket = 1;
				mic.gain = micVolume;

				mic.addEventListener(StatusEvent.STATUS, onDeviceStatus);
				mic.addEventListener(ActivityEvent.ACTIVITY, onDeviceActivity);
			}

			var camera:Camera = Camera.getCamera(cameraIndex.toString());
			if (camera) {
				camera.addEventListener(StatusEvent.STATUS, onDeviceStatus);
				camera.addEventListener(ActivityEvent.ACTIVITY, onDeviceActivity);
				camera.setMode(320, 240, 15);
				camera.setQuality(0, 80);
			}

			completeRegistration();
		}

		private function changeStatus(msg:String):void {
			Logger.instance.addLog("VideoPhone", msg);
		}

		private function netConnectionHandler(e:NetStatusEvent):void {

			switch (e.info.code) {
				case "NetConnection.Connect.Closed":
					_loginState = LoginNotConnected;
					_callState = CallNotReady;
					onChangeCallState(_callState);
					break;

				case "NetStream.Connect.Success":
					changeStatus("Connection from: " + e.info.stream.farID + "\n");
					break;

				case "NetConnection.Connect.Failed":
					_loginState = LoginNotConnected;
					break;
				case "NetGroup.Neighbor.Connect":
					onNetGroupNeighborConnect(e);
					break;
				case "NetGroup.Neighbor.Disconnect":
					onNetGroupNeighborDisconnect(e);
					break;
				case "NetStream.Connect.Closed":
					onHangup();
					break;
			}
		}
		
		private function onNetGroupNeighborConnect(e:NetStatusEvent):void {
			dispatchEvent(new P2PConnectionEvent(P2PConnectionEvent.ON_NEIGHBOR_CONNECT,e.info.peerID));
		}
		
		private function onNetGroupNeighborDisconnect(e:NetStatusEvent):void {
			dispatchEvent(new P2PConnectionEvent(P2PConnectionEvent.ON_NEIGHBOR_DISCONNECT,e.info.peerID));
		}
		
		private function onChangeCallState(callState:int):void
		{
			dispatchEvent(new VideoPhoneEvent(VideoPhoneEvent.CALLSTATE_CHANGED,_callState));
		}

		private function listenerHandler(event:NetStatusEvent):void {
			changeStatus("Listener event: " + event.info.code + "\n");
		}

		private function controlHandler(event:NetStatusEvent):void {
			changeStatus("Control event: " + event.info.code + "\n");
		}

		private function outgoingStreamHandler(event:NetStatusEvent):void {
			changeStatus("Outgoing stream event: " + event.info.code + "\n");
			switch (event.info.code) {
				case "NetStream.Play.Start":
					if (callState == CallCalling) {
						outgoingStream.send("onIncomingCall", MyUser.instance.name);
					}
					break;
			}
		}

		private function incomingStreamHandler(event:NetStatusEvent):void {
			changeStatus("Incoming stream event: " + event.info.code + "\n");
			switch (event.info.code) {
				case "NetStream.Play.UnpublishNotify":
					onHangup();
					break;
			}
		}

		private function completeRegistration():void {
			// start the control stream that will listen to incoming calls
			listenerStream = new NetStream(netConnection, NetStream.DIRECT_CONNECTIONS);
			listenerStream.addEventListener(NetStatusEvent.NET_STATUS, listenerHandler);
			listenerStream.publish("control" + MyUser.instance.name);

			var c:Object = new Object();
			c.onPeerConnect = function(caller:NetStream):Boolean {
				changeStatus("Caller connecting to listener stream: " + caller.farID + "\n");

				if (callState == CallReady) {
					ring();

					_callState = CallRinging;
					onChangeCallState(_callState);

					// callee subscribes to media, to be able to get the remote user name
					incomingStream = new NetStream(netConnection, caller.farID);
					incomingStream.addEventListener(NetStatusEvent.NET_STATUS, incomingStreamHandler);
					incomingStream.play("media-caller");

					// set volume for incoming stream
					//var st:SoundTransform = new SoundTransform(speakerVolumeSlider.value);
					var st:SoundTransform = new SoundTransform();
					
					incomingStream.soundTransform = st;

					incomingStream.receiveAudio(false);
					incomingStream.receiveVideo(false);

					var i:Object = new Object;
					i.onIncomingCall = function(caller:String):void {
						if (callState != CallRinging) {
							changeStatus("onIncomingCall: Wrong call state: " + callState + "\n");
							return;
						}
						_remoteName = caller;

						changeStatus("Incoming call from: " + caller + "\n");
					}

					i.onIm = function(name:String, text:String):void {
						dispatchEvent(new VideoPhoneEvent(VideoPhoneEvent.INCOMING_MESSAGE, name + ": " + text + "\n"));
					}
					incomingStream.client = i;

					return true;
				}

				changeStatus("onPeerConnect: all rejected due to state: " + callState + "\n");

				return false;
			}

			listenerStream.client = c;

			_callState = CallReady;
			onChangeCallState(_callState);
		}

		private function placeCall(user:String, identity:String):void {
			changeStatus("Calling " + user + ", id: " + identity + "\n");

			if (identity.length != 64) {
				changeStatus("Invalid remote ID, call failed\n");
				_callState = CallFailed;
				onChangeCallState(_callState);
				return;
			}

			// caller subsrcibes to callee's listener stream 
			controlStream = new NetStream(netConnection, identity);
			controlStream.addEventListener(NetStatusEvent.NET_STATUS, controlHandler);
			controlStream.play("control" + user);

			// caller publishes media stream
			outgoingStream = new NetStream(netConnection, NetStream.DIRECT_CONNECTIONS);
			outgoingStream.addEventListener(NetStatusEvent.NET_STATUS, outgoingStreamHandler);
			outgoingStream.publish("media-caller");

			var o:Object = new Object
			o.onPeerConnect = function(caller:NetStream):Boolean {
				changeStatus("Callee connecting to media stream: " + caller.farID + "\n");

				return true;
			}
			outgoingStream.client = o;

			startAudio(true);
			startVideo(true);

			// caller subscribes to callee's media stream
			incomingStream = new NetStream(netConnection, identity);
			incomingStream.addEventListener(NetStatusEvent.NET_STATUS, incomingStreamHandler);
			incomingStream.play("media-callee");

			// set volume for incoming stream
//			var st:SoundTransform = new SoundTransform(speakerVolumeSlider.value);
			var st:SoundTransform = new SoundTransform();
			incomingStream.soundTransform = st;

			var i:Object = new Object;
			i.onCallAccepted = function(callee:String):void {
				if (callState != CallCalling) {
					changeStatus("onCallAccepted: Wrong call state: " + callState + "\n");
					return;
				}

				_callState = CallEstablished;
				onChangeCallState(_callState);

				changeStatus("Call accepted by " + callee + "\n");
			}
			i.onIm = function(name:String, text:String):void {
//				textOutput.text += name + ": " + text + "\n";
			}
			incomingStream.client = i;

			_remoteVideo = new Video();
			_remoteVideo.width = 320;
			_remoteVideo.height = 240;
			_remoteVideo.attachNetStream(incomingStream);
			dispatchEvent(new VideoPhoneEvent(VideoPhoneEvent.REMOTE_VIDEO, _remoteVideo));

			_remoteName = user;
			_callState = CallCalling;
			onChangeCallState(_callState);
		}

		// user clicked accept button
		public function acceptCall():void {
			stopRing();

			incomingStream.receiveAudio(true);
			incomingStream.receiveVideo(true);

			_remoteVideo = new Video();
			_remoteVideo.width = 320;
			_remoteVideo.height = 240;
			_remoteVideo.attachNetStream(incomingStream);
			dispatchEvent(new VideoPhoneEvent(VideoPhoneEvent.REMOTE_VIDEO, _remoteVideo));

			// callee publishes media
			outgoingStream = new NetStream(netConnection, NetStream.DIRECT_CONNECTIONS);
			outgoingStream.addEventListener(NetStatusEvent.NET_STATUS, outgoingStreamHandler);
			outgoingStream.publish("media-callee");

			var o:Object = new Object
			o.onPeerConnect = function(caller:NetStream):Boolean {
				changeStatus("Caller connecting to media stream: " + caller.farID + "\n");

				return true;
			}
			outgoingStream.client = o;

			outgoingStream.send("onCallAccepted", MyUser.instance.name);

			startVideo(true);
			startAudio(true);

			_callState = CallEstablished;
			onChangeCallState(_callState);
		}

		public function cancelCall():void {
			onHangup();
		}

		public function rejectCall():void {
			onHangup();
		}

		//			private function onDisconnect():void
		//			{
		//				changeStatus("Disconnecting.\n");
		//				
		//				onHangup();
		//				
		//				callState = CallNotReady;
		//								
		//				loginState = LoginNotConnected;
		//			}

		// placing a call
		private function onCall():void {
			placeCall(_callPartner.name, _callPartner.peerID);
		}

		public function startAudio(value:Boolean):void {
			_isSendAudio = value;
			if (_isSendAudio) {
				var mic:Microphone = Microphone.getMicrophone(_micIndex);
				if (mic && outgoingStream) {
					outgoingStream.attachAudio(mic);
				}
			} else {
				if (outgoingStream) {
					outgoingStream.attachAudio(null);
				}
			}
		}

		public function startVideo(value:Boolean):void {
			_isSendVideo = value;
			var camera:Camera;
			if (_isSendVideo) {
				camera = Camera.getCamera(cameraIndex.toString());
				if (camera) {
					if (outgoingStream) {
						outgoingStream.attachCamera(camera);
					}
				}
			} else {
				if (outgoingStream) {
					outgoingStream.attachCamera(null);
				}
			}
			dispatchEvent(new VideoPhoneEvent(VideoPhoneEvent.LOCAL_VIDEO, camera));
		}

		// this function is called in every second to update charts, microhone level, and call timer
		private function onActivityTimer(e:TimerEvent):void {
			var mic:Microphone = Microphone.getMicrophone(_micIndex);
			if (mic) {
				//trace("VideoPhoneViewLarge.onActivityTimer(e)" + mic.activityLevel.toString());
//				micActivityLabel.text = mic.activityLevel.toString();
			}

			if (callState == CallEstablished) {
				callTimer++;
				var elapsed:Date = new Date(2008, 4, 12);
				elapsed.setTime(elapsed.getTime() + callTimer * 1000);
				var formatter:DateFormatter = new DateFormatter();
				var format:String = "JJ:NN:SS";
				if (callTimer < 60) {
					format = "SS";
				} else if (callTimer < 60 * 60) {
					format = "NN:SS";
				}
				formatter.formatString = format
//				callTimerText.text = formatter.format(elapsed);
			}
		}

		private function onDeviceStatus(e:StatusEvent):void {
			changeStatus("Device status: " + e.code + "\n");
		}

		private function onDeviceActivity(e:ActivityEvent):void {
			//				status("Device activity: " + e.activating + "\n");
		}

		public function onHangup():void {
			changeStatus("Hanging up call\n");

			stopRing();

			//		calleeInput.text = "";
			_callState = CallReady;
			onChangeCallState(_callState);

			if (incomingStream) {
				incomingStream.close();
				incomingStream.removeEventListener(NetStatusEvent.NET_STATUS, incomingStreamHandler);
			}

			if (outgoingStream) {
				outgoingStream.close();
				outgoingStream.removeEventListener(NetStatusEvent.NET_STATUS, outgoingStreamHandler);
			}

			if (controlStream) {
				controlStream.close();
				controlStream.removeEventListener(NetStatusEvent.NET_STATUS, controlHandler);
			}

			incomingStream = null;
			outgoingStream = null;
			controlStream = null;

			_remoteName = "";

			_isReceiveAudio = true;
			_isReceiveVideo = true;

			callTimer = 0;
		}

		public function changeSpeakerVolume(volume:Number):void {
			if (incomingStream) {
				var st:SoundTransform = new SoundTransform(volume);
				incomingStream.soundTransform = st;

				changeStatus("Setting speaker volume to: " + volume + "\n");
			}

			localSO.data.speakerVolume = volume;
			localSO.flush();
		}

		public function changeMicVolume(volume:Number):void {
			var mic:Microphone = Microphone.getMicrophone(_micIndex);
			if (mic) {
				mic.gain = volume;
				localSO.data.micVolume = volume;
				localSO.flush();
				changeStatus("Setting mic volume to: " + volume + "\n");
			}
		}

		// sending text message
		public function sendMessage(msg:String):void {
			if (outgoingStream) {
				outgoingStream.send("onIm", MyUser.instance.name, msg);
			}
		}

		public function changeMic(value:int):void {
			var oldMicIndex:int = _micIndex;
			_micIndex = value;
			
			var mic:Microphone = Microphone.getMicrophone(_micIndex);
			var oldMic:Microphone = Microphone.getMicrophone(oldMicIndex);

			mic.codec = oldMic.codec;
			mic.rate = oldMic.rate;
			mic.encodeQuality = oldMic.encodeQuality;
			mic.framesPerPacket = oldMic.framesPerPacket;
			mic.gain = oldMic.gain;
			mic.setSilenceLevel(oldMic.silenceLevel);

			if (callState == CallEstablished) {
				outgoingStream.attachAudio(mic);
			}

			localSO.data.micIndex = _micIndex;
			localSO.flush();
		}

		public function changeCamera(value:int):void {
			var oldCameraIndex:int = cameraIndex;
			cameraIndex = value;

			var camera:Camera = Camera.getCamera(cameraIndex.toString());
			var oldCamera:Camera = Camera.getCamera(oldCameraIndex.toString());

			camera.setMode(320, 240, 15);
			camera.setQuality(0, oldCamera.quality);

			// when user changes video device, we want to show preview
//			localVideoDisplay.attachCamera(camera);

			if (callState == CallEstablished) {
				outgoingStream.attachCamera(camera);
			}

			localSO.data.cameraIndex = cameraIndex;
			localSO.flush();
		}

		public function changeVideoQuality(quality:Number):void {
			var camera:Camera = Camera.getCamera(cameraIndex.toString());
			if (camera) {
				camera.setQuality(0, quality);
				changeStatus("Setting camera quality to: " + quality + "\n");
			}
		}

		public function receiveAudio(value:Boolean):void {
			_isReceiveAudio = value;
			if (incomingStream) {
				incomingStream.receiveAudio(_isReceiveAudio);
			}
		}

		public function receiveVideo(value:Boolean):void {
			_isReceiveVideo = value;
			if (incomingStream) {
				incomingStream.receiveVideo(_isReceiveVideo);
			}
		}

		public function changeSpeexQuality(quality:int):void {
			var mic:Microphone = Microphone.getMicrophone(_micIndex);
			if (mic) {
				mic.encodeQuality = quality;
				changeStatus("Setting speex quality to: " + quality);
			}
		}

		private function ring():void {
			ringer = new Sound();
			ringer.addEventListener("sampleData", ringTone);
			ringerChannel = ringer.play();
		}

		private function stopRing():void {
			if (ringerChannel) {
				ringerChannel.stop();
				ringer.removeEventListener("sampleData", ringTone);
				ringer = null;
				ringerChannel = null;
			}
		}

		private function ringTone(event:SampleDataEvent):void {
			for (var c:int = 0; c < 8192; c++) {
				var pos:Number = Number(c + event.position) / Number(6 * 44100);
				var frac:Number = pos - int(pos);
				var sample:Number;
				if (frac < 0.066) {
					sample = 0.4 * Math.sin(2 * Math.PI / (44100 / 784) * (Number(c + event.position)));
				} else if (frac < 0.333) {
					sample = 0.2 * (Math.sin(2 * Math.PI / (44100 / 646) * (Number(c + event.position))) 
						+ Math.sin(2 * Math.PI / (44100 / 672) * (Number(c + event.position))) 
						+ Math.sin(2 * Math.PI / (44100 / 1034) * (Number(c + event.position))) 
						+ Math.sin(2 * Math.PI / (44100 / 1060) * (Number(c + event.position))));
				} else {
					sample = 0;
				}
				event.data.writeFloat(sample);
				event.data.writeFloat(sample);
			}
		}


		protected function onNetStatusChange(event:NetStatusEvent):void {
			netConnectionHandler(event);
		}

		public function callUser(userName:String):void {
			_callPartner = new User(userName, UserManager.instance.getPeerID(userName));
			placeCall(userName, UserManager.instance.getPeerID(userName));
		}

		public function get loginState():int
		{
			return _loginState;
		}

		public function get callState():int
		{
			return _callState;
		}

		public function get remoteName():String
		{
			return _remoteName;
		}

		public function get callPartner():User
		{
			return _callPartner;
		}

		public function get micNames():Array
		{
			return _micNames;
		}

		public function get cameraNames():Array
		{
			return _cameraNames;
		}


	}
}