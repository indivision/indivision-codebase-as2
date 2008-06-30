import net.indivision.operation.Iteration;
/**
* Extracts an array of objects from an object array based on the property name needed to extract.
*/
class net.indivision.operation.Extract
{
	private function Extract()
	{
	}
	/**
	* @param array an Array of Objects.
	* @param property the property to extract from the Objects.
	* @return a new array of the properties extracted from the target array.
	*/
	public static function getResults(array:Array, property:String):Array
	{
		return Iteration.apply(function (z)
		{
			return z[property];
		}, array);
	}
}
