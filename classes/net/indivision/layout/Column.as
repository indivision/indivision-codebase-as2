import net.indivision.layout.AbstractLayout;
import net.indivision.arrange.Align;
import net.indivision.arrange.Distribute;
/**
* Arranges a series of Objects in an array into a column.
*/
class net.indivision.layout.Column extends AbstractLayout
{
	/**
	* The amount of space in pixels to place between Objects.
	*/
	public var spacing:Number = 0;
	private var _justify:String = "left";
	public function Column()
	{
	}
	/**
	* Arranges the array of Objects into a row.
	* @param array the Array of Objects to be arranged.
	*/
	public function arrange(array:Array):Void
	{
		super.arrange(array);
		Align[justify](array);
		Distribute.verticalSpacing(array, spacing);
	}
	/**
	* Determines what vertical justification to use when laying out the Objects ("left" by default). 
	* @param position Vertical justification. Valid options are "left", "right" or "center".
	*/
	public function set justify(position:String):Void
	{
		position = position.toLowerCase();
		if (position == "left" || position == "right") {
			_justify = position;
		} else if (position == "center") {
			_justify = "horizontal";
		} else {
			trace("**Error** Column: Illegal justify value: '" + position + "'. Use 'left', 'right' or 'center'.");
		}
	}
}
