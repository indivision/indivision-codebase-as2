/**
* Contains movieclip identifiers for various button states.
* @see net.indivision.control.CustomButton
*/
class net.indivision.control.CustomButtonStyle
{
	private var _states:Array;
	public function CustomButtonStyle()
	{
		_states = defaults();
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
	/**
	* @return an Array of linkage identifiers of movieclips used to represent buttons states in a CustomButton (by default, a CustomButton will look for "button_out", "button_over" and "button_press").
	*/
	public function get states():Array
	{
		return _states;
	}
	private function defaults():Array
	{
		var defaults:Array = [];
		defaults[0] = "button_out";
		defaults[1] = "button_over";
		defaults[2] = "button_press";
		return defaults;
	}
}
