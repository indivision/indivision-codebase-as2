import net.indivision.media.SoundClip;
import net.indivision.media.MP3;
/**
* Static class for managing and playing sounds.
* @todo add global and group adjustments.
*/
class net.indivision.media.AudioManager
{
	private static var sounds:Object = {};
	private function AudioManager()
	{
	}
	/**
	* Register an embedded sound with the AudioManager.
	* @param audioID an identifier for the new sound.
	* @param soundID the sounds linkage identifier from the movie-clip library.
	* @param group a group identifier for group adjustments.
	* @return a reference to the new SoundClip.
	*/
	public static function registerClip(audioID:Object, soundID:String, group:String):SoundClip
	{
		sounds[audioID] = {sound:new SoundClip(soundID), group:group, type:"clip", volume:100};
		return sounds[audioID].sound;
	}
	/**
	* Register an mp3 file with the AudioManager.
	* @param audioID an identifier for the new sound.
	* @param url the path to the mp3 file.
	* @param group a group identifier for group adjustments.
	* @return a reference to the new MP3.
	*/
	public static function registerMP3(audioID:Object, url:String, group:String):MP3
	{
		sounds[audioID] = {sound:new MP3(), group:group, type:"mp3"};
		sounds[audioID].sound.load(url);
		return sounds[audioID].sound;
	}
	/**
	* @param audioID the identifier for the sound to play.
	*/
	public static function play(audioID:Object):Void
	{
		sounds[audioID].sound.play();
	}
	/**
	* @param audioID the identifier for the sound to stop.
	*/
	public static function stop(audioID:Object):Void
	{
		sounds[audioID].sound.stop();
	}
	/**
	* Starts a sound.
	* @param audioID the identifier for the sound to stop.
	* @param startTime (optional) the amount of time to skip from the beginning of the sound in seconds.
	* @param loops (optional) the number of times to loop the sound.
	*/
	public static function start(audioID:Object, startTime:Number, loops:Number):Void
	{
		sounds[audioID].sound.start(startTime, loops);
	}
	/**
	* @param audioID the identifier for the sound to stop.
	* @param newVolume new volume to use for sound.
	*/
	public static function volume(audioID:Object, newVolume:Number):Void
	{
		var s = sounds[audioID];
		s.volume = newVolume;
		s.sound.volume = newVolume;
	}
}
