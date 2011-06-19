package de.molehill.util
{
	import away3d.events.AssetEvent;
	import away3d.library.AssetLibrary;
	import away3d.loaders.parsers.Parsers;
	
	import de.molehill.data.Assets;
	import de.molehill.logger.Logger;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;

	public class GameAssetLoader extends EventDispatcher
	{
		private var _assets:Vector.<Vector.<String>>;
		private var _currentAsset:Vector.<String>;
		private static var _instance:GameAssetLoader; 
		
		public function GameAssetLoader(se : SingletonEnforcer)
		{
			_assets = new Vector.<Vector.<String>>();
			_currentAsset = new Vector.<String>();
			
			Parsers.enableAllBundled();
			AssetLibrary.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			init();
		}
		
		public static function get instance(): GameAssetLoader {
			if (_instance == null) _instance = new GameAssetLoader(new SingletonEnforcer());
			return _instance;
		}
		
		private function init():void {
//			_assets.push( Vector.<String>(["assets/gameObjects/tanks/neu.obj"                  ,Assets.TANK_MESH]));
//			_assets.push( Vector.<String>(["assets/gameObjects/tanks/help.jpg",Assets.TANK_TEXTURE]));
//			_assets.push( Vector.<String>(["assets/gameObjects/tanks/tank04_NM.jpg"                  ,Assets.TANK_NORMAL]));
			
			_assets.push( Vector.<String>(["assets/gameObjects/tanks/TankNeu01.obj"                  ,Assets.TANK_MESH]));
			_assets.push( Vector.<String>(["assets/gameObjects/tanks/tankBlue.jpg"					,Assets.TANK_TEXTURE_BLUE]));
			_assets.push( Vector.<String>(["assets/gameObjects/tanks/tankBlue.jpg"					,Assets.TANK_TEXTURE_BLUE]));
			_assets.push( Vector.<String>(["assets/gameObjects/tanks/tank04_NM.jpg"                  ,Assets.TANK_NORMAL]));
			
			_assets.push( Vector.<String>(["assets/gameObjects/buildings/Haus_1 _01.obj"                  ,Assets.BUILDING_MESH]));
			_assets.push( Vector.<String>(["assets/gameObjects/buildings/Haus_1_Textur.jpg",Assets.BUILDING_TEXTURE]));
			_assets.push( Vector.<String>(["assets/gameObjects/buildings/Haus_1_Bump.jpg"                  ,Assets.BUILDING_NORMAL]));
		}
		
		public function loadAssets():void {
			_currentAsset = _assets.pop();
			_instance.loadAsset(_currentAsset[0]);
		}

		private function loadAsset(url:String):void {
			AssetLibrary.load(new URLRequest(url));
		}
		
		protected function onAssetComplete(event:AssetEvent):void
		{
			event.asset.name = _currentAsset[1];
			Logger.instance.addLog("GameAssetLoader",event.asset.name);
			if(_assets.length > 0){
				_currentAsset = _assets.pop();
				loadAsset(_currentAsset[0]);	
			}
			else {
				dispatchEvent(new Event("GAME_ASSETS_LOADED"));
			}
		}
	}
}

// singleton enforcer
class SingletonEnforcer
{
}