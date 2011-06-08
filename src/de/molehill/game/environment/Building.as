package de.molehill.game.environment
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.BitmapDataAsset;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.methods.BasicDiffuseMethod;
	import away3d.materials.methods.BasicSpecularMethod;
	import away3d.materials.methods.FresnelSpecularMethod;
	
	import de.molehill.data.Assets;
	
	import flash.events.Event;
	
	public class Building extends ObjectContainer3D 
	{		
		private var _diffuseMethod : BasicDiffuseMethod;
//		private var _fresnelMethod : FresnelSpecularMethod;
//		private var _specularMethod : BasicSpecularMethod;
		private var _material : BitmapMaterial;
		
		public function Building()
		{

		}

		public function initialize(lights:Array) : void
		{					
			var asset:BitmapDataAsset  = AssetLibrary.getAsset(Assets.BUILDING_TEXTURE) as BitmapDataAsset;
			var normal:BitmapDataAsset = AssetLibrary.getAsset(Assets.BUILDING_NORMAL) as BitmapDataAsset;
			
			_material = new BitmapMaterial(asset.bitmapData.clone());
			
			_diffuseMethod  = new BasicDiffuseMethod();
//			_fresnelMethod  = new FresnelSpecularMethod(true);
//			_specularMethod = new BasicSpecularMethod();
			
//			_material.normalMap = normal.bitmapData.clone();
			_material.lights = lights;
			//_material.gloss = 10;
			//_material.specular = 3;
			_material.ambientColor = 0x303040;
			//_material.specularMethod = _fresnelMethod;
			
			var mesh:Mesh = Mesh(AssetLibrary.getAsset(Assets.BUILDING_MESH));
			mesh = mesh.clone() as Mesh;
			mesh.material = _material;
			//scale(5);
			mesh.mouseEnabled = true;
			//mesh.castsShadows = true;
			addChild(mesh);
		}
	}
}