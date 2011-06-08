package de.molehill.logger
{
	import flash.events.Event;
	
	import mx.collections.ArrayList;

	public class Logger
	{
		static private var _instance:Logger;
		private var _logList:ArrayList;
		private var _descriptionList:ArrayList;
		private var _view:LoggerView;
		
		public function Logger(singletonEnforcer:SingletonEnforcer)	{
			init();
		}
		
		public static function get instance():Logger{
			if(Logger._instance == null){
				Logger._instance = new Logger(new SingletonEnforcer());
			}
			return Logger._instance;
		}
		
		private function init(): void {
			initLists();
		}
		
		private function clear(e:Event):void {
			initLists();
			_view.showLoggs(null, null);
		}
		
		private function initLists():void {
			_logList = new ArrayList();		
			_descriptionList = new ArrayList();
			_descriptionList.addItem("")
		}

		public function addLog(description:String, message:String):void {	
			_logList.addItem(description + ": " + message);
			var isItem:Boolean;
			for (var i:int = 0; i < _descriptionList.length; i++) {
				if(description == _descriptionList.getItemAt(i) as String){
					isItem = true;
					break;
				}
			}
			if(!isItem){
				_descriptionList.addItem(description);
			}
			_view.showLoggs(_logList, _descriptionList);
		}
		
		public function filter(filter:String):void {
			var filterList:ArrayList = new ArrayList();
			for (var i:uint=0;i<_logList.length;i++) {
				if(_logList.getItemAt(i).match(filter)){
					filterList.addItem(_logList.getItemAt(i));
				}
			}
			_view.showFilteredLoggs(filterList);
		}

		public function setView(value:LoggerView):void
		{
			_view = value;
			_view.addEventListener("CLEAR_LOG", clear);
		}
		
		public function show():void {
			_view.visible = !_view.visible;
		}
	}
}

class SingletonEnforcer{}