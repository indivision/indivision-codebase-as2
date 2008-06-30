/**
* Applies a function to every object in an array and returns an array of all the results.
*/
class net.indivision.operation.Iteration
{
	private function Iteration()
	{
	}
	/**
	* @param askFunction the Function to apply to the Objects in the target Array.
	* @param target an Array of Objects.
	* @param argumentArray (optional) arguments to be passed into the askFunction in Array format.
	* @return an Array of the results of each askFunction being applied to each Object in the target Array.
	*/
	public static function apply(askFunction:Function, target:Array, argumentArray:Array):Array
	{
		var stack = [];
		var i:Number;
		for (i = 0; i < target.length; i++) {
			var arg:Array;
			if (argumentArray) {
				arg = argumentArray.slice();
				arg.unshift(target[i], i);
			} else {
				arg = [target[i], i];
			}
			stack.push(askFunction.apply(null, arg));
		}
		return stack;
	}
}
