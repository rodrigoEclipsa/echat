package util.classes
{
	
	
	import util.Interface.IContact;
	
	import com.model.MainModel;
	import com.view.MainView;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	import util.vo.entities.DomainVO;

	
	

	
	[Bindable]
	public class DomainWorkSpace
	{
		
		
		
		
		
		public var domain:Domain;
		
		public var arrayCollection_users:ArrayCollection = new ArrayCollection();
		
		
	
		
		
		
		public var arrayList_usersTab:ArrayList = new ArrayList();
		
		
		/**
		 * 
		 * usuario o agente activo en la ventana de chat
		 * 
		 * 
		 * 
		 * */
		public var currentActiveContact:IContact;
		
		
		
		/**
		type queuechatvo
		
		cola de chat 
		
		provedor  de pesatañas
		**/
		public var arrayCollection_queueChat:ArrayCollection = new ArrayCollection();
		
		/**
		
		type queuechatvo
		
		cola de llamadas 
		
		se produce cuando un usuario envia mensajes de chat
		
		**/
		public var arrayCollection_queueCall:ArrayCollection = new ArrayCollection();
		

		
		public function DomainWorkSpace()
		{
		}
		
		
		
		
	
     
		
	

	}
}