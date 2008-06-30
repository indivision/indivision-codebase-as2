import net.indivision.event.StageBeacon;
import net.indivision.arrange.StagePosition;
import mx.utils.Delegate;
/**
* Maintains custom positioning and size qualities for Objects on the stage as the Stage's size is changed.
* @see net.indivision.arrange.StagePosition
*/
class net.indivision.arrange.StageManager
{
	private var stageBeacon:StageBeacon;
	private var objectList:Array;
	public function StageManager()
	{
		reset();
	}
	/**
	* Starts listening for stage re-size events and updates registered Objects on change.
	*/
	public function initialize():Void
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		stageBeacon = new StageBeacon();
		stageBeacon.addEventListener("onChange", Delegate.create(this, update));
	}
	/**
	* Clears all registered Objects.
	*/
	public function reset():Void
	{
		objectList = [];
	}
	/**
	* Clears all registered Objects.
	* @param target the Object to register.
	* @param stagePosition (optional) the StagePosition to apply to this Object on updates. (if this parameter is omitted, the target position at the time of registry is used.)
	* @see net.indivision.arrange.StagePosition
	*/
	public function registerObject(target:Object, stagePosition:StagePosition):Void
	{
		if (stagePosition == undefined) {
			var sp = new StagePosition();
			stagePosition = sp.conformPosition(target);
		}
		objectList.push({target:target, stagePosition:stagePosition});
	}
	/**
	* Iterates through all registered Objects and applies to each its corresponding StagePosition.
	*/
	public function update():Void
	{
		var i;
		for (i in objectList) {
			objectList[i].stagePosition.apply(objectList[i].target);
		}
	}
}
