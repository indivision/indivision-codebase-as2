import net.indivision.operation.Iteration;
/**
* Sets a specified value to a specified property to every object in an array.
*/
class net.indivision.operation.Set
{
	private function Set()
	{
	}
	/**
	* @param array an Array of Objects to affect.
	* @param value the value to change to.
	* @param property (optional) the property to change. Changes the value of the Array element if omitted.
	*/
	public static function apply(array:Array, value:Object, property:String):Void
	{
		Iteration.apply(function (z, i)
		{
			if (property) {
				z[property] = value;
			} else {
				array[i] = value;
			}
		}, array);
	}
}
