import net.indivision.control.AbstractButton;
import net.indivision.control.LabelButtonStyle;
import net.indivision.shape.ShapeStyle;
import net.indivision.element.LabelBase;
/**
* Represents button states with various customized instances of TextLabel.
*/
class net.indivision.control.LabelButton extends AbstractButton
{
	private var _labelBase;
	public function LabelButton()
	{
		super();
		var lbs = new LabelButtonStyle();
		states = lbs.states;
		state = 0;
	}
	/**
	* Sets what properties to use for a specified state.
	* @param stateID the state to affect (0 being the first state, 1 the second, etc).
	* @param properties an Object containing the text formatting properties to be used for the state.
	*/
	public function defineState(stateID:Number, properties:Object):Void
	{
		states[stateID] = properties;
		if (stateID == state) {
			refresh();
		}
	}
	/**
	* Alters a text format property for all states without changing previous property settings.
	* @param property the property to change.
	* @param value the value to set the property to.
	*/
	public function alterFormat(property:String, value:Object):Void
	{
		var i;
		for (i in states) {
			states[i].textFormat[property] = value;
		}
		refresh();
	}
	private function alter(p:String, v:Object):Void
	{
		var i;
		for (i in states) {
			states[i][p] = v;
		}
		refresh();
	}
	private function refresh():Void
	{
		for (var i in states[_state]) {
			labelBase[i] = states[_state][i];
		}
	}
	/**
	* @return a reference to the LabelBase representing the LabelButton.
	* @see net.indivision.element.LabelBase
	*/
	public function get labelBase():LabelBase
	{
		return _labelBase;
	}
	/**
	* @param newWidth the width to set the label textField to.
	*/
	public function set width(newWidth:Number):Void
	{
		alter("width", newWidth);
	}
	/**
	* @param newHeight the height to set the label textField to.
	*/
	public function set height(newHeight:Number):Void
	{
		alter("height", newHeight);
	}
	/**
	* @param text the label text to display.
	*/
	public function set label(text:String):Void
	{
		alter("label", text);
	}
	/**
	* @param movieClip the MovieClip to use for representing the button (when it isn't already associated via linkage properties).
	*/
	public function set target(movieClip:MovieClip):Void
	{
		super.target = movieClip;
		_labelBase = new LabelBase(mc);
	}
}
