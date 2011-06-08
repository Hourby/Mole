package de.molehill.game.army
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
	
	public class ArmyView extends ObjectContainer3D {
		
		private var _meshContainer:ObjectContainer3D;
		
		private var _diffuseMethod : BasicDiffuseMethod;
		private var _fresnelMethod : FresnelSpecularMethod;
		private var _specularMethod : BasicSpecularMethod;
		private var _material : BitmapMaterial;
		
		public function ArmyView()
		{
			_meshContainer = new ObjectContainer3D();
			_meshContainer
			super();
		}
		
		
		
		public function onTargetOnEnemy():void
		{
			// TODO Auto Generated method stub
			
		}
				
		protected function onMouseOver(event:Event):void
		{
			dispatchEvent(event);
		}
	}
}