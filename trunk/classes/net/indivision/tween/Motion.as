//import mx.transitions.OnEnterFrameBeacon;
import net.indivision.event.FrameEventBeacon;
/**
* A data object that holds all properties of a motion ( ease equation, number of steps and rate ).
*/
class net.indivision.tween.Motion
{
	/**
	* The ease equation to use.
	* @see com.robertpenner.easing
	*/
	public var equation:Function;
	/**
	* A supplemental parameter needed for some ease equations.
	*/
	public var parameter1:Number;
	/**
	* A supplemental parameter needed for some ease equations.
	*/
	public var parameter2:Number;
	private var argumentsList:Array = ["equation", "steps", "rate", "parameter1", "parameter2"];
	private var defaults:Array = [function (t, b, c, d)
	{
		return c * t / d + b;
	}, 10, 0, 0, 0];
	private var _steps:Number;
	private var _rate:Number;
	private var _step:Number;
	/**
	* @param equation the ease equation to use.
	* @param steps Number of steps in tween.
	* @param rate time in milliseconds to wait between each tween step. If undefined or 0, onEnterFrame is used.
	* @param parameter1 supplemental parameter needed for some ease equations.
	* @param parameter2 supplemental parameter needed for some ease equations.
	*/
	public function Motion(equation:Function, steps:Number, rate:Number, parameter1:Number, parameter2:Number)
	{
		var a:String;
		for (a in argumentsList) {
			if (arguments[a] == undefined) {
				this[argumentsList[a]] = defaults[a];
			} else {
				this[argumentsList[a]] = arguments[a];
			}
		}
	}
	/**
	* @param totalSteps Number of steps in tween.
	*/
	public function set steps(totalSteps:Number):Void
	{
		if (totalSteps) {
			_steps = totalSteps;
		} else {
			_steps = defaults[1];
		}
		_step = 1 / _steps;
	}
	/**
	* @return Number of steps in tween.
	*/
	public function get steps():Number
	{
		return _steps;
	}
	/**
	* @return the amount needed to step each tween step to total 1 by the end of all steps.
	*/
	public function get step():Number
	{
		return _step;
	}
	/**
	* @param milliseconds time in milliseconds to wait between each tween step. If undefined or 0, onEnterFrame is used.
	*/
	public function set rate(milliseconds:Number):Void
	{
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
	* @return time in milliseconds of wait between each tween step. If 0, onEnterFrame is used.
	*/
	public function get rate():Number
	{
		return _rate;
	}
	/**
	* @param seconds time in seconds of wait between each tween step.
	*/
	public function set time(seconds:Number):Void
	{
		if (seconds) {
			rate = (seconds * 1000) / steps;
		} else {
			rate = 0;
		}
	}
	/**
	* @return time in seconds of wait between each tween step.
	*/
	public function get time():Number
	{
		return (rate * steps) / 1000;
	}
}
