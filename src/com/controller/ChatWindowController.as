package com.controller
{
	
	import com.model.MainModel;
	import com.view.MainView;
	import com.view.chatWindow.ChatWindowView;
	
	import util.classes.User;
	
	public class ChatWindowController
	{
		
		[Bindable]
		[Inject]
		public var mainModel:MainModel;
		
		[Bindable]
		[ViewAdded]
		public var mainView:MainView;
		
		public function ChatWindowController()
		{
		}
		
		
		
	
		public function minimizeChatWindow():void
		{
				
			mainView.tabBar_queueChat.selectedIndex = -1;
			mainModel.currentWorkSpaceDomain.currentActiveUser = null
			
			mainView.group_chatWindow.width = 0;
			
		}
		
		
		
		
	
		
		
		
		
		
	}
}