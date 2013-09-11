package util
{
	import mx.collections.IList;
	import mx.collections.Sort;
	
	import spark.collections.SortField;

	public class ArrayCollectionUtil
	{
		
		
		
		
		import mx.collections.ArrayCollection;
		
		public function ArrayCollectionUtil()
		{
		}
		
		
			public static function getIndexByProperty(ac:IList,propertyName:String,searchValue:Object):int
			{
				var index:int=-1;
			
				
				for(var i:int ; i < ac.length ; i++)
				{
				
					
					if (ac.getItemAt(i)[propertyName]==searchValue)
					{
						index=i;
						break;
					}
					
				}
				
					
				return index;
			}
		
	
			public static function getIndex(ac:IList,searchValue:Object):int
			{
				var index:int=-1;
				
				
				for(var i:int ; i < ac.length ; i++)
				{
					
					
					if (ac.getItemAt(i)==searchValue)
					{
						index=i;
						break;
					}
					
				}
				
				
				return index;
			}
			

			
			public static function sortField(ac:ArrayCollection,prop:String,isNumeric:Boolean = true):void
			{
				
				
				var dataSortField:SortField = new SortField();
				dataSortField.name = prop;
				if(isNumeric)
				dataSortField.numeric = true
			
				
				/* Create the Sort object and add the SortField object created earlier to the array of fields to sort on. */
				var numericDataSort:Sort = new Sort();
				numericDataSort.fields = [dataSortField];
		
				/* Set the ArrayCollection object's sort property to our custom sort, and refresh the ArrayCollection. */
				ac.sort = numericDataSort;
				ac.refresh();
				
			}
		
		
	}
}