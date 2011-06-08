package de.molehill.game.level {
	
	import away3d.containers.ObjectContainer3D;
	
	import de.molehill.game.map.field.Field;
	
	import flash.display.BitmapData;
	import flash.events.Event;

	public class LevelView extends ObjectContainer3D {
		
		public function LevelView() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init() : void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}
		
		protected function handleEnterFrame(event:Event):void
		{
			trace("LevelView.handleEnterFrame(event)");
			
		}
		
		public function showFields(fields : Vector.<Field>) : void {
			for each (var field : Field in fields) {
				field.view.render();
				addChild(field.view);
				field.view.x = field.position.x * field.view.width;
				field.view.z = field.position.y * field.view.height;
			}
		}
	}
}