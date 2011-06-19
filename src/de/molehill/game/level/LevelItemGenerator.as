package de.molehill.game.level
{
	import away3d.materials.BitmapMaterial;
	import away3d.primitives.Plane;
	
	import de.molehill.game.environment.Building;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public class LevelItemGenerator
	{
		[Embed(source = "assets/textures/underground/levelTexture.jpg")]
		private var Albedo : Class;
		private var _lights:Array;
		private var _view:LevelView;
		
		public function LevelItemGenerator(view:LevelView, lights:Array)
		{
			_view = view;
			_lights = lights;
		}
		
		public function initTerrain(size : uint, tileSize : uint) : void {
			var material : BitmapMaterial;
			material = new BitmapMaterial(new Albedo().bitmapData);
			material.ambientColor = 0x202030;
			
			var underground : Plane = new Plane(material, size * tileSize, size * tileSize);
			underground.pitch(90);
			underground.x = size * 0.5 * tileSize - tileSize * 0.5;
			underground.z = size * 0.5 * tileSize - tileSize * 0.5;
			_view.addChild(underground);
			
			var bmpData : BitmapData = new BitmapData(512, 512, false, 0x000000);
			bmpData.fillRect(new Rectangle(8, 8, 240, 496), 0x00FF00);
			bmpData.fillRect(new Rectangle(264, 8, 240, 496), 0x00FF00);
			material = new BitmapMaterial(bmpData);
			material.bothSides = true;
			
			var centerX : Plane = new Plane(material, 1000, 1000);
			centerX.yaw(90);
			_view.addChild(centerX);
			
			var centerZ : Plane = new Plane(material, 1000, 1000);
			_view.addChild(centerZ);
		}
		
		public function initBuildings() : void {
			var building : Building = new Building();
			building.x = 500;
			building.z = 500;
			building.initialize(_lights);
			_view.addChild(building);
		}
	}
}