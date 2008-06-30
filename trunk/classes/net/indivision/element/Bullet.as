/**
* Positions a designated item (such as a bullet graphic) from the movieclip library offset from an Object.
*/
class net.indivision.element.Bullet
{
	private var _bullet:String;
	private var _xoffset:Number = -9;
	private var _yoffset:Number = 6;
	public function Bullet()
	{
	}
	/**
	* Attaches the designated graphic off set by the designated distances from a target Object.
	* @param target Object to place graphic relative to.
	*/
	public function attach(target:Object):Void
	{
		var obj = target._parent.attachMovie(graphic, target._name + "__" + graphic, target._parent.getNextHighestDepth());
		obj._x = target._x + xoffset;
		obj._y = target._y + yoffset;
	}
	/**
	* @param linkageTitle linkage title of item to be attached from the library.
	*/
	public function set graphic(linkageTitle:String):Void
	{
		if (linkageTitle) {
			_bullet = linkageTitle;
		}
	}
	/**
	* @param x the x distance to offset the attached item (ie. -5 would place the graphic 5 pixels to the left of the target Object).
	*/
	public function set xoffset(x:Number):Void
	{
		if (x != undefined) {
			_xoffset = x;
		}
	}
	/**
	* @param y the y distance to offset the attached item (ie. -5 would place the graphic 5 pixels above the target Object).
	*/
	public function set yoffset(y:Number):Void
	{
		if (y != undefined) {
			_yoffset = y;
		}
	}
}
