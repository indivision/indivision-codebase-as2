import net.indivision.effect.TweenEffect;
import net.indivision.tween.Motion;
/**
* Manipulates an Objects alpha property.
*/
class net.indivision.effect.Fade extends TweenEffect
{
	/**
	* (optional) determines what _alpha value the target should start at.
	*/
	public var startValue:Number;
	private var _value:Number;
	public function Fade()
	{
		super();
	}
	/**
	* Applies the Fade Effect to a target Object.
	* @param target Object to apply Fade to.
	* @param alpha a Number between 0 and 100, representing the alpha value of the target.
	*/
	public function apply(target:Object, alpha:Number):Void
	{
		value = alpha;
		super.apply(target);
		if (startValue != undefined) {
			target._alpha = startValue;
		}
		propertyTween.alter("_alpha", _value);
	}
	/**
	* @param alpha a Number between 0 and 100, representing the alpha value the target will tween to.
	*/
	public function set value(alpha:Number):Void
	{
		if (alpha >= 0 && alpha <= 100 && alpha != undefined) {
			_value = alpha;
		}
	}
	/**
	* @return the current alpha value.
	*/
	public function get value():Number
	{
		return _value;
	}
}
