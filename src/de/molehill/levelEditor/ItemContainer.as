package de.molehill.levelEditor
{
	import de.molehill.data.textures.BitmapTexture;
	import de.molehill.levelEditor.items.MapItem;
	import de.molehill.levelEditor.items.UndergroundItem;
	import de.molehill.levelEditor.items.UndergroundType;
	
	import flash.events.MouseEvent;
	
	import spark.components.Group;
	import spark.components.NavigatorContent;
	import spark.components.Scroller;
	
	public class ItemContainer extends NavigatorContent
	{
		private var _tileSize:uint;
		private var _textureManager:TextureManager;
		
		public function ItemContainer(navLabel:String, textureIndexStart:uint, textureIndexCount:uint)
		{
			super();
			label = navLabel;
			_tileSize = 64;
			_textureManager = TextureManager.instance;
			init(textureIndexStart, textureIndexCount);
		}
					
		private function init(textureIndexStart:uint, textureIndexCount:uint):void
		{
			var scroller:Scroller = new Scroller();
			scroller.percentWidth = 100;
			scroller.percentHeight = 100;
			var group:Group = new Group();
			scroller.viewport = group;
			
			var item:MapItem;
			var texture:BitmapTexture;

			for (var i:uint = 0; i < textureIndexCount; i++) 
			{
				texture = _textureManager.getTextureByID(i+textureIndexStart);
				texture.name = _textureManager.getTextureByID(i+textureIndexStart).name;
				item = new UndergroundItem(_tileSize,texture,UndergroundType.STREET);
				item.addEventListener(MouseEvent.CLICK, setCurrentItem);
				item.x = i*70 % 140;
				item.y = Math.floor(i/2) * 70
				group.addElement(item);	
			}	
			
			addElement(scroller);
		}
		
		private function setCurrentItem(e:MouseEvent):void {
			var item:MapItem = (e.currentTarget as MapItem);
			dispatchEvent(new ItemEvent(ItemEvent.SELCECT,item));
		}
	}
}