/**
* Accepts html-like properties ( width, align, valign ) and applies them to a target Object.
* @see net.indivision.arrange.StageManager
* @todo apply Boundary class to the positioning so that the system doesn't count on Objects being placed on x:0, y:0.
*/
class net.indivision.arrange.StagePosition
{
	private static var ATTRIBUTE_LIST:Array = ["width", "height", "align", "valign"];
	private var _align:String;
	private var _valign:String;
	private var _width:String;
	private var _height:String;
	private var _xModifier:Number = 0;
	private var _yModifier:Number = 0;
	private var _widthModifier:Number = 0;
	private var _heightModifier:Number = 0;
	public function StagePosition()
	{
	}
	/**
	* Applies the defined positioning and sizing behaviors to an Object based on the curent Stage dimensions.
	* @param target the Object to apply the positioning and sizing behaviors to.
	*/
	public function apply(target:Object):Void
	{
		var i;
		for (i in ATTRIBUTE_LIST) {
			var string = this[ATTRIBUTE_LIST[i]].toLowerCase();
			if (string.substr(-1, 1) == "%") {
				applyRatio(target, ATTRIBUTE_LIST[i], stringToRatio(string));
			} else if (string == "center") {
				applyRatio(target, ATTRIBUTE_LIST[i], .5);
			} else if (string == "top" || string == "left") {
				switch (ATTRIBUTE_LIST[i]) {
				case "align" :
				case "valign" :
					applyRatio(target, ATTRIBUTE_LIST[i], 0);
					break;
				case "width" :
					applyValue(target, "width", stringToValue(align, Stage.width));
					applyValue(target, "align", 0);
					break;
				case "height" :
					applyValue(target, "height", stringToValue(valign, Stage.height));
					applyValue(target, "valign", 0);
					break;
				}
			} else if (string == "bottom" || string == "right") {
				switch (ATTRIBUTE_LIST[i]) {
				case "align" :
				case "valign" :
					applyRatio(target, ATTRIBUTE_LIST[i], 1);
					break;
				case "width" :
					applyValue(target, "width", stringToValue(align, Stage.width, true));
					break;
				case "height" :
					applyValue(target, "height", stringToValue(valign, Stage.height, true));
					break;
				}
			} else {
				applyValue(target, ATTRIBUTE_LIST[i], Number(string));
			}
		}
	}
	/**
	* Sets the align, valign, width and height properties to percentage values based on the current x and y positions as well as the width and height of the target, relative to the current dimensions of the Stage.
	* @param target the Object to base the x, y, width and height values on.
	*/
	public function conformAll(target:Object):StagePosition
	{
		conformSize(target);
		return conformPosition(target);
	}
	/**
	* Sets the width and height properties to percentage values based on the current width and height of the target, relative to the current dimensions of the Stage.
	* @param target the Object to base the width and height values on.
	*/
	public function conformSize(target:Object):StagePosition
	{
		conform(target, "width");
		conform(target, "height");
		return this;
	}
	/**
	* Sets the align and valign properties to percentage values based on the current x and y position of the target, relative to the current dimensions of the Stage.
	* @param target the Object to base the align and valign values on.
	*/
	public function conformPosition(target:Object):StagePosition
	{
		conform(target, "align");
		conform(target, "valign");
		return this;
	}
	/**
	* Sets a designated property to a percentage value based on the current position or size of the target, relative to the current dimensions of the Stage.
	* @param target the Object to base the position or size on.
	* @param property the property to change. Acceptable values are: "width", "height", "align" or "valign".
	*/
	public function conform(target:Object, property:String):Void
	{
		switch (property) {
		case "width" :
			width = ((target._width / Stage.width) * 100) + "%";
			break;
		case "height" :
			height = ((target._height / Stage.height) * 100) + "%";
			break;
		case "align" :
			align = ((target._x / Stage.width) * 100) + "%";
			break;
		case "valign" :
			valign = ((target._y / Stage.height) * 100) + "%";
			break;
		}
	}
	private function stringToValue(string:String, base:Number, isInverse:Boolean):Number
	{
		var result:Number;
		if (string.substr(-1, 1) == "%") {
			result = stringToRatio(string) * base;
		} else {
			switch (string) {
			case "left" :
			case "top" :
				result = 0;
				break;
			case "right" :
			case "bottom" :
				result = base;
				break;
			case "center" :
				result = .5 * base;
				break;
			default :
				result = Number(string);
			}
		}
		if (isInverse) {
			result = base - result;
		}
		return result;
	}
	private function stringToRatio(string:String):Number
	{
		return Number(string.substr(0, string.length - 1)) / 100;
	}
	private function applyRatio(target:Object, attribute:String, ratio:Number):Void
	{
		switch (attribute) {
		case "align" :
		case "width" :
			applyValue(target, attribute, ratio * Stage.width);
			break;
		case "valign" :
		case "height" :
			applyValue(target, attribute, ratio * Stage.height);
			break;
		}
	}
	private function applyValue(target:Object, attribute:String, value:Number):Void
	{
		switch (attribute) {
		case "align" :
			if (target.move !== undefined) {
				target.move(value + xModifier, target.y);
			} else {
				target._x = value + xModifier;
			}
			break;
		case "valign" :
			if (target.move !== undefined) {
				target.move(target.x, value + yModifier);
			} else {
				target._y = value + yModifier;
			}
			break;
		case "width" :
			if (target.width !== undefined) {
				if (target.setSize !== undefined) {
					target.setSize(value + widthModifier, target.height);
				} else {
					target.width = value + widthModifier;
				}
			} else {
				target._width = value + widthModifier;
			}
			break;
		case "height" :
			if (target.height !== undefined) {
				if (target.setSize !== undefined) {
					target.setSize(target.width, value + heightModifier);
				} else {
					target.height = value + heightModifier;
				}
			} else {
				target._height = value + heightModifier;
			}
			break;
		}
	}
	/**
	* @return the current align value, affecting the horizontal placement of a target Object when applied.
	*/
	public function get align():String
	{
		return _align;
	}
	/**
	* @param alignString defines the behavior of horizontal placement of a target Object when applied. Acceptable values are: "left", "center", "right", a number ("3", "325", etc.) or a percentage ("50%", "33%", etc.).
	*/
	public function set align(alignString:String):Void
	{
		_align = alignString;
	}
	/**
	* @return the current valign value, affecting the vertical placement of a target Object when applied.
	*/
	public function get valign():String
	{
		return _valign;
	}
	/**
	* @param valignString defines the behavior of vertical placement of a target Object when applied. Acceptable values are: "top", "center", "bottom", a number ("3", "325", etc.) or a percentage ("50%", "33%", etc.).
	*/
	public function set valign(valignString:String):Void
	{
		_valign = valignString;
	}
	/**
	* @return the current width value, affecting the width of a target Object when applied.
	*/
	public function get width():String
	{
		return _width;
	}
	/**
	* @param widthString defines the behavior of width adjustment of a target Object when applied. Acceptable values are: "left", "right", a number ("3", "325", etc.) or a percentage ("50%", "33%", etc.).
	*/
	public function set width(widthString:String):Void
	{
		_width = widthString;
	}
	/**
	* @return the current height value, affecting the height of a target Object when applied.
	*/
	public function get height():String
	{
		return _height;
	}
	/**
	* @param heightString defines the behavior of height adjustment of a target Object when applied. Acceptable values are: "top", "bottom", a number ("3", "325", etc.) or a percentage ("50%", "33%", etc.).
	*/
	public function set height(heightString:String):Void
	{
		_height = heightString;
	}
	/**
	* @return the current xModifier value that is applied to the x position of the target after other x position adjustments are made (useful for margins, justifying Objects to edges, etc.).
	*/
	public function get xModifier():Number
	{
		return _xModifier;
	}
	/**
	* @param modifierNumber defines a number to be applied to the x position of the target after other x position adjustments are made (0 by default).
	*/
	public function set xModifier(modifierNumber:Number):Void
	{
		_xModifier = modifierNumber;
	}
	/**
	* @return the current yModifier value that is applied to the y position of the target after other y position adjustments are made (useful for margins, justifying Objects to edges, etc.).
	*/
	public function get yModifier():Number
	{
		return _yModifier;
	}
	/**
	* @param modifierNumber defines a number to be applied to the y position of the target after other y position adjustments are made (0 by default).
	*/
	public function set yModifier(modifierNumber:Number):Void
	{
		_yModifier = modifierNumber;
	}
	/**
	* @return the current widthModifier value that is applied to the width of the target after other width adjustments are made (useful for margins, justifying Objects to edges, etc.).
	*/
	public function get widthModifier():Number
	{
		return _widthModifier;
	}
	/**
	* @param modifierNumber defines a number to be applied to the width of the target after other width adjustments are made (0 by default).
	*/
	public function set widthModifier(modifierNumber:Number):Void
	{
		_widthModifier = modifierNumber;
	}
	/**
	* @return the current heightModifier value that is applied to the height of the target after other height adjustments are made (useful for margins, justifying Objects to edges, etc.).
	*/
	public function get heightModifier():Number
	{
		return _heightModifier;
	}
	/**
	* @param modifierNumber defines a number to be applied to the height of the target after other height adjustments are made (0 by default).
	*/
	public function set heightModifier(modifierNumber:Number):Void
	{
		_heightModifier = modifierNumber;
	}
}
