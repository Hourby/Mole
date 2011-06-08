package de.molehill.net{
	
	import org.robotlegs.mvcs.Command;

	public class HandleAMFCommand extends Command {

		[Inject]
		public var e:AMFEvent;
		
		[Inject]
		public var voModel:VOModel;
		
		override public function execute():void	{			
			voModel.addVO(e.vo);
		}
	}
}