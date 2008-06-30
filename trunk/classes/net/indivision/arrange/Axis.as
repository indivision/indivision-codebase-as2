/**
* Provides methods to manipulate Objects relative to a specified point.
*/
class net.indivision.arrange.Axis
{
	private var _x:Number;
	private var _y:Number;
	/**
	* @param x the x position of the axis.
	* @param y the y position of the axis.
	*/
	public function Axis(x:Number, y:Number)
	{
		setPosition(x, y);
	}
	/**
	* @param x the x position of the axis.
	* @param y the y position of the axis.
	*/
	public function setPosition(x:Number, y:Number):Void
	{
		_x = x;
		_y = y;
	}
	/**
	* @return an Object containing the x and y position of the axis. Object structure: {x, y}
	*/
	public function getPosition():Object
	{
		return {x:_x, y:_y};
	}
	/**
	* Places an Object at a designated angle from the axis point.
	* @param target the Object to place.
	* @param angle the angle to place the Object at.
	* @param offset (optional) rotates the target based on its angle to the axis.
	*/
	public function setRotation(target:Object, angle:Number, offset:Number):Void
	{
		var radians = (angle * Math.PI) / 180;
		var radius = getDistance(target);
		target._x = _x + radius * Math.sin(radians);
		target._y = _y - radius * Math.cos(radians);
		if (offset !== undefined) {
			target._rotation = angle + offset;
		}
	}
	/**
	* @param target the Object to read the angle from.
	* @return the angle of the target from the axis point.
	*/
	public function getRotation(target:Object):Number
	{
		var deltax = _x - target._x;
		var deltay = _y - target._y;
		var angle = Math.atan2(deltay, deltax);
		angle /= (Math.PI / 180);
		angle -= 90;
		angle < 0 ? angle += 360 : angle = angle;
		return angle;
	}
	/**
	* @param target the Object to read the distance from.
	* @return the distance of the target from the axis point.
	*/
	public function getDistance(target:Object):Number
	{
		return Math.sqrt(Math.pow(target._x - _x, 2) + Math.pow(target._y - _y, 2));
	}
}
