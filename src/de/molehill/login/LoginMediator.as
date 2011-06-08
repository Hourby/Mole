package de.molehill.login {

	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	import org.robotlegs.mvcs.Mediator;

	public class LoginMediator extends Mediator {

		[Inject]
		public var view:LoginView;

		override public function onRegister():void {
			eventMap.mapListener(view.loginButton, MouseEvent.CLICK, loginButton_clickHandler);
			//addContextListener(LoggResultEvent.RESULT, handleLogResultEvent);
			//dispatch(new UserEvent(UserEvent.ADD_LOG,"UserGridMediator","onRegister"));
		}
		

		private function loginButton_clickHandler(e:MouseEvent):void {
			dispatch(new LoginEvent(LoginEvent.LOGIN,view.textInputName.text, view.textInputPW.text));
		}
	}
}