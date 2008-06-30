import net.indivision.media.LinearMedia;
import net.indivision.control.IScrubbable;
/**
* For handling video clips that are embedded into a swf.
*/
class net.indivision.media.VideoClip extends LinearMedia implements IScrubbable
{
	private var _volume:Number;
	public function VideoClip()
	{
		super();
	}
	/**
	* @param newPosition the new play position to move the video to as a number between 0 and 1.
	*/
	public function sePosition(newPosition:Number):Void
	{
		_target.gotoAndStop(Math.round(newPosition * duration));
		if (isPlaying) {
			_isPlaying = false;
			super.play();
		}
	}
	/**
	* @return the current video play position as a number between 0 and 1.
	*/
	public function gePosition():Number
	{
		return _target._currentframe / duration;
	}
	private function playMedia():Void
	{
		_target.play();
	}
	private function stopMedia():Void
	{
		_target.stop();
	}
	/**
	* @return the Number of total frames in the video clip.
	*/
	public function get duration():Number
	{
		return _target._totalframes;
	}
	/**
	* @param video the taget Video for the class to manage.
	*/
	public function set target(video:Video):Void
	{
		super.target = video;
		sound = new Sound(video);
	}
}
