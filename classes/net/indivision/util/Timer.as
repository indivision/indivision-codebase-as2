import net.indivision.core.AbstractDispatcher;
import mx.utils.Delegate;
/**
* Dispatches an event after a set number of seconds and optionally continuing to dispatch events at that interval.
* @event onTimer Broadcast when start has been run and the delay passes. Will continue to broadast at intervals optionally.
*/
class net.indivision.util.Timer extends AbstractDispatcher
{
	private var id:Number;
	private var _delay:Number;
	private var _loop:Boolean;
	/**
	* Sets Timer to the default values (10 second delay, loop is true).
	*/
	public function Timer(Void)
	{
		super();
		delay = 10;
		loop = true;
	}
	/**
	* Starts the timer.
	*/
	public function start(Void):Void
	{
		this.stop();
		id = setInterval(Delegate.create(this, time), _delay * 1000);
	}
	/**
	* Stops the timer.
	*/
	public function stop(Void):Void
	{
		clearInterval(id);
	}
	private function time():Void
	{
		dispatchEvent({type:"onTimer", target:this});
		if (!_loop) {
			this.stop();
		}
	}
	/**
	* @param seconds the number of seconds to wait before dispatching onTimer event.
	*/
	public function set delay(seconds:Number)
	{
		_delay = seconds;
	}
	/**
	* @param doLoop determines whether or not the timer continues to broadcast onTimer events at intervals or stops after one event.
	*/
	public function set loop(doLoop:Boolean)
	{
		_loop = doLoop;
	}
}
