package de.molehill.game.map.field {

	import away3d.materials.BitmapMaterial;
	import away3d.primitives.Plane;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public class FieldView extends Plane {
		
		public function FieldView() {
			mouseEnabled = true;
			pitch(90);
			width = 500;
			height = 500;
			var bmpData : BitmapData = new BitmapData(128, 128, false, 0x000000);
			bmpData.fillRect(new Rectangle(6, 6, 500, 500), 0xFF0000);
			material = new BitmapMaterial(bmpData);
			(material as BitmapMaterial).alpha = 0.5;
		}
	}
}
