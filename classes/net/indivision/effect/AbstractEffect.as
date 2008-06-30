import net.indivision.core.AbstractDispatcher;
/**
* Foundation for visual effects. Contains generic/default event handlers.
* @event onEffectComplete broadcast when effect completes.
*/
class net.indivision.effect.AbstractEffect extends AbstractDispatcher
{
	private var _onComplete:Function;
	public function Effect()
	{
	}
	/**
	* Applies effect to target Object. Instantly completes by default.
	* @param target .
	*/
	public function apply(target:Object)
	{
		complete();
	}
	private function complete():Void
	{
		dispatchEvent({type:"onEffectComplete", target:this});
		onComplete({type:"onEffectComplete", target:this});
	}
	/**
	* @param completeFunction Function to run when visual effect completes.
	*/
	public function set onComplete(completeFunction:Function):Void
	{
		if (completeFunction) {
			_onComplete = completeFunction;
		}
	}
	/**
	* @return Function to run when visual effect completes.
	*/
	public function get onComplete():Function
	{
		return _onComplete;
	}
}
