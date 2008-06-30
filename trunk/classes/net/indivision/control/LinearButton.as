import net.indivision.control.AbstractButton;
/**
* Represents different button states by changing a movieclip's frame, starting with state 0 being frame 1 of the clip.
*/
class net.indivision.control.LinearButton extends AbstractButton
{
	public function LinearButton()
	{
		super();
		state = 0;
	}
	private function refresh():Void
	{
		mc.gotoAndStop(_state + 1);
		super.refresh();
	}
}
