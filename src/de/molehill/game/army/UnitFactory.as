package de.molehill.game.army
{
	import de.molehill.game.units.Tank;
	import de.molehill.game.units.Unit;
	import de.molehill.game.units.UnitProperties;
	import de.molehill.game.units.UnitType;

	public class UnitFactory {
		
		private static var id:uint;
		
		public static function createUnit(unitType:uint):Unit {
			switch(unitType){
				case UnitType.TANK:
					return new Tank(id++,10,8,6,5,4);
				case UnitType.HUMWEE:
					return new Tank(id++,10,8,6,5,4);
				case UnitType.ARTILLERIE:
					return new Tank(id++,10,8,6,5,4);
				default:
					throw new Error("unitType Error in UnitFactory");
			}
		}
	}
}