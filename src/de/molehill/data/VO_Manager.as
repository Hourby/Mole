package de.molehill.data {
	
	import de.molehill.net.P2P_Manager;
	
	public class VO_Manager {
		static private var _instance:VO_Manager;
		private var _container:Vector.<ValueObject>;
		private var _peerManager:P2P_Manager;

		public function VO_Manager(singletonEnforcer:SingletonEnforcer) {
			_container = new Vector.<ValueObject>();
			_peerManager = P2P_Manager.instance;
		}
		
		public static function get instance():VO_Manager {
			if(VO_Manager._instance == null) {
				VO_Manager._instance = new VO_Manager(new SingletonEnforcer());
			}
			return VO_Manager._instance;
		}
		
		public function addVO(vo:ValueObject):void{
			_container.push(vo);
		}

		public function getElementAt(value:uint):ValueObject{
			return _container[value];
		}

		public function get length():uint{
			return _container.length;
		}		
		
		public function sendContainer():void{
			for(var i:uint=0;i<_container.length;i++){
				_peerManager.sendObject(_container[i]);
			}
			_container = new Vector.<ValueObject>();
		}
	}
}

class SingletonEnforcer{}