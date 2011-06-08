package template.view.gameState {


	import flash.events.Event;

	public interface IGameState {
		function close():void;

		function addedToStageHandler(e:Event):void;
	}
}