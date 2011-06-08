package de.molehill.game.units {
	
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.BitmapDataAsset;
	import away3d.loaders.Loader3D;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.methods.BasicDiffuseMethod;
	import away3d.materials.methods.BasicSpecularMethod;
	import away3d.materials.methods.FresnelSpecularMethod;

	import de.molehill.data.Assets;

	import flash.events.Event;

	public class Tank extends Unit {
		
		public function Tank(id:uint, lifePoints:uint, actionPoints:uint, attack:uint, defence:uint, range:uint) {
			super(id, lifePoints, actionPoints, attack, defence, range);
		}
	}
}
