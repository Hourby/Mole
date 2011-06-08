package de.molehill.game
{
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.materials.BitmapMaterial;
	
	import flash.net.URLRequest;
	
	import flashx.textLayout.formats.WhiteSpaceCollapse;
	
	public class GameObject3D
	{	
		private var _assetsVector:Vector.<String>;
		protected var _name:String;
		private var _material:BitmapMaterial;
		
		private var _mesh:Mesh;
		
		public function GameObject3D(objURL:String, name:String, textureURL:String, normalURL:String, specularURL:String)
		{
			_name = name;
			super();
			AssetLibrary.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			AssetLibrary.addEventListener(away3d.events.LoaderEvent.RESOURCE_COMPLETE, onResourceRetrieved);
			_assetsVector = new Vector.<String>();
			_assetsVector.push(objURL);
			_assetsVector.push(textureURL);
			_assetsVector.push(normalURL);
			_assetsVector.push(specularURL);
			loadAssets(_assetsVector);
		}
		
		private function loadAssets(_assetsVector:Vector.<String>):void
		{
			
			while(_assetsVector.length > 0){
				var urlRequest:URLRequest = new URLRequest(_assetsVector.pop());
				AssetLibrary.load(urlRequest);
			}
			
		}
		
		protected function onResourceRetrieved(event:away3d.events.LoaderEvent):void
		{
			trace("WorldTest.onResourceRetrieved(event)" + event.url);
			
		}
		
		protected function onAssetComplete(event:AssetEvent):void
		{
			if(event.asset.assetType == AssetType.MESH){
				(event.asset as Mesh).name = _name;
				trace("GameObject3D.onAssetComplete(event)", _name);
			}
			if(_assetsVector.length == 0)
			_mesh:Mesh = AssetLibrary.getAsset("obj0") as Mesh;			
			_view.scene.addChild(mesh);
			_mesh.material = _material;
			_mesh.addEventListener(MouseEvent3D.MOUSE_OVER, onMouseOver);
			_mesh.mouseEnabled = true;
			_mesh.y = 500;
		}

		public function get mesh():Mesh
		{
			return _mesh;
		}

		public function set mesh(value:Mesh):void
		{
			_mesh = value;
		}

	}
}