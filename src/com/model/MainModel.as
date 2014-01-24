package com.model
{
	
	
	
	
	import Interface.IContact;
	
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
	
	import util.app.ConfigParameters;
	import util.classes.Agent;
	import util.classes.Chat;
	import util.classes.Domain;
	import util.classes.QueueChat;
	import util.classes.User;
	import util.classes.DomainWorkSpace;
	import util.classes.functionReturn.UserDomain;

	
	
	
	[Bindable]
	public class MainModel
	{
	
		
		
		
		[ViewAdded]
		public var mainView:MainView;
		
		[Inject]
		public var chatManagerModel:ChatManagerModel;
		
	
		
	/**
	 * array de dominios , de aqui parten todos los datos 
	 * ya que cada dominio tiene sus propias caracteristicas
	 * 
	 **/
	 public var arrayCollection_domainsWorkSpace:ArrayCollection = new ArrayCollection();
		
		
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
		
		
		
		/**
		 * 
		 * obtiene el IContact del provedor de pestañas queueChat
		 * 
		 * 
		 * **/
		/*
		public function getUserDomainById(id:int,isUser:Boolean):UserDomain
		{
			var userDomain:UserDomain;
			var contact:IContact;
			
			for each(var workSpaceDomainItem:WorkSpaceDomain in arrayCollection_workSpacedomains )
			{
				
				if(isUser)
				{
					
						for each(var userItem:User in workSpaceDomainItem.arrayCollection_users)
						{
							
							if(userItem.userVO.id == id)
							{
								userDomain = new UserDomain()
								userDomain.iContact = userItem;
								userDomain.workSpaceDomain = workSpaceDomainItem;
								
								return userDomain;
								
							}
							
						}
					
					
				}
				else
				{
					
					
					
					for each(var agentItem:Agent in workSpaceDomainItem.arrayCollection_agent)
					{
						
						if(agentItem.agentVO.id == id)
						{
							userDomain = new UserDomain()
							userDomain.iContact = agentItem;
							userDomain.workSpaceDomain = workSpaceDomainItem;
							
							return userDomain;
							
						}
						
					}
					
					
				}
				
		
				
				
			}
			
			
			
			
			
			return userDomain;
			
		}	
		
		*/
		
		
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
	public function getWorkSpacedomainById(id:int):DomainWorkSpace
	{
		
		var workSpaceDomain:DomainWorkSpace;
		
		for each(var workSpaceDomainItem:DomainWorkSpace in arrayCollection_domainsWorkSpace)
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
				user = userItem
			
		}


		return user;
		
	}
	
	
	
	
	
	public function getAgentById(workSpaceDomain:DomainWorkSpace, agentId:int):Agent
	{
		
		
		
		var agent:Agent;
		
		for each(var agentItem:Agent in workSpaceDomain.arrayCollection_agent)
		{
			
			if(agentItem.agentVO.id == agentId)
				agent = agentItem;
			
		}
		
		
		return agent;
		
	}
	
		
		
		
	}
}