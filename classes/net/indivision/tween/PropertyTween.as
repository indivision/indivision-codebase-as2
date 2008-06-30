import net.indivision.tween.TweenBase;
import net.indivision.tween.Motion;
/**
* Handlers for tweening Object properties.
*/
class net.indivision.tween.PropertyTween extends TweenBase
{
	private var _target:Object;
	private var _delay:Number;
	private var properties:Array;
	private var startValues:Array;
	private var endValues:Array;
	private var equation:Function;
	private var interupt:Boolean;
	/**
	* @param targetObject Object to apply tween operations to.
	* @param customMotion the Motion to apply.
	*/
	public function PropertyTween(targetObject:Object, customMotion:Motion)
	{
		super(updateProperties);
		target = targetObject;
		motion = customMotion;
		snap = false;
	}
	/**
	* Moves the target from its current position to a new x:y location.
	* @param x _x position to move target to.
	* @param y _y position to move target to.
	* @param onComplete (optional) Function to execute on completion of tween.
	*/
	public function moveTo(x:Number, y:Number, onComplete:Function):Void
	{
		var currentX:Number = _target._x, currentY:Number = _target._y;
		onTweenComplete = onComplete;
		reset();
		if (currentX != x) {
			properties.push("_x");
			startValues.push(currentX);
			endValues.push(x - currentX);
		}
		if (currentY != y) {
			properties.push("_y");
			startValues.push(currentY);
			endValues.push(y - currentY);
		}
		start(0, delay);
	}
	/**
	* Moves the target a designated value(s) away from its current location.
	* @param x value to move on the x axis relative to current target x position.
	* @param y value to move on the y axis relative to current target y position.
	* @param onComplete (optional) Function to execute on completion of tween.
	*/
	public function moveFrom(x:Number, y:Number, onComplete:Function):Void
	{
		var currentX:Number = _target._x, currentY:Number = _target._y;
		onTweenComplete = onComplete;
		reset();
		if (x) {
			properties.push("_x");
			startValues.push(currentX);
			endValues.push(currentX + x);
		}
		if (y) {
			properties.push("_y");
			startValues.push(currentY);
			endValues.push(currentY + y);
		}
		start(0, delay);
	}
	/**
	* Alters a property or a set of properties from their current value(s) to a new value(s).
	* @param propertyList either a single property in String form or an Array of properties in String form (ie. "_height" or ["_height", "_width", "_alpha"]).
	* @param valueList either a single value or an Array of values corresponding to the propertyList (ie. 50 or [50, 32, 90]).
	* @param onComplete (optional) Function to execute on completion of tween.
	*/
	public function alter(propertyList:Object, valueList:Object, onComplete:Function):Void
	{
		var a:String;
		onTweenComplete = onComplete;
		reset();
		if (!(propertyList instanceof Array)) {
			propertyList = [propertyList];
		}
		if (!(valueList instanceof Array)) {
			valueList = [valueList];
		}
		for (a in propertyList) {
			properties.push(propertyList[a]);
			startValues.push(_target[propertyList[a]]);
			endValues.push(valueList[a] - _target[propertyList[a]]);
		}
		start(0, delay);
	}
	private function reset():Void
	{
		properties = [];
		startValues = [];
		endValues = [];
	}
	private function updateProperties(z:Number):Void
	{
		var a:String;
		for (a in properties) {
			_target[properties[a]] = equation(a, z);
		}
	}
	private function floatEquation(a:String, z:Number):Number
	{
		return startValues[a] + endValues[a] * z;
	}
	private function snapEquation(a:String, z:Number):Number
	{
		return Math.round(startValues[a] + endValues[a] * z);
	}
	/**
	* @param delayTime Number in milliseconds to delay before starting tween.
	*/
	public function set delay(delayTime:Number):Void
	{
		if (delayTime > 0) {
			_delay = delayTime;
		}
	}
	/**
	* @return Number in milliseconds tween will delay before starting.
	*/
	public function get delay():Number
	{
		return _delay;
	}
	/**
	* @param targetObject Object to apply tween operations to.
	*/
	public function set target(targetObject:Object):Void
	{
		_target = targetObject;
	}
	/**
	* @param doSnap determines whether or not property values should snap to integer values (default is false).
	*/
	public function set snap(doSnap:Boolean):Void
	{
		if (doSnap) {
			equation = snapEquation;
		} else {
			equation = floatEquation;
		}
	}
}
