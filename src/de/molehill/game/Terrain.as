package de.molehill.game
{
	import away3d.extrusions.Elevation;

	public class Terrain extends Elevation
	{
		public function Terrain()
		{
		}
		
		private function initComponents():void {					
			var material : BitmapMaterial;
			material = new BitmapMaterial(new Albedo().bitmapData);
			material.normalMap = new Normals().bitmapData;
			material.ambientColor = 0x202030;
			material.specular = .2;
			
			var heightMapData:BitmapData = new BitmapData(512,512,false,0xCCCCCC);
			_terrain = new Elevation(material, new HeightMap().bitmapData, 5000, 1300, 5000, 175, 175, 100);
			_terrain.y += 200;		
			
			var bmpData:BitmapData = new HeightMap().bitmapData;
			
			trace(bmpData.getPixel(0,0));
			
			_view.scene.addChild(_terrain);
			
			_view.stage.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}
	}
}