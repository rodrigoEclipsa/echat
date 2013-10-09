package com.model
{
	
	
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
	import util.classes.Chat;
	import util.classes.QueueChat;
	import util.classes.WorkSpaceDomain;

	
	
	
	[Bindable]
	public class MainModel
	{
	
		
		
			
		
		[Inject]
		public var chatManagerModel:ChatManagerModel;
		
		
	/**
	 * array de dominios , de aqui parten todos los datos 
	 * ya que cada dominio tiene sus propias caracteristicas
	 * 
	 **/
	 public var arrayCollection_workSpacedomains:ArrayCollection = new ArrayCollection();
		
		
		
	    public var currentDomain:WorkSpaceDomain;	
		
		
		/*
		type queuechatvo
		
		cola de chat 
		
		se produce cuando atendio a un usuario en llamada
		*/
		public var arrayCollection_queueChat:ArrayCollection = new ArrayCollection();
		
		/*
		
		type queuechatvo
		
		cola de llamadas 
		
		se produce cuando un usuario envia mensajes de chat
		
		*/
		public var arrayCollection_queueCall:ArrayCollection = new ArrayCollection();
		

		
		/*
		
		type queuechatvo
		
		lista de visitas en la web
		
		se produce cuando un usuario visita la web
		
		*/
		public var arrayCollection_visitor:ArrayCollection = new ArrayCollection();
		
		
		
		
		public var currentQueueChatVO:QueueChat;
		
		
		public var arrayList_agent:ArrayList = new ArrayList();
		
		
		
		
		public function clearData():void
		{
			
			arrayCollection_queueChat.removeAll();
			arrayCollection_queueCall.removeAll();
			arrayList_agent.removeAll();
			currentQueueChatVO = null;
			
		}
		
		
		public function getChatVO(queueChatVO:QueueChat,uid:String):Chat
		{
			
			var chatVO:Chat;
			
			var len:uint = queueChatVO.arrayList_historyChat.source.length-1;
			
			
			for(var i:int =len ; i>=0;i--)
			{
				
				var item:Chat = queueChatVO.arrayList_historyChat.source[i] as Chat;
				
				if(item.uid ==  uid)
				{
					chatVO = item;
					break;
					
				}
				
			}
			
			
			return chatVO;
			
		}
		
		
	
		
		
		public function getQueueChatVO(node:String):QueueChat
	    {
			
			
			var queueChatVO:QueueChat;
			
			for each(var queueChatVOItem:QueueChat in arrayCollection_queueChat)
			{
				
				if(node == queueChatVOItem.jid.node )
				{
					queueChatVO = queueChatVOItem;
					break;
					
				}
				
			}
			
			
			return queueChatVO;
			
		}
		
		
	  
	public function getWorkSpacedomainById(id:int):WorkSpaceDomain
	{
		
		var workSpaceDomain:WorkSpaceDomain;
		
		for each(var workSpaceDomainItem:WorkSpaceDomain in arrayCollection_workSpacedomains)
		{
			
			if(workSpaceDomainItem.domainVO.id == id  )
			{
				workSpaceDomain = workSpaceDomainItem;
			
				break;
			}
		}
		
		return workSpaceDomain;
		
	}
	 
	
		
		
		
	}
}