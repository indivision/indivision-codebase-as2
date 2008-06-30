import net.indivision.arrange.Align;
import net.indivision.arrange.Distribute;
import net.indivision.layout.AbstractLayout;
/**
* Arranges series of Objects in an Array into a row.
*/
class net.indivision.layout.Row extends AbstractLayout
{
	/**
	* The amount of space in pixels to place between Objects.
	*/
	public var spacing:Number = 0;
	private var _justify:String = "center";
	public function Row()
	{
	}
	/**
	* Arranges the array of Objects into a row.
	* @param array the Array of Objects to be arranged.
	*/
	public function arrange(array:Array):Void
	{
		super.arrange(array);
		Align[_justify](array);
		Distribute.horizontalSpacing(array, spacing);
	}
	/**
	* Determines what vertical justification to use when laying out the Objects ("center" by default). 
	* @param position Vertical justification. Valid options are "top", "bottom" or "center".
	*/
	public function set justify(position:String):Void
	{
		position = position.toLowerCase();
		if (position == "top" || position == "bottom") {
			_justify = position;
		} else if (position == "center") {
			_justify = "vertical";
		} else {
			trace("**Error** Row: Illegal justify value: '" + position + "'. Use 'top', 'bottom' or 'center'.");
		}
	}
}
