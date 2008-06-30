import net.indivision.arrange.Distribute;
/**
* Positions one Object in relation to another Object.
*/
class net.indivision.arrange.Position
{
	private function Position()
	{
	}
	/**
	* Places one Object in a position relative to a second Object.
	* @param staticObject the Object to place the second Object relative to.
	* @param moveObjectthe Object that will be moved.
	* @param position the position to place the moveObject. Can be "right", "top", "bottom", "topLeft", "topRight", "bottomLeft" or "bottomRight".
	* @param spacing (optional) amount of space to include between the Objects.
	*/
	public static function place(staticObject:Object, moveObject:Object, position:String, spacing:Number):Void
	{
		switch (position.toLowerCase()) {
		case "right" :
			Distribute.horizontalSpacing([staticObject, moveObject], spacing);
			break;
		case "top" :
			Distribute.verticalSpacing([staticObject, moveObject], spacing, true);
			break;
		case "bottom" :
			Distribute.verticalSpacing([staticObject, moveObject], spacing);
			break;
		case "topleft" :
			Distribute.verticalSpacing([staticObject, moveObject], spacing, true);
			Distribute.horizontalSpacing([staticObject, moveObject], spacing, true);
			break;
		case "topright" :
			Distribute.verticalSpacing([staticObject, moveObject], spacing, true);
			Distribute.horizontalSpacing([staticObject, moveObject], spacing);
			break;
		case "bottomleft" :
			Distribute.verticalSpacing([staticObject, moveObject], spacing);
			Distribute.horizontalSpacing([staticObject, moveObject], spacing, true);
			break;
		case "bottomright" :
			Distribute.verticalSpacing([staticObject, moveObject], spacing);
			Distribute.horizontalSpacing([staticObject, moveObject], spacing);
			break;
		default :
			Distribute.horizontalSpacing([staticObject, moveObject], spacing, true);
		}
	}
}
