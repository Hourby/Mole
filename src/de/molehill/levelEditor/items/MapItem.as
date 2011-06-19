package de.molehill.levelEditor.items
{
	import de.molehill.data.textures.BitmapTexture;
	
	import spark.components.Image;

	public class MapItem extends Image
	{
		private var _texture:BitmapTexture;
		
		public function MapItem(size:uint, texture:BitmapTexture) {
			width = size;
			height = size;
			name = texture.name;
			source = texture;
		}
		
		public function get texture() : BitmapTexture {
			return source as BitmapTexture;
		}
	}
}