/**
* Minimum functions required to work with Scrub.
* @see net.indivision.control.Scrub
*/
interface net.indivision.control.IScrubbable
{
	/**
	* @param newPosition the new play position to move the media to as a number between 0 and 1.
	*/
	function setPosition(newPosition:Number):Void;
	/**
	* @return the current media play position as a number between 0 and 1.
	*/
	function getPosition():Number;
	/**
	* @return the percent of bytes loaded, represented as a Number between 0 and 1.
	*/
	function getLoaded():Number;
	/**
	* @return whether or not the media is playing.
	*/
	function isPlaying():Boolean;
	/**
	* Plays the media.
	* @param url (optional) the URL to the media to load.
	*/
	function play(url:String):Void;
	/**
	* Stops the media.
	*/
	function stop():Void;
	/**
	* Pauses the media.
	*/
	function pause():Void;
}
