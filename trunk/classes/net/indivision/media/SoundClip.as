import net.indivision.media.LinearMedia;
import net.indivision.util.MovieClipStack;
import net.indivision.control.IScrubbable;
/**
* For handling sound clips embedded in the movieclip library.
* @event onPlay Broadcast when sound is played.
*/
class net.indivision.media.SoundClip extends LinearMedia implements IScrubbable
{
	private var _volume:Number;
	private var lastPosition:Number = 0;
	/**
	* @param linkageID the linkage identifier for the sound from the movieclip library.
	*/
	public function SoundClip(linkageID:String)
	{
		target = linkageID;
	}
	/**
	* Starts sound.
	* @param startTime (optional) the amount of time to skip from the beginning of the sound in seconds.
	* @param loops (optional) the number of times to loop the sound.
	*/
	public function start(startTime:Number, loops:Number):Void
	{
		_isPlaying = true;
		sound.start(startTime, loops);
		dispatchEvent({type:"onPlay", target:this});
	}
	/**
	* @param newPosition the new play position to move the sound to as a number between 0 and 1.
	*/
	public function setPosition(newPosition:Number):Void
	{
		lastPosition = newPosition;
		sound.stop();
		if (isPlaying()) {
			start((newPosition * duration) / 1000);
		}
	}
	/**
	* @return the current sound play position as a number between 0 and 1.
	*/
	public function getPosition():Number
	{
		return sound.position / duration;
	}
	/**
	* @return 1 as a SoundClip is always already loaded with the swf.
	*/
	public function getLoaded():Number
	{
		return 1;
	}
	private function playMedia():Void
	{
		sound.start((lastPosition * duration) / 1000);
	}
	private function stopMedia():Void
	{
		lastPosition = 0;
		sound.stop();
	}
	private function pauseMedia():Void
	{
		lastPosition = getPosition();
		sound.stop();
	}
	/**
	* @return the length of the sound in seconds.
	*/
	public function get duration():Number
	{
		return sound.duration;
	}
	/**
	* @param linkageID the linkage identifier for the sound from the movieclip library.
	*/
	public function set target(linkageID:String):Void
	{
		if (linkageID) {
			sound = new Sound(MovieClipStack.createMovieClip());
			sound.attachSound(linkageID);
		}
	}
	/**
	* @return the current sound volume.
	*/
	public function get volume():Number
	{
		return sound.getVolume();
	}
	/**
	* @param newVolume the new sound volume.
	*/
	public function set volume(newVolume:Number):Void
	{
		sound.setVolume(newVolume);
	}
}
