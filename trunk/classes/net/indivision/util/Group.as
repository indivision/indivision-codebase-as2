import net.indivision.arrange.Axis;
/**
* Accepts an Array of Objects and provides basic positioning properties that affect the entire group as if they were one Object (same as using 'group' and adjusting in IDE).
*/
class net.indivision.util.Group
{
	private var items:Array;
	/**
	* @param itemArray Array of Objects to affect as a group.
	*/
	public function Group(itemArray:Array)
	{
		setItems(itemArray);
	}
	/**
	* Adds an item to the group.
	* @param item Object to add to group.
	*/
	public function addItem(item:Object):Void
	{
		items.push(item);
	}
	/**
	* Sets an Array of Objects to be affected as a group.
	* @param itemArray Array of Objects to affect as a group.
	*/
	public function setItems(itemArray:Array):Void
	{
		if (itemArray) {
			items = itemArray;
		} else {
			items = [];
		}
	}
	/**
	* @return the Array of Objects currently in the group.
	*/
	public function getItems():Array
	{
		return items;
	}
	/**
	* @return an Object containing the minimum and maximum boundaries of the group of Objects. Works the same as MovieClip.getBounds().
	*/
	public function getBounds():Object
	{
		var x = _x;
		var y = _y;
		return {xMin:x, xMax:x + _width, yMin:y, yMax:y + _height};
	}
	/**
	* Sets a mask to be used for all Objects in the group.
	* @param mask the MovieClip to use as the mask.
	*/
	public function setMask(mask:MovieClip):Void
	{
		var i = items.length;
		while (i--)
		{
			items[i].setMask(mask);
		}
	}
	private function adjustProperty(p:String, v:Number):Void
	{
		var i = items.length;
		while (i--)
		{
			items[i][p] += v;
		}
	}
	private function getLowest(p:String):Number
	{
		var lowest = Number.POSITIVE_INFINITY;
		var i = items.length;
		while (i--)
		{
			if (items[i][p] < lowest) {
				lowest = items[i][p];
			}
		}
		return lowest;
	}
	private function getHighest(p:String):Number
	{
		var highest = Number.NEGATIVE_INFINITY;
		var i = items.length;
		while (i--)
		{
			if (items[i][p] > highest) {
				highest = items[i][p];
			}
		}
		return highest;
	}
	private function topMost():Number
	{
		return findLimit("yMin");
	}
	private function rightMost():Number
	{
		return findLimit("xMax", true);
	}
	private function bottomMost():Number
	{
		return findLimit("yMax", true);
	}
	private function leftMost():Number
	{
		return findLimit("xMin");
	}
	private function findLimit(property:String, isMax:Boolean):Number
	{
		var result;
		if (isMax) {
			result = Number.NEGATIVE_INFINITY;
		} else {
			result = Number.POSITIVE_INFINITY;
		}
		var i = items.length;
		while (i--)
		{
			var bounds = items[i].getBounds(items[i]._parent);
			if (isMax) {
				if (bounds[property] > result) {
					result = bounds[property];
				}
			} else {
				if (bounds[property] < result) {
					result = bounds[property];
				}
			}
		}
		return result;
	}
	/**
	* @param x sets the x position of the group.
	*/
	public function set _x(x:Number):Void
	{
		adjustProperty("_x", x - getLowest("_x"));
	}
	/**
	* @return the x position of the group.
	*/
	public function get _x():Number
	{
		return getLowest("_x");
	}
	/**
	* @param y sets the y position of the group.
	*/
	public function set _y(y:Number):Void
	{
		adjustProperty("_y", y - getLowest("_y"));
	}
	/**
	* @return the y position of the group.
	*/
	public function get _y():Number
	{
		return getLowest("_y");
	}
	/**
	* @param width sets the width of the group.
	*/
	public function set _width(width:Number):Void
	{
		var w = _width;
		var x = _x;
		var ratio = width / w;
		var i = items.length;
		while (i--)
		{
			var xratio = (items[i]._x - x) / w;
			items[i]._width *= ratio;
			items[i]._x = x + (xratio * (w * ratio));
		}
	}
	/**
	* @return the width of the group.
	*/
	public function get _width():Number
	{
		return rightMost() - leftMost();
	}
	/**
	* @param height sets the height of the group.
	*/
	public function set _height(height:Number):Void
	{
		var h = _height;
		var y = _y;
		var ratio = height / h;
		var i = items.length;
		while (i--)
		{
			var yratio = (items[i]._y - y) / h;
			items[i]._height *= ratio;
			items[i]._y = y + (yratio * (h * ratio));
		}
	}
	/**
	* @return the height of the group.
	*/
	public function get _height():Number
	{
		return bottomMost() - topMost();
	}
	/**
	* @param alpha sets the alpha of the group, relative to the Object with the highest alpha.
	*/
	public function set _alpha(alpha:Number):Void
	{
		var change = alpha - _alpha;
		var i = items.length;
		while (i--)
		{
			items[i]._alpha += change;
		}
	}
	/**
	* @return the alpha of the group, based on the Object with the highest alpha.
	*/
	public function get _alpha():Number
	{
		return getHighest("_alpha");
	}
	/**
	* @return the parent MovieClip. This is assumed to be the parent of the first Object in the item list.
	*/
	public function get _parent():MovieClip
	{
		return items[0]._parent;
	}
}
