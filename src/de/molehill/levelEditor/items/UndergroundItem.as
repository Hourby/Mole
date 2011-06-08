package de.molehill.levelEditor.items {
	
	import de.molehill.data.textures.BitmapTexture;

	public class UndergroundItem extends MapItem {
		
		private var _texture:BitmapTexture;
		private var _undergroundType:uint;


		public function UndergroundItem(size:uint, texture:BitmapTexture, undergroundType:uint) {
			width = size;
			height = size;
			name = texture.name;
			source = texture;
			_undergroundType = undergroundType;
		}

		
		public function get undergroundType():uint
		{
			return _undergroundType;
		}

		public function get texture():BitmapTexture
		{
			return source as BitmapTexture;
		}
		
		
	}
}
