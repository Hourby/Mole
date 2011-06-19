package de.molehill.xml
{
	import de.molehill.game.map.field.Field;
	import de.molehill.levelEditor.items.UndergroundType;
	
	import flash.net.FileReference;

	public final class XMLHelper
	{	
		/**
		 * creates an xml file with the map information
		 * <map name="" ....>
		 * <field id="" name="" ... />
		 * </map>
		 * 
		 * @param gameID
		 * @param gameName
		 * @param mapSize 
		 * @return XML 
		 */
		public static function createMap(mapAuthor:String, mapName:String, mapSize:uint, fields:Vector.<Field>):void {
						
			var xmlAsString:String = "<game>";			
			xmlAsString += createHeader(mapAuthor, mapName, mapSize);
			xmlAsString += "<map>";
			xmlAsString += "<fields>";
			for each (var field:Field in fields)
			{
				xmlAsString += addFieldAttributes(field);	
			}
			xmlAsString += "</fields>";
			xmlAsString += "</map>";
			xmlAsString += "</game>";
			
			
			var xml:XML = new XML(xmlAsString);
			var fileRef:FileReference = new FileReference();
			fileRef.save(xml);
		}
		
		/**
		 * creates the gameheader 
		 * <game>
		 * <gameID>id</gameID>
		 * <gameName>name</gameName>
		 * ...
		 * </game>
		 * 
		 * @param gameID
		 * @param gameName
		 * @param mapSize
		 * @return XML
		 * 
		 */
		private static function createHeader(author:String, gameName:String, mapSize:uint):String {
			var xmlAsString:String = "";
			xmlAsString += "<author>" + author + "</author>";
			xmlAsString += "<gameName>" + gameName + "</gameName>";
			xmlAsString += "<mapSize>" + mapSize + "</mapSize>";
			return xmlAsString;
		}
		
		private static function addFieldAttributes(field:Field):String
		{
			var xmlAsString:String = "<field ";
			xmlAsString += 
					 "type=\"" + field.type + "\" "
					+ "xpos=\"" + field.position.x + "\" "
					+ "ypos=\"" + field.position.y + "\" "
					+ "isFree=\"" + field.isFree + "\" "
					+ "isEntryPoint=\"" + field.isEntryPoint + "\" "
					+ "isTargetPoint=\"" + field.isTargetPoint + "\" "
					+ "/>";
				
			return xmlAsString;
		}
	}
}