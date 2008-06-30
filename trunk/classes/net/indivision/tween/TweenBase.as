import net.indivision.core.AbstractDispatcher;
import net.indivision.tween.Motion;
import mx.utils.Delegate;
/**
* A number of handler methods that incrementally report to a specified Function a value between 0 and 1. The behavior of the increments is defined by a specified Motion object.
* @event onTweenStart Broadcast when tween starts.
* @event onTweenStop Broadcast when tween is stopped.
* @event onTweenResume Broadcast when tween is resumed.
* @event onTweenComplete Broadcast when tween completes.
* @event onTweenUpdate Broadcase each step of the tween.
*/
class net.indivision.tween.TweenBase extends AbstractDispatcher
{
	/**
	* Called upon tween completion.
	*/
	public var onTweenComplete:Function;
	private var _targetFunction:Function;
	private var _motion:Motion;
	private var position:Number = 0;
	private var intervalID:Number;
	private var handlerID:Object;
	public function TweenBase(target:Function, customMotion:Motion)
	{
		if (customMotion) {
			motion = customMotion;
		} else {
			motion = new Motion();
		}
		targetFunction = target;
	}
	/**
	* Starts reporting values to target Function.
	* @param startPosition (optional) Number between 0 and 1 representing the value to start reporting (default is 0).
	* @param delay (optional) delay in milliseconds to wait before starting.
	*/
	public function start(startPosition:Number, delay:Number):Number
	{
		if (startPosition) {
			position = startPosition;
		} else {
			position = 0;
		}
		if (delay) {
			delayedStart(delay, startPosition);
		} else {
			dispatchEvent({type:"onTweenStart", target:this});
			startTween();
			return position;
		}
	}
	/**
	* Starts reporting after a delay.
	* @param delay delay in milliseconds to wait before starting.
	* @param startPosition (optional) Number between 0 and 1 representing the value to start reporting (default is 0).
	*/
	public function delayedStart(delay:Number, startPosition:Number):Void
	{
		intervalID = setInterval(Delegate.create(this, start), delay, startPosition);
	}
	/**
	* Stops reporting.
	* @return Number represention the position of the tween at the time of the stop.
	*/
	public function stop():Number
	{
		destroy();
		dispatchEvent({type:"onTweenStop", target:this});
		return position;
	}
	/**
	* Resumes reporting.
	* @return Number represention the position of the tween at the time of the resume.
	*/
	public function resume():Number
	{
		dispatchEvent({type:"onTweenResume", target:this});
		startTween();
		return position;
	}
	/**
	* Changes the tween position and reports to target Function.
	* @param newPosition Number between 0 and 1 representing new position to jump to.
	*/
	public function goto(newPosition:Number):Void
	{
		destroy();
		position = newPosition;
		update();
	}
	private function startTween():Void
	{
		destroy();
		if (_motion.rate > 0) {
			intervalID = setInterval(Delegate.create(this, onEnterFrame), _motion.rate);
		} else {
			handlerID = Delegate.create(this, onEnterFrame);
			_global.MovieClip.addEventListener("onEnterFrame", handlerID);
		}
	}
	private function destroy():Void
	{
		clearInterval(intervalID);
		_global.MovieClip.removeEventListener("onEnterFrame", handlerID);
	}
	private function onEnterFrame():Void
	{
		position++;
		if (position <= _motion.steps) {
			update();
		} else {
			destroy();
			dispatchEvent({type:"onTweenComplete", target:this});
			onTweenComplete({type:"onTweenComplete", target:this});
		}
		updateAfterEvent();
	}
	private function report():Number
	{
		return _motion.equation(position * _motion.step, 0, 1, 1, _motion.parameter1, _motion.parameter2);
	}
	private function update():Void
	{
		var z:Number = report();
		_targetFunction.apply(this, [z]);
		dispatchEvent({type:"onTweenUpdate", target:this, report:z});
	}
	/**
	* @param customMotion the Motion to apply.
	*/
	public function set motion(customMotion:Motion)
	{
		if (customMotion) {
			_motion = customMotion;
		}
	}
	/**
	* @param target Function to report value to.
	*/
	public function set targetFunction(target:Function)
	{
		_targetFunction = target;
	}
	/**
	* @param target (optional) Function to report value to.
	* @param customMotion (optional) the Motion to apply.
	*/
}
