package util.classes
{
	import util.vo.entities.DomainVO;

	[Bindable]
	public class Domain
	{
		
		public var domainVO:DomainVO;
		
		public function Domain(domainVO:DomainVO)
		{
			
		    this.domainVO = domainVO;
			
		}
		
		
		
	}
}