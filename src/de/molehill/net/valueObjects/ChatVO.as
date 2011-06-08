package de.molehill.net.valueObjects{
	
	import flash.net.registerClassAlias;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
		
	public class ChatVO extends ValueObject{
		
		private static const ALIAS:* = registerClassAlias( "ChatVO", ChatVO );
		
		private var _userName:String;
		private var _message:String;

		public function ChatVO(userName:String="", message:String="") {
			_userName = userName;
			_message  = message;
		}
		
		public function get userName():String{
			return _userName;
		}

		public function get message():String{
			return _message;
		}

		public override function readExternal(input:IDataInput):void {
			_userName = input.readUTF();
			_message  = input.readUTF();
		}
		
		public override function writeExternal(output:IDataOutput):void{
			output.writeUTF(_userName);
			output.writeUTF(_message);
		}
	}
}