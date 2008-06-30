import net.indivision.layout.IArrangeable;
/**
* Abstract class for types of arrangement classes such as Row and Column.
*/
class net.indivision.layout.AbstractLayout implements IArrangeable
{
	/**
	* Determines whether or not the layout records the previous layout (false by default). This can be useful for animating between layouts.
	*/
	public var track:Boolean = false;
	private var _recall:Array = null;
	public function AbstractLayout()
	{
	}
	/**
	* Arranges the array of Objects into a layout.
	* @param array the Array of Objects to be arranged.
	*/
	public function arrange(array:Array):Void
	{
		if (track) {
			memorize(array);
		}
	}
	private function memorize(l:Array)
	{
		_recall = [];
		var i;
		for (i = 0; i < l.length; i++) {
			_recall.push({x:l[i]._x, y:l[i]._y});
		}
	}
	/**
	* @return an Array of Objects containing the _x and _y properties of the arranged Objects before the arrange was applied last.
	*/
	public function get recall():Array
	{
		return _recall;
	}
}
