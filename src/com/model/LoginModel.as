package com.model
{
	import mx.collections.ArrayList;
	
	import org.igniterealtime.xiff.core.EscapedJID;
	import org.igniterealtime.xiff.core.UnescapedJID;
	
	import util.classes.Agent;
	import util.vo.entities.AgentVO;
	import util.vo.entities.DomainVO;
	import util.vo.entities.RoleVO;
	
	[Bindable]
	public class LoginModel
	{
		
	
	    
		
		
		public var agentVO:AgentVO;
		public var arrayList_domainsVO:ArrayList = new ArrayList()
		public var roleVO:RoleVO;
		
		
		
		
		public function getAgentJid():UnescapedJID
		{
			var uJid:UnescapedJID;
			
			if(agentVO)
			uJid = new UnescapedJID("agent_" + agentVO.id);
			
			
			return uJid;
			
		}
		
		
	}
}