import net.indivision.media.AbstractMedia;
import net.indivision.control.IScrubbable;
/**
* Contains methods for handling media types that are linear ( sounds or video ).
* @event onPlay Broadcast when media is played.
* @event onStop Broadcast when media is stopped.
* @event onData Broadcast when metaData has loaded and is available.
*/
class net.indivision.media.LinearMedia extends AbstractMedia implements IScrubbable
{
	private var sound:Sound;
	private var _mute:Number = 0;
	private var _volume:Number;
	private var _isPlaying:Boolean;
	private var _trackProgress:Boolean = false;
	private var _data:Object;
	public function LinearMedia()
	{
	}
	/**
	* Plays the media.
	* @param url (optional) the URL to the media to load.
	*/
	public function play(url:String):Void
	{
		if (!isPlaying()) {
			_isPlaying = true;
			playMedia();
			dispatchEvent({type:"onPlay", target:this});
		}
	}
	/**
	* Stop media.
	*/
	public function stop():Void
	{
		if (isPlaying()) {
			_isPlaying = false;
			stopMedia();
			dispatchEvent({type:"onStop", target:this});
		}
	}
	/**
	* Pause media.
	*/
	public function pause():Void
	{
		if (isPlaying()) {
			_isPlaying = false;
			pauseMedia();
			dispatchEvent({type:"onPause", target:this});
		}
	}
	/**
	* toggles mute.
	*/
	public function mute():Void
	{
		if (_mute > 0) {
			volume = _mute;
		} else {
			_mute = volume;
			setVolume(0);
		}
	}
	/**
	* @param newPosition new position to set media to as a Number between 0 and 1.
	*/
	public function setPosition(newPosition:Number):Void
	{
		// Over-load.
	}
	/**
	* @return the current position of the media as a Number between 0 and 1.
	*/
	public function getPosition():Number
	{
		// Over-load.
		return 0;
	}
	/**
	* @return whether or not the media is playing.
	*/
	public function isPlaying():Boolean
	{
		return _isPlaying;
	}
	private function playMedia():Void
	{
	}
	private function stopMedia():Void
	{
	}
	private function pauseMedia():Void
	{
	}
	private function setVolume(v:Number):Void
	{
		_volume = v;
		sound.setVolume(v);
	}
	private function capture(objInfo):Void
	{
		dispatchEvent({type:"onData", target:this});
	}
	/**
	* @return meta data Object.
	*/
	public function get data():Object
	{
		return _data;
	}
	/**
	* @param newVolume new volume to play media at.
	*/
	public function set volume(newVolume:Number):Void
	{
		if (newVolume >= 0 && newVolume <= 100) {
			_mute = 0;
			setVolume(newVolume);
		}
	}
	/**
	* @return the current volume media is playing at.
	*/
	public function get volume():Number
	{
		return sound.getVolume();
	}
}
