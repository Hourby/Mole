package de.molehill.levelEditor
{
	import components.ScrollableGroup;
	
	import de.molehill.game.map.field.Field;
	import de.molehill.levelEditor.items.UndergroundType;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.events.FlexEvent;
	
	import spark.components.NavigatorContent;
	
	public class LevelEditorView extends ScrollableGroup
	{
		private var _fields:Vector.<Vector.<QuadField>>;
		private var _currentField:QuadField;
		
		private var _tileSize:uint;
		
		private var _textureManager:TextureManager;

		private var _rows:uint;

		private var _columns:uint;
		
		public function LevelEditorView()
		{
			super();
			init();
		}
		
		private function init():void {
			_tileSize = 64;
			_textureManager = TextureManager.instance;
		}
		
		public function buildMap(levelName:String, rows:uint,columns:uint):void {
			_rows = rows;
			_columns = columns;
			initTileContainer(rows,columns);
			
			var container:Sprite = new Sprite();
			var field:QuadField;
			var view:Sprite;
			for (var j:uint=0; j < rows; j++) {
				for (var i:uint=0; i < columns; i++) {
					field=new QuadField(new Point(j,i),_tileSize, _tileSize);
					field.addEventListener(LevelEditorFieldEvent.ON_MOUSE_CLICK, onFieldClicked);
					_fields[j][i]= field;
					field.setUndergroundMaterial(_textureManager.getTextureByID(0).bitmapData);
					field.type = UndergroundType.WOOD;
					view = field.view;
					view.width = _tileSize;
					view.height = _tileSize;
					view.x = i * view.width;
					view.y = j * view.height;
					container.addChild(view);
				}
			}
			addSprite(container);
		}
		
		private function initTileContainer(rows:uint,columns:uint):void {
			var field:QuadField;
			_fields = new Vector.<Vector.<QuadField>>(rows);
			for (var n:uint = 0; n < rows; n++) {
				_fields[n] = new Vector.<QuadField>(columns);
			}
		}
		
		public function getFields():Vector.<Field> {
			var fields:Vector.<Field> = new Vector.<Field>();
			for (var j:uint=0; j < _rows; j++) {
				for (var i:uint=0; i < _columns; i++) {
					fields.push(_fields[j][i].field);
				}
			}
			return fields;
		}
		
		public function getUndergroundTexture():BitmapData {
			var texture:BitmapData = new BitmapData(_rows*_tileSize,_columns*_tileSize);
			for (var j:uint=0; j < _rows; j++) {
				for (var i:uint=0; i < _columns; i++) {
					var field:QuadField = _fields[j][i];
					fillUndergroundTexture(texture, field.underground, i*_tileSize, j*_tileSize);
				}
			}
			return texture;
		}
		
		private function fillUndergroundTexture(result:BitmapData, part:BitmapData, xPos:uint, yPos:uint):void {
			var rect:Rectangle = new Rectangle(0, 0, part.width, part.height);
			var pt:Point = new Point(xPos, yPos);
			result.copyPixels(part, rect, pt);
		}
		
		private function onFieldClicked(e:LevelEditorFieldEvent):void{
			dispatchEvent(new LevelEditorFieldEvent(LevelEditorFieldEvent.ON_MOUSE_CLICK, e.field));
		}
	}
}