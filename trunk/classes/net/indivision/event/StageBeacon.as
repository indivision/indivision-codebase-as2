import net.indivision.core.AbstractDispatcher;
import mx.utils.Delegate;
/**
* Listens for stage resize events, dispatches change event and executes updateAfterEvent().
* @event onChange Broadcast when stage size is changed.
*/
class net.indivision.event.StageBeacon extends AbstractDispatcher
{
	/**
	* Begins dispatching "onChange" events whenever stage is resized.
	*/
	public function StageBeacon()
	{
		super();
		var myListener:Object = new Object();
		myListener.onResize = Delegate.create(this, update);
		Stage.addListener(myListener);
	}
	private function update():Void
	{
		dispatchEvent({type:"onChange"});
		updateAfterEvent();
	}
}
