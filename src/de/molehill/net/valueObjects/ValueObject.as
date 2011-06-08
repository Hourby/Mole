package de.molehill.net.valueObjects {
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	public class ValueObject implements IExternalizable {
		
		private var _sequenceNumber:uint;
		
		public function ValueObject(){}
		
		public function readExternal(input:IDataInput):void{
		}
		
		public function writeExternal(output:IDataOutput):void{
		}

		public function set sequenceNumber(value:uint):void
		{
			_sequenceNumber = value;
		}

	}
}