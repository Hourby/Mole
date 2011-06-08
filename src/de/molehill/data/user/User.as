package de.molehill.data.user {
	
	public class User { 
		
		private var _name:String;
		private var _peerID:String;
		
		public function User(name:String, peerID:String){
			_name = name;
			_peerID = peerID;
		}

		public function get name():String{
			return _name;
		}

		public function get peerID():String{
			return _peerID;
		}
	}
}
