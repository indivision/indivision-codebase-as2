/**
* Executes a specified function on every object in an array.
*/
class net.indivision.operation.Run
{
	private function Run()
	{
	}
	/**
	* @param targetFunction Function to be performed as a string.
	* @param array an array of Objects to perform targetFunction on.
	*/
	public static function apply(targetFunction:String, array:Array):Void
	{
		var i:Number;
		for (i = 0; i < array.length; i++) {
			array[i][targetFunction].apply(array[i]);
		}
	}
}
