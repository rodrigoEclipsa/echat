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
	
	import util.app.ConfigParameters;
	import util.classes.Chat;
	import util.classes.QueueChat;
	import util.classes.User;
	import util.classes.WorkSpaceDomain;

	
	
	
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
	 public var arrayCollection_workSpacedomains:ArrayCollection = new ArrayCollection();
		
		
		
	 public var currentWorkSpaceDomain:WorkSpaceDomain;	
		
		
	
		
		
		
		
		
		public function clearData():void
		{
			
			
			
		}
		
		
		
	public function isQueueChat(user:User):Boolean
	{
		var exist:Boolean = false;
		
		for each(var userItem:User in currentWorkSpaceDomain.arrayCollection_queueChat)
		{
			
			if(userItem == user)
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
	public function getWorkSpacedomainById(id:int):WorkSpaceDomain
	{
		
		var workSpaceDomain:WorkSpaceDomain;
		
		for each(var workSpaceDomainItem:WorkSpaceDomain in arrayCollection_workSpacedomains)
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
	public function getUserById(workSpaceDomain:WorkSpaceDomain, userId:int):User
	{
		
	
		
		var user:User;
		
		for each(var userItem:User in workSpaceDomain.arrayCollection_users)
		{
			
			if(userItem.userVO.id == userId)
				user = userItem
			
		}


		return user;
		
	}
	
		
		
		
	}
}