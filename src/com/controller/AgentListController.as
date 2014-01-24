package com.controller
{
	import com.event.ErrorServiceEvent;
	import com.model.ChatManagerModel;
	import com.model.MainModel;
	
	import mx.controls.Alert;
	
	import org.igniterealtime.xiff.core.UnescapedJID;
	import org.igniterealtime.xiff.data.im.RosterItemVO;
	import org.igniterealtime.xiff.events.RosterEvent;
	
	import service.ServiceEchat;
	
	import util.classes.Agent;
	import util.classes.DomainWorkSpace;
	import util.vo.ResultVO;
	import util.vo.entities.AgentVO;
	import util.vo.entities.DomainVO;

	public class AgentListController
	{
	
		[Bindable]
		[Inject]
		public var chatManagerModel:ChatManagerModel;
		
		[Bindable]
		[Inject]
		public var mainModel:MainModel;
		
		public function AgentListController()
		{
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}