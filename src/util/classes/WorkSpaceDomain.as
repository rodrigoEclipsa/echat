package util.classes
{
	import mx.collections.ArrayCollection;
	
	import util.vo.entities.DomainVO;

	[Bindable]
	public class WorkSpaceDomain
	{
		
		
		public var domainVO:DomainVO;
		
		private var _arrayCollection_users:ArrayCollection;
		
		private var _arrayCollection_agent:ArrayCollection;
		
		
		public function WorkSpaceDomain()
		{
		}
		
		
		public function get arrayCollection_agent():ArrayCollection
		{
			if(!_arrayCollection_agent)
				_arrayCollection_agent = new ArrayCollection();
				
			return _arrayCollection_agent;
		}

		public function set arrayCollection_agent(value:ArrayCollection):void
		{
			_arrayCollection_agent = value;
		}

		public function get arrayCollection_users():ArrayCollection
		{
			if(!_arrayCollection_users)
				_arrayCollection_users = new ArrayCollection();
			
			return _arrayCollection_users;
		}

		public function set arrayCollection_users(value:ArrayCollection):void
		{
			_arrayCollection_users = value;
		}

	}
}