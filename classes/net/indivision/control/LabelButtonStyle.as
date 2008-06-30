import net.indivision.shape.ShapeStyle;
import net.indivision.shape.LineStyle;
import net.indivision.shape.FillStyle;
/**
* Contains information defining various combinations of TextLabel definitions to be used with LabelButton.
* @see net.indivision.control.LabelButton
*/
class net.indivision.control.LabelButtonStyle
{
	private var _states:Array;
	public function LabelButtonStyle()
	{
		_states = defaults();
	}
	/**
	* Sets what movieclip to attach for a specified state.
	* @param stateID the state to affect (0 being the first state, 1 the second, etc).
	* @param textFormat the TextFormat to use for formatting the text of that state.
	* @param shapeStyle the ShapeStyle to use for formatting the backdrop of that state.
	* @see TextFormat
	* @see net.indivision.shape.ShapeStyle
	*/
	public function defineState(stateID:Number, textFormat:TextFormat, shapeStyle:ShapeStyle):Void
	{
		states[stateID] = {f:textFormat, s:shapeStyle};
	}
	private function defaults():Array
	{
		//
		var defaults:Array = [];
		//
		var black = new TextFormat();
		black.color = 0x000000;
		var white = new TextFormat();
		white.color = 0xFFFFFF;
		//
		defaults[0] = {textFormat:black, shapeStyle:new ShapeStyle(new LineStyle(0, 0x000000, 100), new FillStyle(0xFFFFFF, 100))};
		//
		defaults[1] = {textFormat:white, shapeStyle:new ShapeStyle(new LineStyle(0, 0x0033CC, 100), new FillStyle(0x0033CC, 100))};
		//
		defaults[2] = {textFormat:white, shapeStyle:new ShapeStyle(new LineStyle(0, 0x4242FF, 100), new FillStyle(0x4242FF, 100))};
		//
		return defaults;
	}
	/**
	* @return an Array of Objects with TextFormats and ShapeStyles used to represent buttons states in a LabelButton.
	* @see TextFormat
	* @see net.indivision.shape.ShapeStyle
	*/
	public function get states():Array
	{
		return _states;
	}
}
