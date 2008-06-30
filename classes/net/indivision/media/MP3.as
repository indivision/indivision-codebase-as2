import net.indivision.media.SoundClip;
import net.indivision.util.MovieClipStack;
import net.indivision.control.IScrubbable;
import mx.utils.Delegate;
/**
* For handling MP3 files.
*/
class net.indivision.media.MP3 extends SoundClip implements IScrubbable
{
	/**
	* Determines whether or not the MP3 plays on load automatically or waits for the play function to execute (false by default).
	*/
	public var doAutoPlay:Boolean = false;
	/**
	* @param url the URL to the MP3 to load.
	*/
	public function MP3(url:String)
	{
		super();
		load(url);
	}
	/**
	* @param url the URL to the MP3 to load.
	*/
	public function load(url:String):Void
	{
		if (url) {
			setTarget(url);
			if (doAutoPlay) {
				super.play();
			} else {
				super.stop();
			}
			super.load();
		}
	}
	private function capture(objInfo):Void
	{
		if (!_data) {
			_data = sound.id3;
			super.capture(objInfo);
		}
	}
	private function setTarget(url:String):Void
	{
		sound = new Sound(MovieClipStack.createMovieClip());
		sound.onID3 = Delegate.create(this, capture);
		sound.loadSound(url, doAutoPlay);
	}
}
