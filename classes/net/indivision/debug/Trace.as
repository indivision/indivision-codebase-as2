/**
* Supplemental trace methods.
*/
class net.indivision.debug.Trace
{
	private static var profileObject:Object = {};
	private function Trace()
	{
	}
	/**
	* Iterates through all properties in a target Object and traces their name and value to the output window.
	* @param target the Object to iterate and trace through.
	* @param label (optional) a label to include in the trace output to help distinguish from other traces.
	*/
	public static function traceAll(target:Object, label:String):Void
	{
		if (label) {
			label = "[" + label + "]";
		} else {
			label = "";
		}
		trace("/-" + label + "----------------------");
		for (var i in target) {
			trace(i + " : " + target[i]);
		}
		trace("----------------------" + label + "-/");
	}
	/**
	* Adds a target Object to a profile Object that can later be traced for comparison purposes.
	* @param target the Object to add to profile.
	* @param label the identifier for the added Object.
	*/
	public static function addProfile(target:Object, label:String):Void
	{
		profileObject[label] = target;
	}
	/**
	* Iterates through all properties added with the addProfile method and traces their name and value to the output window.
	* @param label (optional) a label to include in the trace output to help distinguish from other traces.
	*/
	public static function traceProfiles(label:String):Void
	{
		traceAll(profileObject, label);
		profileObject = {};
	}
}
