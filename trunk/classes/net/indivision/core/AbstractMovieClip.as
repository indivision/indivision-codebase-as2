/**
* Copyright (C) 2005 Joseph Miller, USA
* http://code.indivision.net
*/
import mx.events.EventDispatcher;
/**
* Foundation MovieClip extension. Supports the ability to instantiate as a handler class, targeting an external MovieClip.
*/
class net.indivision.core.AbstractMovieClip extends MovieClip
{
	private var _mc:MovieClip;
	public function AbstractMovieClip()
	{
		_mc = this;
	}
	/**
	* @return a reference to the MovieClip (which is the same as the class when linked but not when defined as a target in the constructor.)
	*/
	public function get mc():MovieClip
	{
		return _mc;
	}
	/**
	* @return MovieClip path as a string.
	*/
	public function toString():String
	{
		if (mc == this) {
			return "[AbstractMovieClip]";
		} else {
			return "[AbstractMovieClip: " + _mc + " ]";
		}
	}
}
