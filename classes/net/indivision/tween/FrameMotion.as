import mx.utils.Delegate;
import net.indivision.event.FrameEventBeacon;
import net.indivision.core.AbstractDispatcher;
/**
* Allows playing a movieclip at variable rates, forward or backward.
* @event onFrameForward Broadcasts when FrameMotion starts moving the animation forward.
* @event onFrameReverse Broadcasts when FrameMotion starts moving the animation in reverse.
* @event onFrameStop Broadcasted when FrameMotion stops the animation.
* @event onFrameUpdate Broadcasted each step of the FrameMotion controlled animation.
*/
class net.indivision.tween.FrameMotion extends AbstractDispatcher
{
	private var _target:MovieClip;
	private var _rate:Number;
	private var onEnterFrame:Function;
	private var intervalID:Number;
	private var delegate:Function;
	public function FrameMotion()
	{
		super();
		rate = 0;
	}
	/**
	* Play target MovieClip forward.
	*/
	public function forward():Void
	{
		destroy();
		dispatchEvent({type:"onFrameForward", target:this});
		onEnterFrame = Delegate.create(this, stepForward);
		start();
	}
	/**
	* Play target MovieClip backward.
	*/
	public function reverse():Void
	{
		destroy();
		dispatchEvent({type:"onFrameReverse", target:this});
		onEnterFrame = Delegate.create(this, stepBack);
		start();
	}
	/**
	* Stop target MovieClip.
	*/
	public function stop():Void
	{
		destroy();
		dispatchEvent({type:"onFrameStop", target:this});
	}
	private function start():Void
	{
		destroy();
		if (rate > 0) {
			intervalID = setInterval(this, "onEnterFrame", rate);
		} else {
			delegate = Delegate.create(this, onEnterFrame);
			_global.MovieClip.addEventListener("onEnterFrame", delegate);
		}
	}
	private function stepForward():Void
	{
		if (_target._currentframe == _target._totalframes) {
			_target.gotoAndStop(1);
		} else {
			_target.nextFrame();
		}
		dispatchEvent({type:"onFrameUpdate", target:this});
	}
	private function stepBack():Void
	{
		if (_target._currentframe == 1) {
			_target.gotoAndStop(_target._totalframes);
		} else {
			_target.prevFrame();
		}
		dispatchEvent({type:"onFrameUpdate", target:this});
	}
	private function destroy():Void
	{
		clearInterval(intervalID);
		_global.MovieClip.removeEventListener("onEnterFrame", delegate);
	}
	/**
	* @param milliseconds time in milliseconds to delay before advancing the frame.
	*/
	public function set rate(milliseconds:Number)
	{
		destroy();
		if (milliseconds) {
			_rate = milliseconds;
		} else {
			_rate = 0;
		}
		if (_rate == 0) {
			FrameEventBeacon.initialize();
		}
	}
	/**
	* @return time in milliseconds of delay before frame advance.
	*/
	public function get rate():Number
	{
		return _rate;
	}
	/**
	* @param newTarget MovieClip to affect.
	*/
	public function set target(newTarget:MovieClip)
	{
		_target = newTarget;
	}
}
