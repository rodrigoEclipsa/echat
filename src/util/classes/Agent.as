package util.classes
{
	
	
	
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import org.igniterealtime.xiff.data.im.RosterItemVO;
	
	import util.vo.entities.AgentVO;
	import util.vo.entities.RoleVO;
	
	[Bindable]
	public class Agent 
	{
		public var type:String="agent";
		
		public var roleVO:RoleVO;
		public var agentVO:AgentVO;
	
		
		
		public var contact:Contact;
		
		
		public var arrayList_roles:RoleVO;
		
		public var minuteConnect:Number = 0;
		private var interval:uint;
		
		private var stampTime:Number = new Date().time;
		
		public function Agent(agentVO:AgentVO)
		{
			
	
		this.agentVO = agentVO;	
			
		
		
		}
		
		
		public function interval_minuteHadler():void
		{
			
			
			var date:Date = new Date();
			
			date.time = date.time - stampTime;
			
			minuteConnect = date.seconds;
			
		}
		
		
		
		public function stopInterval():void
		{
			
			clearInterval(interval);
		}
		
		public function startInterval():void
		{
			interval = setInterval(interval_minuteHadler,60000);
		}
		
		
		public function clearClass():void
		{
			
			
			stopInterval();
		}
		
		
	}
}