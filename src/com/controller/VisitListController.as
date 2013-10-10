package com.controller
{
	import com.model.MainModel;
	import com.view.MainView;
	import com.view.chatWindow.ChatWindowView;
	
	import util.classes.User;

	public class VisitListController
	{
		
		[Bindable]
		[Inject]
		public var mainModel:MainModel;
		
		[Bindable]
		[ViewAdded]
		public var mainView:MainView;
		
		[Bindable]
		[ViewAdded]
		public var chatWindowView:ChatWindowView;
	
		public function VisitListController()
		{
		}
		
		
		
	
		
		
		
		public function selectUser(user:User):void
		{
			
		
			if(!mainModel.isQueueChat(user))
				mainModel.currentWorkSpaceDomain.arrayCollection_queueChat.addItem(user);
			
			// si no esta activo lo pongo activo y lo selecciono en el tab
			if(mainModel.currentWorkSpaceDomain.currentActiveUser != user)
			{
				
			
				mainModel.currentWorkSpaceDomain.currentActiveUser = user;
				mainView.tabBar_queueChat.selectedItem = mainModel.currentWorkSpaceDomain.currentActiveUser;
				
				
			
				chatWindowView.isVisible = true;
				
			
			
		}
			
		}
		
		
		
		
		
	}
}