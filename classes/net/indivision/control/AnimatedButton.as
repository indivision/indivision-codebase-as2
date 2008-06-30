import net.indivision.control.AbstractButton;
import net.indivision.element.Animation;
import mx.utils.Delegate;
/**
* A button that represents various states by animating between anchor points on a movieclip timeline.
*/
class net.indivision.control.AnimatedButton extends AbstractButton
{
	private var animation;
	public function AnimatedButton()
	{
		super();
		animation = new Animation(mc);
		state = 0;
	}
	/**
	* Removes AnimatedButton.
	*/
	public function removeMovieClip()
	{
		animation.stop();
		super.removeMovieClip();
	}
	private function refresh():Void
	{
		animation.state = _state;
		super.refresh();
	}
}
