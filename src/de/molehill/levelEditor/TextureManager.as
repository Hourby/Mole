package de.molehill.levelEditor {

	import de.molehill.data.textures.BitmapTexture;
	import de.molehill.logger.Logger;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import mx.core.Singleton;
	
	public final class TextureManager extends EventDispatcher{

		private static var _instance:TextureManager; 
		
		private var _textureContainer:Vector.<BitmapTexture>;
		private var _texturePaths:Vector.<String>;
		private var _currentImageName:String;

		public function TextureManager(singletonEnforcer:SingletonEnforcer) {
			
		}
		
		public function loadTextures():void {
			init();
			configureAssets();
		}
		
		public static function get instance(): TextureManager {
			if (TextureManager._instance == null) TextureManager._instance = new TextureManager(new SingletonEnforcer());
			return TextureManager._instance;
		}

		private function init():void {
			_texturePaths = new Vector.<String>();
			
			_texturePaths.push("TargetField_128.png");
			_texturePaths.push("Startfield_128.png");
			
			_texturePaths.push("Street_Cross_128.png");
			_texturePaths.push("Street_Curve_128_4.png");
			_texturePaths.push("Street_Curve_128_3.png");
			_texturePaths.push("Street_Curve_128_2.png");
			_texturePaths.push("Street_Curve_128_1.png");
			_texturePaths.push("Street_Vertical_128.png");
			_texturePaths.push("Street_Horizontal_128.png");
			
			_texturePaths.push("UndergroundGrass.png");
			_texturePaths.push("UndergroundGrassAndSand.png");
			_texturePaths.push("UndergroundSandGrass01.png");
			_texturePaths.push("UndergroundSandGrass02.png");
			
			
			_texturePaths.push("TargetField_64.png");
			_texturePaths.push("Startfield_64.png");
			
			_texturePaths.push("Street_Cross_64.png");
			_texturePaths.push("Street_Curve_64_4.png");
			_texturePaths.push("Street_Curve_64_3.png");
			_texturePaths.push("Street_Curve_64_2.png");
			_texturePaths.push("Street_Curve_64_1.png");
			_texturePaths.push("Street_Vertical_64.png");
			_texturePaths.push("Street_Horizontal_64.png");
						
			_texturePaths.push("UndergroundGrass_64.png");
			_texturePaths.push("UndergroundGrassAndSand_64.png");
			_texturePaths.push("UndergroundSandGrass01_64.png");
			_texturePaths.push("UndergroundSandGrass02_64.png");
		}

		private function configureAssets():void {
			_textureContainer = new Vector.<BitmapTexture>();
			_currentImageName = _texturePaths.pop();
			loadTexture(_currentImageName);
		}
		
		private function loadTexture(url:String):void {
			url = "assets/textures/" + url;
			var request:URLRequest = new URLRequest(url);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.load(request);
		}

		private function completeHandler(event:Event):void {
			var loader:Loader = Loader(event.target.loader);
			var bmp:Bitmap = Bitmap(loader.content);
			var image:BitmapTexture = new BitmapTexture(bmp.bitmapData);
			image.name = _currentImageName;
			_textureContainer.push(image);
			if(_texturePaths.length > 0) {
				Logger.instance.addLog("TextureManager", "Textures loaded: " + _textureContainer.length);
				_currentImageName = _texturePaths.pop();
				loadTexture(_currentImageName);
			} 
			else {
				dispatchEvent(new Event("TEXTURE_LOAD_COMPLETE"));
				Logger.instance.addLog("TextureManager", "Textures loaded: " + _textureContainer.length);
				Logger.instance.addLog("TextureManager", "TEXTURE_LOAD_COMPLETE");
			}
		}
		
		public function getTextureByID(position:uint):BitmapTexture {
			return _textureContainer[position];
		}
		
		public function getTextureByName(name:String):BitmapTexture {
			for each (var texture:BitmapTexture in _textureContainer) {
				if(texture.name == name)
					return texture;
			}
			return null;
		}

		private function ioErrorHandler(event:IOErrorEvent):void {
			// dateiname hinzufügen
			trace("Unable to load image");
		}

		private function duplicateImage(original:Bitmap):Bitmap {
			var image:Bitmap = new Bitmap(original.bitmapData.clone());
			return image;
		}
	}
}

class SingletonEnforcer {}