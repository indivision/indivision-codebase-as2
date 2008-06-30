/**
* Copyright (C) 2005 Joseph Miller, USA
* http://code.indivision.net
*/
import mx.events.EventDispatcher;
import net.indivision.core.AbstractMovieClip;
/**
* AbstractMovieClip extension with eventDispatcher handling.
*/
class net.indivision.core.MovieClipDispatcher extends AbstractMovieClip
{
	/**
	* Adds an event listener.
	* @see mx.events.EventDispatcher
	*/
	public var addEventListener:Function;
	/**
	* Removes an event listener.
	* @see mx.events.EventDispatcher
	*/
	public var removeEventListener:Function;
	private var dispatchEvent:Function;
	public function MovieClipDispatcher()
	{
		super();
		EventDispatcher.initialize(this);
	}
}
