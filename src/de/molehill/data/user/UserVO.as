package de.molehill.data.user {
	
	import de.molehill.net.valueObjects.ValueObject;
	
	import flash.net.registerClassAlias;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	public class UserVO extends ValueObject{
		
		private static const ALIAS:* = registerClassAlias( "UserVO", UserVO );
		private var _name:String;
		private var _peerID:String;

		public function UserVO(name:String="", peerID:String="") {
			_name 	= name;
			_peerID = peerID;	
		}
		
		public function get name():String{
			return _name;
		}
		
		public function get peerID():String{
			return _peerID;
		}

		public override function readExternal(input:IDataInput):void {
			_name	 = input.readUTF();
			_peerID	 = input.readUTF();
		}
		
		public override function writeExternal(output:IDataOutput):void{
			output.writeUTF(_name);
			output.writeUTF(_peerID);
		}
	}
}