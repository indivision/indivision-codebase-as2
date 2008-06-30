/**
* Sends a variable to a java alert box. Helpful for simple debugging outside of flash application.
*/
class net.indivision.debug.JavaAlert
{
	private function JavaAlert()
	{
	}
	/**
	* @param message message to trace to alert box.
	*/
	public static function send(message:Object):Void
	{
		getURL('javascript:alert(\"' + message + '\")');
	}
}
