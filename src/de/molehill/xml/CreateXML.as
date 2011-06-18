package de.molehill.xml
{
	import de.molehill.levelEditor.QuadField;
	import de.molehill.levelEditor.items.UndergroundType;
	import flash.net.FileReference;

	public class CreateXML
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
		public static function createMap(mapAuthor:String, mapName:String, mapSize:uint, fields:Vector.<QuadField>):XML {
			
//			var fields:Vector.<QuadField> = pseudo();
			
			var xmlAsString:String = "<game>";			
			xmlAsString += createHeader(mapAuthor, mapName, mapSize);
			xmlAsString += "<map>";
			xmlAsString += "<fields>";
			for each (var field:QuadField in fields)
			{
				xmlAsString += addFieldAttributes(field);	
			}
			xmlAsString += "</fields>";
			xmlAsString += "</map>";
			xmlAsString += "</game>";
			
			
			var xml:XML = new XML(xmlAsString);
//			var fileRef:FileReference = new FileReference();
//			fileRef.save(xml);
			return xml;
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
		
		private static function addFieldAttributes(field:QuadField):String
		{
			var xmlAsString:String = "<field ";
			xmlAsString += 
					 "type=\"" + field.cost + "\" "
					+ "pos=\"" + field.coordinates + "\" "
//					+ "ypos=\"" + field.ypos + "\" "
					+ "free=\"" + field.free + "\" "
					+ "entreepoint=\"" + field.isStartField + "\" "
//					+ "hq=\"" + field.hq + "\" "
					+ "/>";
				
			return xmlAsString;
		}
		
//		private static function pseudo():Vector.<Field>
//		{
//			var fields:Vector.<Field> = new Vector.<Field>();
//			var field1:Field = new Field();
//			field1.hq = false;
//			field1.entreepoint = true;
//			field1.free = false;
//			field1.type = UndergroundType.GRASS;
//			field1.xpos = 20;
//			field1.ypos = 40;
//			
//			var field2:Field = new Field();
//			field2.hq = false;
//			field2.entreepoint = true;
//			field2.free = false;
//			field2.type = UndergroundType.STREET;
//			field2.xpos = 30;
//			field2.ypos = 70;
//			
//			fields.push(field1,field2);
//			
//			return fields;
//		}
	}
}