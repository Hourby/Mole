package de.molehill.xml {

	import flash.display.Sprite;
	import com.netTrek.video2Brain.as3dvd.xml.XMLCreator;
	import flash.xml.XMLNode;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequestMethod;

	public class XML_SAMPLES extends Sprite {
		public function XML_SAMPLES() {
			loadXML();
		/*
		showAttributeValuesByName ( "id" );
		creatingXML();
		showElementsList();
		showElementsList("item");
		showAllLinks ();
		showItemInformationsByID ( 1 );
		showItemInformations ();
		showTagsWithSpecAttribute ( "id", 1 );
		*/
		}

		public function creatingXML():void {
			trace(XMLCreator.RSS);
			//trace ( XMLCreator.createUserXML( "netTrek", "us@netTrek.de", 33 ) );
		/*
		var userObj : Object = new Object ();
		userObj.name = "netTrek";
		userObj.mail = "us@netTrek.de";
		userObj.age = 33;
		trace ( XMLCreator.createUserXMLByProperties( userObj ) );
		*/
			//trace ( XMLCreator.createUserList() );
			//trace ( XMLCreator.createXML () );
			//trace ( XMLCreator.createUserListWithAttributes() );
		}

		public function showElementsList(nodeName:String = "*"):void {
			for each (var element:XML in XMLCreator.RSS.channel.elements(nodeName))
				trace(element);
		}
		public function showAllLinks():void {
			var xmlList:XMLList = XMLCreator.RSS..link;
			trace(xmlList);
			for each (var element:XML in xmlList)
				trace(element);
		}
		public function showItemInformations():void {
			var items:XMLList = XMLCreator.RSS..item;
			trace("All Items := " + items.length());
			for each (var node:XML in items.elements()) {
				trace(node.name() + " := " + node);
			}
		}
		public function showItemInformationsByID(id:uint = 0):void {
			var item:XML = XMLCreator.RSS.channel.item[id];
			for each (var node:XML in item.elements()) {
				trace(node.name() + " := " + node);
			}
		}
		public function showAttributeValuesByName(attributeName:String):void {
			var xml:XML = XMLCreator.createUserListWithAttributes();
			var users:XMLList = xml..user;
			trace(users);
			for each (var attribute:XML in users.attribute(attributeName)) {
				trace(attribute.name() + " := " + attribute);
			}
		}
		public function showTagsWithSpecAttribute(attributeName:String, value:*):void {
			var xml:XML = XMLCreator.createUserListWithAttributes();
			var users:XMLList = xml..user;
			for each (var node:XML in users) {
				if (node.@[attributeName] == value)
					trace(node);
			}
		}

		public function loadXML():void {
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			var request:URLRequest = new URLRequest("rssFeed.xml");
			request.data = XMLCreator.createUserList();
			request.method = URLRequestMethod.POST;
			var eventListener:Function = function(e:Event):void {
				trace(e);
				if (e.type === Event.COMPLETE) {
					var urlLoader:URLLoader = e.target as URLLoader;
					if (urlLoader.dataFormat === URLLoaderDataFormat.TEXT) {
						var xmlData:String = urlLoader.data as String;
						var xml:XML = new XML(xmlData);
						trace(xml..title);
					}
				}
			};

			loader.addEventListener(Event.OPEN, eventListener);
			loader.addEventListener(Event.COMPLETE, eventListener);
			loader.addEventListener(ProgressEvent.PROGRESS, eventListener);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, eventListener);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, eventListener);
			loader.addEventListener(IOErrorEvent.IO_ERROR, eventListener);

			loader.load(request);
		}
	}
}
