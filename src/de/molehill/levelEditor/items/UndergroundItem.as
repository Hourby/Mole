package de.molehill.levelEditor.items {

	import de.molehill.data.textures.BitmapTexture;

	public class UndergroundItem extends MapItem {

		private var _undergroundType : uint;

		public function UndergroundItem(size : uint, texture : BitmapTexture, undergroundType : uint) {
			_undergroundType = undergroundType;
			super(size, texture);
		}

		public function get undergroundType() : uint {
			return _undergroundType;
		}
	}
}
