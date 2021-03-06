package de.molehill.levelEditor {
	
	import de.molehill.data.textures.BitmapTexture;
	import de.molehill.levelEditor.items.BuildingItem;
	import de.molehill.levelEditor.items.EntryTargetItem;
	import de.molehill.levelEditor.items.MapItem;
	import de.molehill.levelEditor.items.UndergroundItem;
	
	import flash.events.MouseEvent;
	
	import spark.components.Group;
	import spark.components.NavigatorContent;
	import spark.components.Scroller;

	public class ItemContainer extends NavigatorContent {
		
		private var _tileSize : uint;
		private var _textureManager : TextureManager;

		public function ItemContainer(itemType:String, navLabel : String, type : uint, textureIndexStart : uint, textureIndexCount : uint) {
			super();
			label = navLabel;
			_tileSize = 64;
			_textureManager = TextureManager.instance;
			init(itemType, type, textureIndexStart, textureIndexCount);
		}

		private function init(itemType:String, type : uint, textureIndexStart : uint, textureIndexCount : uint) : void {
			var scroller : Scroller = new Scroller();
			scroller.percentWidth = 100;
			scroller.percentHeight = 100;
			var group : Group = new Group();
			scroller.viewport = group;

			var item : MapItem;
			var texture : BitmapTexture;

			for (var i : uint = 0; i < textureIndexCount; i++) {
				texture = _textureManager.getTextureByID(i + textureIndexStart);
				texture.name = _textureManager.getTextureByID(i + textureIndexStart).name;
				item = getMapItem(itemType, _tileSize, texture, type);
				item.addEventListener(MouseEvent.CLICK, setCurrentItem);
				item.x = i * 70 % 140;
				item.y = Math.floor(i / 2) * 70
				group.addElement(item);
			}

			addElement(scroller);
		}
		
		private function getMapItem(itemType:String, _tileSize:uint, texture:BitmapTexture, type:uint):MapItem
		{
			var item:MapItem;
			switch(itemType)
			{
				case ItemType.TERRAIN:
					item = new UndergroundItem(_tileSize, texture, type);
					break;
				case ItemType.STREET:
					item = new UndergroundItem(_tileSize, texture, type);
					break;
				case ItemType.BUILDING:
					item = new BuildingItem(_tileSize, texture, type);
					break;
				case ItemType.ENTRY_TARGET:
					item = new EntryTargetItem(_tileSize, texture, type);
					break;
				default:
					throw(new Error("Problems in ItemContainer.getMapItem"));
					break;
			}
			return item;
		}
		
		private function setCurrentItem(e : MouseEvent) : void {
			var item : MapItem = (e.currentTarget as MapItem);
			dispatchEvent(new ItemEvent(ItemEvent.SELCECT, item));
		}
	}
}
