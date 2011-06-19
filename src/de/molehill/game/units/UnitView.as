package de.molehill.game.units
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
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	
	public class UnitView extends ObjectContainer3D implements IMeshComponent
	{		
		private var _diffuseMethod : BasicDiffuseMethod;
		private var _fresnelMethod : FresnelSpecularMethod;
		private var _specularMethod : BasicSpecularMethod;
		private var _material : BitmapMaterial;
		
		public function UnitView()
		{
			y = 5;
			
		}
		
		public function addMesh(mesh:IMeshComponent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function getMeshByName(name:String):IMeshComponent
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function get meshName():String
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function set meshName(value:String):void
		{
			// TODO Auto Generated method stub
			
		}
		
		
		public function onFire():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function onMoveBackward():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function onMoveForward():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function onTargetOnEnemy():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function removeMesh(mesh:IMeshComponent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function initMesh(lights:Array) : void
		{					
			var asset:BitmapDataAsset  = AssetLibrary.getAsset(Assets.TANK_TEXTURE_BLUE) as BitmapDataAsset;
			var normal:BitmapDataAsset = AssetLibrary.getAsset(Assets.TANK_NORMAL) as BitmapDataAsset;
			
			
			var bmd:BitmapData = asset.bitmapData.clone();
			bmd.colorTransform(new Rectangle( 10,10,200,200),new ColorTransform(1, 1, 1, 1, 1, 1, -25, 50));
//			var ct:ColorTransform = new ColorTransform
//			bmd.colorTransform(new Rectangle( 10,10,200,200),
			_material = new BitmapMaterial(bmd);
			//_material = new BitmapMaterial(asset.bitmapData.clone());
			
			_diffuseMethod  = new BasicDiffuseMethod();
			_fresnelMethod  = new FresnelSpecularMethod(true);
			_specularMethod = new BasicSpecularMethod();
			
			//_material.normalMap = normal.bitmapData.clone();
			_material.lights = lights;
			_material.gloss = 10;
			_material.specular = 3;
			_material.ambientColor = 0x303040;
			_material.specularMethod = _fresnelMethod;
			
			var mesh:Mesh = Mesh(AssetLibrary.getAsset(Assets.TANK_MESH));
			mesh = mesh.clone() as Mesh;
			mesh.material = _material;
			mesh.addEventListener(MouseEvent3D.MOUSE_OVER, onMouseOver);
			mesh.addEventListener(MouseEvent3D.CLICK, onMouseClick);
			mesh.mouseEnabled = true;
			mesh.rotationY = 180;
			//mesh.castsShadows = true;
			addChild(mesh);
		}		
		
		protected function onMouseClick(event:Event):void
		{
			dispatchEvent(event);
		}
		
		protected function onMouseOver(event:Event):void
		{
			dispatchEvent(event);
		}
	}
}