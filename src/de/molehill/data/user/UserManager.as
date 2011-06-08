package de.molehill.data.user {
	
	import flash.events.EventDispatcher;

public final class UserManager extends EventDispatcher{		

 		private static var _instance:UserManager; 
		private var _model:UserModel;
		 
		public function UserManager(singleton:SingletonEnforcer) {
			_model = new UserModel();
		}
		
		public static function get instance(): UserManager {
 			if (UserManager._instance == null) UserManager._instance = new UserManager(new SingletonEnforcer());
			return UserManager._instance;
 		}
		
		public function addUser(userVO:UserVO):void {
			var newUserWasAdded:Boolean = _model.addUser(userVO);
			if(newUserWasAdded)
				dispatchEvent(new UserEvent(UserEvent.CHANGE));
		}
		
		public function removeUser(userPeerId:String):void {
			var userWasRemoved:Boolean = _model.removeUser(userPeerId);
			if(userWasRemoved)
				dispatchEvent(new UserEvent(UserEvent.CHANGE));
		}
		
		public function get userlist():Vector.<UserVO> {
			return _model.userVector;
		}
		
		public function getUserNames():Array {
			return _model.getUserNames();
		}
		
		public function getPeerID(userName:String):String {
			return _model.getPeerID(userName);
		}
	}
}

class SingletonEnforcer {}