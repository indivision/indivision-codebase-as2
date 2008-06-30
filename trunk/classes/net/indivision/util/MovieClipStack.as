﻿/**
* Manages a stack of empty MovieClips, generated in an unobtrusive MovieClip on the _root.
*/
class net.indivision.util.MovieClipStack
{
	private function MovieClipStack()
	{
	}
	/**
	* Adds an empty MovieClip to the stack container on the _root.
	* @return a reference to the new MovieClip.
	*/
	public static function createMovieClip(Void):MovieClip
	{
		var b = getBase();
		var d = b.getNextHighestDepth();
		return b.createEmptyMovieClip("MC" + d, d);
	}
	/**
	* Removes the entire stack of MovieClips generated by MovieClipStack.
	*/
	public static function clear(Void):Void
	{
		_root.__indivision__MovieClipStack.removeMovieClip();
	}
	private static function getBase():MovieClip
	{
		if (_root.__indivision__MovieClipStack == undefined) {
			return _root.createEmptyMovieClip("__indivision__MovieClipStack", _root.getNextHighestDepth());
		}
		return _root.__indivision__MovieClipStack;
	}
}