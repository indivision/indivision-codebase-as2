import net.indivision.control.AbstractButton;
import net.indivision.control.CustomButtonStyle;
/**
* Represents button states by replacing visual representation with different attachments defined in a CustomButtonStyle object.
*/
class net.indivision.control.CustomButton extends AbstractButton
{
	public function CustomButton()
	{
		super();
		var cbs = new CustomButtonStyle();
		states = cbs.states;
		state = 0;
	}
	/**
	* Sets what movieclip to attach for a specified state.
	* @param stateID the state to affect (0 being the first state, 1 the second, etc).
	* @param linkage the linkage identifier of the movieclip to attach for the state.
	*/
	public function defineState(stateID:Number, linkage:String):Void
	{
		states[stateID] = linkage;
	}
	private function refresh():Void
	{
		interior.attachMovie(states[_state], "movieclip", 1);
		interior.movieclip.labelField.text = label;
	}
	/**
	* Represents button states by replacing visual representation with different attachments defined in a CustomButtonStyle object.
	*/
	public function set buttonStyle(customButtonStyle:CustomButtonStyle):Void
	{
		states = customButtonStyle.states;
	}
}
