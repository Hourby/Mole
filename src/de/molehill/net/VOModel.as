package de.molehill.net {
	
	import de.molehill.model.valueObjects.ValueObject;
	import de.molehill.data.user.UserEvent;
	import de.molehill.user.UserVO;
	
	import mx.collections.ArrayList;
	
	import org.robotlegs.mvcs.Actor;

	public class VOModel extends Actor{

		public function VOModel() {
		}
		
		public function addVO(vo:ValueObject):void {
			if(vo is UserVO) dispatch(new UserEvent(UserEvent.ADD_USER,vo as UserVO));
		}		
	}
}