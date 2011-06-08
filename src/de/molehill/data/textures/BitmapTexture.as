package de.molehill.data.textures
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class BitmapTexture extends Bitmap
	{
		private var _name:String;
		
		public function BitmapTexture(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
		}

		override public function set name(value:String):void
		{
			_name = value;
		}

		override public function get name():String
		{
			return _name;
		}
	}
}