package {

	public class Pref {
		public static const DISPLAY_HEIGHT:uint=768;
		public static const DISPLAY_WIDTH:uint=1024;

		public static const BATTLEFIELD_COL:uint=12;
		public static const BATTLEFIELD_ROWS:uint=24;
		public static const BATTLEFIELD_FREI_OBEN:uint=8;
		public static const BATTLEFIELD_FREI_LINKS:uint=6;
		public static const BATTLEFIELD_HOEHE:Number=64;
		public static const BATTLEFIELD_BREITE:Number=74;
		public static const BATTLEFIELD_COS30:Number=Math.cos(30 * Math.PI / 180);
		public static const BATTLEFIELD_SEITENLAENGE:Number=BATTLEFIELD_HOEHE / BATTLEFIELD_COS30 / 2;

		public static const REGIONS:uint=28;

		public static const MAX_PLAYERS:uint=2;

		public static const UNITS_MAX_REICHWEITE:uint=4;

//		public static const SOLDIER_COST:uint = 150;
//		public static const SOLDIER_LIVEPOINTS:uint = 10;
//		public static const SOLDIER_ACTIONPOINTS:uint = 5;
//		public static const SOLDIER_SIGHT:uint = 2;
//		public static const SOLDIER_ATTACK:uint = 4;
//		public static const SOLDIER_DEFENSE:uint = 4;		
//		public static const SOLDIER_RANGE:uint = 1;
//		public static const SOLDIER_MUNITION:uint = 7;
//		public static const SOLDIER_CAMOUFLAGE:uint = 1;
//		public static const SOLDIER_ATTACKCOSTS:uint = 1;
	}
}