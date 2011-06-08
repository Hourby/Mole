package de.molehill.game.map
{
	import de.molehill.game.map.field.Field;
	
	import flash.geom.Point;
	
	public class MapModel
	{
		private var _rows:uint;
		private var _columns:uint;
		
		private var _fields : Vector.<Vector.<Field>>;
		private var _closedFields:Vector.<Field>;
		private var openFields:Vector.<Field> = new Vector.<Field>();

		public function MapModel(rows : uint, columns : uint) {
			_rows = rows;
			_columns = columns;
			_closedFields = new Vector.<Field>();
			initialize();
		}

		private function initialize() : void {
			_fields = new Vector.<Vector.<Field>>(_rows);
			for (var n : uint = 0; n < _rows; n++) {
				_fields[n] = new Vector.<Field>(_columns);
			}

			for (var j : uint = 0; j < _rows; j++) {
				for (var i : uint = 0; i < _columns; i++) {
					_fields[j][i] = new Field(new Point(j, i), 2, true, true);
				}
			}
		}
		
		public function getCurrentReachableFields():Vector.<Field> {
			return _closedFields;
		}

		public function handleAddUnit(position : Point) : void {
			_fields[position.x][position.y].isFree = false;
		}
		
		public function handleMoveUnit(oldPosition:Point, newPosition:Point):void {
			_fields[newPosition.x][newPosition.y].isFree = false;
			_fields[oldPosition.x][oldPosition.y].isFree = true;
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
					chckField.remainedActionPoint = actionPoints - chckField.wayCost;
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
						chckField.remainedActionPoint = currentField.remainedActionPoint - chckField.wayCost;
					} else {								
						if(currentField.remainedActionPoint - chckField.wayCost > chckField.remainedActionPoint)	{
							chckField.remainedActionPoint = currentField.remainedActionPoint - chckField.wayCost;
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
					if(chckField.isFree &&  remainingActionPoints >= chckField.wayCost){
						neighboursFields.push(chckField);
					}
				}
			}
			return neighboursFields;
		}
		
		private function isPointInMap(position:Point):Boolean {
			return 0 <= position.x && 0 <= position.y && position.x < _rows && position.y < _columns;
		}
		
		private	function getNeighborPoints(position:Point): Vector.<Point> {
			var neighbors:Vector.<Point> = new Vector.<Point>();
			neighbors.push(new Point(position.x - 1, position.y));
			neighbors.push(new Point(position.x + 1, position.y));
			neighbors.push(new Point(position.x, position.y - 1));
			neighbors.push(new Point(position.x, position.y + 1));
			return neighbors;
		}

		public function get rows() : uint {
			return _rows;
		}

		public function get columns() : uint {
			return _columns;
		}

	}
}