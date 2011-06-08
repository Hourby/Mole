package de.molehill.levelEditor
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class CropperEvent extends Event
	{
		public static const CHANGE_CROPPER_SIZE:String = "changeCropperSize";
		public static const CROPPER_SIZE:String = "cropperSize";
		public static const CROPPER_SIZE_BY_PRESET:String = "cropperSizeByPreset";
		public static const CROPPER_DIMENSONS_REQUEST:String = "cropperDimensionsRequest";
		
		public static const CHANGE_CROPPER_POSITION:String = "changeCropperPosition";
		public static const CROPPER_POSITION:String = "cropperPosition";
		
		
		public static const CROPPER_PRESETS:String = "cropperPresets";
		public static const CROPPER_PRESETS_REQUEST:String = "cropperPresetsRequest";	
		
		
		public var data:*;
		
		public function CropperEvent(type:String, data:*=null)
		{
			this.data = data;
			super(type);
		}
		
		override public function clone() : Event
		{
			return new CropperEvent(type,data);
		}
	}
}