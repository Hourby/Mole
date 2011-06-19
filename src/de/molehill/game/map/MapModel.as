package de.molehill.game.map
{
	import de.molehill.game.map.field.Field;
	
	import flash.geom.Point;
	
	public class MapModel
	{
//		private var _rows:uint;
//		private var _columns:uint;
		private var _size:uint;
		
		private var _fields : Vector.<Vector.<Field>>;
		private var _closedFields:Vector.<Field>;
		private var openFields:Vector.<Field> = new Vector.<Field>();

		public function MapModel(xml:XML) {
			
			
//			_rows = xml.;
//			_columns = columns;
			_closedFields = new Vector.<Field>();

			//getAttributeValuesByName(xml,"isFree");

			_size = uint (getElement(xml, "mapSize"));
			var author:String = String( getElement(xml, "author"));
			var gameName:String = String( getElement(xml, "gameName"));
			var fields:XMLList = xml..field;
			initialize(fields);
		}
		
		private function getAttributeValuesByName(xml:XML, attributeName:String):XMLList {
			var size:uint;

			var fields:XMLList = xml..field;
			
			for each (var attribute:XML in fields.attribute(attributeName)) {
				trace(attribute.name() + " := " + attribute);
			}
			return fields;
		}

		private function getElement(xml:XML, nodeName:String = "*"):XMLList {
			var element:XMLList = xml.elements(nodeName);
			return element;
		}
		
		private function initialize(xmlList:XMLList) : void {
			_fields = new Vector.<Vector.<Field>>(_size);
			for (var j : uint = 0; j < _size; j++) {
				_fields[j] = new Vector.<Field>(_size);
			}
			
			
				
			var item:XML;
			for each(item in xmlList){
				var x:uint = item.attribute("xpos");
				var y:uint = item.attribute("ypos");
				var type:uint = item.attribute("type");
				var isFree:Boolean = item.attribute("isFree");
				var isEntryPoint:Boolean = item.attribute("isEntryPoint");
				var isTargetPoint:Boolean = item.attribute("isTargetPoint");
				_fields[x][y] = new Field(new Point(x, y), type, isFree);
			}
			//trace("MapModel.initialize(xmlList)" + xmlList);
		}
		
		public function getCurrentReachableFields():Vector.<Field> {
			return _closedFields;
		}
		
		public function clearCurrentReachableFields():void {
			_closedFields = new Vector.<Field>();
		}

		public function handleAddUnit(position : Point) : void {
			_fields[position.x][position.y].isFree = false;
		}
		
		public function handleMoveUnit(oldPosition:Point, newPosition:Point):Vector.<Point> {
			_fields[newPosition.x][newPosition.y].isFree = false;
			_fields[oldPosition.x][oldPosition.y].isFree = true;
			var positions:Vector.<Point> = new Vector.<Point>();
			var field:Field = _fields[newPosition.x][newPosition.y];
			while(oldPosition.x != newPosition.x || oldPosition.y != newPosition.y ){
				positions.push(field.position);
				field = field.parent;
				newPosition = field.position;
			}
			positions.push(field.position);
			positions.reverse();
			return positions;
		}
		
		public function getField(position:Point):Field{
			return _fields[position.x][position.y];
		}
		
		public function computeReachableFields(position:Point, actionPoints:uint):Vector.<Field>
		{
			var reachableNeighbours:Vector.<Field>;
			_closedFields = new Vector.<Field>();
			var chckField:Field;
			var currentField:Field;
			
			currentField = _fields[position.x][position.y];
			currentField.remainedActionPoint = actionPoints;
			_closedFields.push(currentField);
			
			reachableNeighbours = getReachableNeighbors(currentField, actionPoints);
			if (reachableNeighbours.length > 0)	{
				for (var i:uint=0;i<reachableNeighbours.length;i++)	{
					chckField = reachableNeighbours[i];
					openFields.push(chckField);
					chckField.parent = currentField;
					chckField.remainedActionPoint = actionPoints - chckField.type;
				}
			}
			while(openFields.length > 0){
				currentField = openFields.pop();
				reachableNeighbours = getReachableNeighbors(currentField, currentField.remainedActionPoint);
				for (var j:uint=0;j<reachableNeighbours.length;j++)	{
					chckField = reachableNeighbours[j];
					if(isNewField(chckField)){
						openFields.push(chckField);
						chckField.parent = currentField;
						chckField.remainedActionPoint = currentField.remainedActionPoint - chckField.type;
					} else {								
						if(currentField.remainedActionPoint - chckField.type > chckField.remainedActionPoint)	{
							chckField.remainedActionPoint = currentField.remainedActionPoint - chckField.type;
							chckField.parent = currentField;
							if (isInClosedList(chckField)){
								var index:int = _closedFields.indexOf(chckField);
								openFields.push(_closedFields[index]);
								_closedFields.splice(index,1);
							} 
						}					
					}
				}
				_closedFields.push(currentField);
			}
			return _closedFields;
		}

		private function isInOpenList(field:Field):Boolean {
			return openFields.indexOf(field) >= 0;
		}
		
		private function isInClosedList(field:Field):Boolean {
			return _closedFields.indexOf(field) >= 0;
		}
		
		private function isNewField(field:Field):Boolean {
			return !isInOpenList(field) && !isInClosedList(field);
		}	
		
		private	function getReachableNeighbors(field:Field, remainingActionPoints:uint):Vector.<Field> {
			var neighboursPoints:Vector.<Point> = getNeighborPoints(field.position);
			var neighboursFields:Vector.<Field> = new Vector.<Field>;
			var chckField:Field;
			
			for (var i:int = 0; i < neighboursPoints.length; i++) 
			{
				if(isPointInMap(neighboursPoints[i])){
					chckField = _fields[neighboursPoints[i].x][neighboursPoints[i].y];
					if(chckField.isFree &&  remainingActionPoints >= chckField.type){
						neighboursFields.push(chckField);
					}
				}
			}
			return neighboursFields;
		}
		
		private function isPointInMap(position:Point):Boolean {
			return 0 <= position.x && 0 <= position.y && position.x < _size && position.y < _size;
		}
		
		private	function getNeighborPoints(position:Point): Vector.<Point> {
			var neighbors:Vector.<Point> = new Vector.<Point>();
			neighbors.push(new Point(position.x - 1, position.y));
			neighbors.push(new Point(position.x + 1, position.y));
			neighbors.push(new Point(position.x, position.y - 1));
			neighbors.push(new Point(position.x, position.y + 1));
			return neighbors;
		}

		public function get size():uint
		{
			return _size;
		}


//		public function get rows() : uint {
//			return _rows;
//		}
//
//		public function get columns() : uint {
//			return _columns;
//		}

	}
}