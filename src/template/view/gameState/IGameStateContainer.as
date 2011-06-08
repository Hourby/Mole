package template.view.gameState {



	public interface IGameStateContainer {

		/**
		 * The concrete class have to generate states for each
		 * String in the vector. The name of the state should be
		 * the string content.
		 */
		function createStates(gameStates:Vector.<IGameState>):void;


	}
}