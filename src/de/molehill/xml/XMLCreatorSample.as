package de.molehill.xml {

	public final class XMLCreatorSample {
		
		public static function createUserXML(userName:String, userMail:String, userAge:uint):XML {
			var xmlAsString:String = "<user>";
			xmlAsString += "<name>" + userName + "</name>";
			xmlAsString += "<mail>" + userMail + "</mail>";
			xmlAsString += "<age>" + userAge + "</age>";
			xmlAsString += "</user>";
			//trace ( xmlAsString );
			var xml:XML = new XML(xmlAsString);
			return xml;
		}

		public static function createUserXMLByProperties(properties:Object):XML {
			var xml:XML = <user/>
			for (var propertyName:String in properties)
				xml[propertyName] = properties[propertyName];
			return xml;
		}

		public static function createUserList():XML {
			var xml:XML = <users/>
			xml.appendChild(createUserXML("user1", "user1@domain.de", 1));
			xml.appendChild(createUserXML("user2", "user2@domain.de", 2));
			xml.appendChild(createUserXML("user3", "user3@domain.de", 3));
			return xml;
		}

		private static function attachAttribute(node:XML, attributeName:String, attributeValue:*):void {
			node.@[attributeName] = attributeValue;
		}

		public static function createUserListWithAttributes():XML {
			var xml:XML = <users/>
			for (var i:uint = 0; i < 3; i++) {
				var currentNode:XML = createUserXML("user" + i, "user" + i + "@domain.de", i);
				attachAttribute(currentNode, "id", i);
				xml.appendChild(currentNode);
			}
			return xml;
		}

		public static function createXML():XML {
			var xml:XML = <users/>
			xml.user.name = "Saban Ünlü";
			xml.user.@id = 1;
			xml.user.@userID = 6546;
			xml.user.name.@nick = "netTrek";
			xml.user.mail = "us@netTrek.de";
			xml.user.age = 33;
			return xml;
		}
	}
}