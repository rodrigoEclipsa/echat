package com.model
{
	
	
	
	
	import com.view.MainView;
	import com.view.chatWindow.ChatWindowView;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.utils.ObjectProxy;
	import mx.utils.UIDUtil;
	
	import org.igniterealtime.xiff.conference.Room;
	import org.igniterealtime.xiff.conference.RoomOccupant;
	import org.igniterealtime.xiff.core.EscapedJID;
	import org.igniterealtime.xiff.core.UnescapedJID;
	import org.igniterealtime.xiff.data.Message;
	
	import util.Interface.IContact;
	import util.app.ConfigParameters;
	import util.classes.Agent;
	
	import util.classes.Domain;
	import util.classes.DomainWorkSpace;
	import util.classes.QueueChat;
	import util.classes.User;
	import util.classes.functionReturn.UserDomain;

	
	
	
	[Bindable]
	public class MainModel
	{
	
		
		
		
		[ViewAdded]
		public var mainView:MainView;
		
		[Inject]
		public var chatManagerModel:ChatManagerModel;
		
	
		
		public function MainModel()
		{
			
			arrayCollection_agent.filterFunction = filter_arrayCollection_gent;
			
		}
		
	/**
	 * array de dominios , de aqui parten todos los datos 
	 * ya que cada dominio tiene sus propias caracteristicas
	 * 
	 **/
	 public var arrayCollection_domainWorkSpace:ArrayCollection = new ArrayCollection();
		
		
	 /**
	  * 
	  * arrayCollection de agentes
	  * 
	  * **/
	 public var arrayCollection_agent:ArrayCollection = new ArrayCollection();
	 
	 
	 
	 
	 public var currentDomainWorkSpace:DomainWorkSpace;	
		
		
	
		

		public function clearData():void
		{
			
			
			
		}
		
		
		
		
		
		
		
		
		
		private function filter_arrayCollection_gent(item:Object):Boolean
		{
			
			var result:Boolean = false;
			
			var agent:Agent = item as Agent;
			
			var currentDomainId:int = currentDomainWorkSpace.domain.domainVO.id;
			
		  for each(var domainId:int in agent.domainsIds)
		  {
			  
			  if(domainId == currentDomainId)
				  result = true;
			  
		  }
			
				
				
				return result;
		}
		
		
		
		
	
	
		
		
	public function isQueueChat(contact:IContact):Boolean
	{
		var exist:Boolean = false;
		
		for each(var iContactItem:IContact in currentDomainWorkSpace.arrayCollection_queueChat)
		{
			
			if(iContactItem == contact)
			{
			
		    exist = true;
			break;
			
			}
			
		}
		
		
		
		return exist;
		
		
	}
		
	
	  /**
	  * 
	  * obtiene el espacio de trabajo del dominio pasando la id del mismo
	  * 
	  * 
	  * **/
	public function getDomaintWorkSpaceById(id:int):DomainWorkSpace
	{
		
		var workSpaceDomain:DomainWorkSpace;
		
		for each(var workSpaceDomainItem:DomainWorkSpace in arrayCollection_domainWorkSpace)
		{
			
			if(workSpaceDomainItem.domain.domainVO.id == id  )
			{
				workSpaceDomain = workSpaceDomainItem;
			
				break;
			}
		}
		
		return workSpaceDomain;
		
	}
	 
	
	
	
	
	
	
	/**
	 * 
	 * obtiene el usuario de espacio de trabajo segun id de usuario
	 * 
	 * 
	 * **/
	public function getUserById(workSpaceDomain:DomainWorkSpace, userId:int):User
	{
		
	
		
		var user:User;
		
		
		for each(var userItem:User in workSpaceDomain.arrayCollection_users)
		{
			
			if(userItem.userVO.id == userId)
			{
				user = userItem
			break;
			}
		}


		return user;
		
	}
	
	
	
	
	
	public function getAgentById(agentId:int):Agent
	{
		
		
		
		var agent:Agent;
		
		for each(var agentItem:Agent in arrayCollection_agent.source)
		{
		
			if(agentItem.agentVO.id == agentId)
			{
				agent = agentItem;
			
				break;
			}
		}
		
		
		return agent;
		
	}
	
		
		
		
	}
}