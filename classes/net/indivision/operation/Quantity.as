import net.indivision.operation.AbstractAnalysis;
import net.indivision.operation.Iteration;
/**
* Returns one of a number of qualities from a set of objects in an array.
*/
class net.indivision.operation.Quantity extends AbstractAnalysis
{
	private function Quantity()
	{
	}
	/**
	* @param array an Array of Objects.
	* @param property the property to compare.
	* @return the highest property value returned.
	*/
	public static function high(array:Array, property:String):Number
	{
		find(isHigher, array, property);
		return val;
	}
	/**
	* @param array an Array of Objects.
	* @param property the property to compare.
	* @return the lowest property value returned.
	*/
	public static function low(array:Array, property:String):Number
	{
		find(isLower, array, property);
		return val;
	}
	/**
	* @param array an Array of Objects.
	* @param property the property to compare.
	* @return the average property value returned.
	*/
	public static function average(array:Array, property:String):Number
	{
		init(array, property);
		val = 0;
		Iteration.apply(addTo, array, [property]);
		return val / array.length;
	}
	/**
	* @param array an Array of Objects.
	* @param property the property to compare.
	* @return the sum of all property values returned.
	*/
	public static function sum(array:Array, property:String):Number
	{
		init(array, property);
		val = 0;
		Iteration.apply(addTo, array, [property]);
		return val;
	}
	/**
	* @param array an Array of Objects.
	* @param property the property to compare.
	* @return the multiplication of all property values returned.
	*/
	public static function multiplication(array:Array, property:String):Number
	{
		init(array, property);
		val = 1;
		Iteration.apply(multiply, array, [property]);
		return val;
	}
	private static function addTo(t:Object, i:Number, p:String)
	{
		val += qualify(t, p);
	}
	private static function multiply(t:Object, i:Number, p:String)
	{
		val *= qualify(t, p);
	}
}
