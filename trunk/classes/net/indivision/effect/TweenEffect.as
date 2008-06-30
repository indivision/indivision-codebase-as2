import net.indivision.effect.AbstractEffect;
import net.indivision.tween.PropertyTween;
import net.indivision.tween.Motion;
import mx.utils.Delegate;
/**
* An Effect with tween handling.
* @event onEffectUpdate broadcast each step of the tween. 
*/
class net.indivision.effect.TweenEffect extends AbstractEffect
{
	private var target:Object;
	private var propertyTween:PropertyTween;
	/**
	* @param customMotion Motion to apply.
	*/
	public function TweenEffect(customMotion:Motion)
	{
		super();
		propertyTween = new PropertyTween();
		propertyTween.motion = customMotion;
		propertyTween.addEventListener("onTweenUpdate", Delegate.create(this, checkTarget));
		propertyTween.addEventListener("onTweenComplete", Delegate.create(this, effectComplete));
	}
	/**
	* Apply TweenEffect to a target Object.
	* @param targetObject Object to apply TweenEffect to.
	*/
	public function apply(targetObject:Object)
	{
		target = targetObject;
		propertyTween.target = targetObject;
	}
	private function checkTarget():Void
	{
		dispatchEvent({type:"onEffectUpdate", target:this});
		if (target._name == undefined) {
			stop();
		}
	}
	private function effectComplete():Void
	{
		stop();
		complete();
	}
	private function stop():Void
	{
		propertyTween.stop();
	}
	/**
	* @param customMotion Motion to apply.
	*/
	public function set motion(customMotion:Motion):Void
	{
		propertyTween.motion = customMotion;
	}
}
