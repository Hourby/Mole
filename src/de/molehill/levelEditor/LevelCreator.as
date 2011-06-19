package de.molehill.levelEditor {
	
	public final class LevelCreator{		
		
		private static var _instance:LevelCreator; 
		
		public function LevelCreator(singleton:Singleton) {
			
		}
		
		public static function get instance(): LevelCreator {
			if (LevelCreator._instance == null) LevelCreator._instance = new LevelCreator(new Singleton());
			return LevelCreator._instance;
		}
		
		public function name():void {
			
		}
	}
}

class Singleton {}