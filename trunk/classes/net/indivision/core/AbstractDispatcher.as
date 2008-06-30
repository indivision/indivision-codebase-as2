import mx.events.EventDispatcher;
/**
* Foundation class with event dispatcher handlers.
* @see mx.events.EventDispatcher
*/
class net.indivision.core.AbstractDispatcher
{
	/**
	* Adds an event listener.
	* @see mx.events.EventDispatcher
	*/
	public var addEventListener:Function;
	/**
	* Removes an event listener.
	* @see mx.events.EventDispatcher
	*/
	public var removeEventListener:Function;
	private var dispatchEvent:Function;
	public function AbstractDispatcher()
	{
		EventDispatcher.initialize(this);
	}
	function toString():String
	{
		return "[Dispatcher]";
	}
}
