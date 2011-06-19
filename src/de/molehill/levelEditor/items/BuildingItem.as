package de.molehill.levelEditor.items {

	import de.molehill.data.textures.BitmapTexture;

	public class BuildingItem extends MapItem {

		private var _buildingType : uint;

		public function BuildingItem(size : uint, texture : BitmapTexture, buildingType : uint) {
			_buildingType = buildingType;
			super(size, texture);
		}

		public function get undergroundType() : uint {
			return _buildingType;
		}
	}
}
