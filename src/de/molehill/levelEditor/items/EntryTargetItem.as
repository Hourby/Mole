package de.molehill.levelEditor.items {

	import de.molehill.data.textures.BitmapTexture;

	public class EntryTargetItem extends MapItem {

		private var _type : uint;

		public function EntryTargetItem(size : uint, texture : BitmapTexture, type : uint) {
			_type = type;
			super(size, texture);
		}

		public function get type() : uint {
			return _type;
		}
	}
}
