/**
* Gets the actual boundary edge or center of an Object regardless of its contents position relative to x:0, y:0.
*/
class net.indivision.arrange.Boundary
{
	private function Boundary()
	{
	}
	/**
	* Gets the actual boundary edge or center of an Object regardless of its contents position relative to x:0, y:0.
	* @param valueType the boundary or center-line to return. Can be "hcenter", "vcenter", "left", "right", "top" or "bottom".
	* @param target the Object to get the boundary or center-line from.
	* @return a Number representing the valueType of the target.
	*/
	public static function getValue(valueType:String, target:Object):Number
	{
		if (typeof (target) == "movieclip") {
			var bounds = target.getBounds();
			var xfactor = target._xscale / 100;
			var yfactor = target._yscale / 100;
			switch (valueType) {
			case "hcenter" :
				return (((bounds.xMax * xfactor) - (bounds.xMin * xfactor)) / 2) + (bounds.xMin * xfactor);
			case "vcenter" :
				return (((bounds.yMax * yfactor) - (bounds.yMin * yfactor)) / 2) + (bounds.yMin * yfactor);
			case "left" :
				return bounds.xMin * xfactor;
			case "right" :
				return bounds.xMax * xfactor;
			case "top" :
				return bounds.yMin * yfactor;
			case "bottom" :
				return bounds.yMax * yfactor;
			}
		} else {
			switch (valueType) {
			case "hcenter" :
				return target._x + (target._width / 2);
			case "vcenter" :
				return target._y + (target._height / 2);
			case "left" :
				return target._x;
			case "right" :
				return target._x + target._width;
			case "top" :
				return target._y;
			case "bottom" :
				return target._y + target._height;
			}
		}
	}
}
