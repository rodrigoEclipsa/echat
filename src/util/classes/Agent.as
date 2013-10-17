package util.classes
{
	import mx.collections.ArrayList;
	
	import util.vo.entities.AgentVO;
	
	[Bindable]
	public class Agent
	{
		
		
		
		public var agentVO:AgentVO;
	
		public var arrayList_roles:ArrayList = new ArrayList();
		
		
		
		public function Agent(agentVO:AgentVO)
		{
			
		this.agentVO = agentVO;	
			
		}
		
		
		
	}
}