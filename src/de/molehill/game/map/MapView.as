package de.molehill.game.map {
	
	import away3d.containers.ObjectContainer3D;
	
	import de.molehill.game.map.field.Field;
	import de.molehill.game.map.field.FieldView;
	
	import flash.display.BitmapData;

	public class MapView extends ObjectContainer3D {
		
		public function MapView() {
			y = 2;
		}

		public function showFields(fields : Vector.<Field>) : void {
			for each (var field : Field in fields) {
				field.view.render();
				addChild(field.view);
				field.view.x = field.position.x * field.view.width;
				field.view.z = field.position.y * field.view.height;
			}
		}
		
		public function hideFields(fields:Vector.<Field>):void {
			for each (var field : Field in fields) {
				removeChild(field.view);
				field.view = new FieldView(); 
			}
		}
	}
}