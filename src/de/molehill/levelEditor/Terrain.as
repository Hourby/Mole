package de.molehill.levelEditor
{
	import de.molehill.data.textures.BitmapTexture;
	import de.molehill.levelEditor.items.MapItem;
	import de.molehill.levelEditor.items.UndergroundItem;
	import de.molehill.levelEditor.items.UndergroundType;
	
	import flash.events.MouseEvent;
	
	import spark.components.NavigatorContent;
	
	public class Terrain extends NavigatorContent
	{
		private var _tileSize:uint;
		private var _textureManager:TextureManager;
		
		public function Terrain()
		{
			super();
			label = "Terrain";
			_tileSize = 64;
			_textureManager = TextureManager.instance;
			init();
		}
		
		private function init():void
		{
			
			var item:MapItem;
			var texture:BitmapTexture;

			for (var i:int = 0; i < 4; i++) 
			{
				texture = _textureManager.getTextureByID(i);
				texture.name = _textureManager.getTextureByID(i).name;
				item = new UndergroundItem(_tileSize,texture,UndergroundType.WOOD);
				item.addEventListener(MouseEvent.CLICK, setCurrentItem);
				item.x = i*70 % 140;
				item.y = Math.floor(i/2) * 70
				addElement(item);
			}			
		}
		
		private function setCurrentItem(e:MouseEvent):void {
			var item:MapItem = (e.currentTarget as MapItem);
			dispatchEvent(new ItemEvent(ItemEvent.SELCECT,item));
		}
	}
}