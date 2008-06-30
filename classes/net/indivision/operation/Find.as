import net.indivision.operation.AbstractAnalysis;
/**
* Finds the property with the highest or lowest value amongst an array of objects and returns either the object or its position in the Array (ID).
*/
class net.indivision.operation.Find extends AbstractAnalysis
{
	private function Find()
	{
	}
	/**
	* @param array an Array of Objects.
	* @param property the property to compare.
	* @return the Object containing the property of the highest value.
	*/
	public static function highItem(array:Array, property:String):Object
	{
		find(isHigher, array, property);
		return item;
	}
	/**
	* @param array an Array of Objects.
	* @param property the property to compare.
	* @return the Object containing the property of the lowest value.
	*/
	public static function lowItem(array:Array, property:String):Object
	{
		find(isLower, array, property);
		return item;
	}
	/**
	* @param array an Array of Objects.
	* @param property the property to compare.
	* @return the Array position (ID) of the Object containing the property of the highest value.
	*/
	public static function highID(array:Array, property:String):Object
	{
		find(isHigher, array, property);
		return count;
	}
	/**
	* @param array an Array of Objects.
	* @param property the property to compare.
	* @return the Array position (ID) of the Object containing the property of the lowest value.
	*/
	public static function lowID(array:Array, property:String):Object
	{
		find(isLower, array, property);
		return count;
	}
}
