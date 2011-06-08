package de.molehill.data.user {
	
	import de.molehill.logger.Logger;

	internal class UserModel {

		private var _userVector:Vector.<UserVO>;

		public function UserModel() {
			_userVector = new Vector.<UserVO>();
		}
		
		public function addUser(userVO:UserVO):Boolean {
			var userWasAdded:Boolean = false;
			var index:int = _userVector.indexOf(userVO);
			if(index < 0){
				Logger.instance.addLog("UserModel", "User added");
				_userVector.push(userVO);
				userWasAdded = true;
			}
			else {
				Logger.instance.addLog("UserModel", "User allready exist");
			}
			return userWasAdded;
		}
		
		public function removeUser(userPeerId:String):Boolean {
			var userWasRemoved:Boolean = false;
			for (var i:uint=0; i<_userVector.length; i++) {
				if(_userVector[i].peerID == userPeerId){
					_userVector.splice(i, 1);
					Logger.instance.addLog("UserModel", "User was removed");
					userWasRemoved = true;
					return userWasRemoved;
				}
			}
			Logger.instance.addLog("UserModel", "User doesnt exist, cant remove");
			return userWasRemoved;
		}
		
		public function getUserNames():Array {
			var userNames:Array = new Array();
			for each (var userVO:UserVO in _userVector) {
				userNames.push(userVO.name);
			}
			return userNames;
		}
		
		public function getPeerID(name:String):String {
			for each (var userVO:UserVO in _userVector) {
				if(userVO.name == name)
					return userVO.peerID;
			}
			return null;
		}

		public function get userVector():Vector.<UserVO> { return _userVector;}
	}
}