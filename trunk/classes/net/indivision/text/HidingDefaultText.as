/**
* Sets a default text value to a TextField and animates the text in and out of the field as the user sets focus onto that field.
*/
class net.indivision.text.HidingDefaultText
{
	private function HidingDefaultText()
	{
	}
	/**
	* Sets the default text value to use and places functions onto the target field necessary for animating the text in and out of the field.
	* @param target the TextField to add the default text to.
	* @param text the default text to use.
	* @param isPassword (optional) whether or not to use password obscuring {'*').
	* @todo This class is a quick translation from legacy code. It needs to be re-structured to work without placing functions onto the target. The text animation routines should be separated into their own class as well.
	*/
	public static function setText(target:TextField, text:String, isPassword:Boolean):Void
	{
		target.isPassword = isPassword;
		target.defaultText = text;
		target.text = text;
		target.onSetFocus = function()
		{
			if (this.text == this.defaultText) {
				this.runText(this.defaultText, -1);
			}
		};
		target.onKillFocus = function()
		{
			if (this.text == "") {
				this.password = false;
				this.runText(this.defaultText);
			}
		};
		target.runText = function(word, d, e, s)
		{
			if (s == undefined) {
				s = 10;
			}
			if (e == undefined) {
				this.e = -1;
			} else {
				this.e = e;
			}
			if (this.intervalId != undefined) {
				clearInterval(this.intervalId);
			}
			if (d == -1) {
				this.text = word;
				this.step = -1;
				this.i = word.length;
				this.end = 0;
			} else {
				this.text = "";
				this.step = 1;
				this.i = 0;
				this.end = word.length;
			}
			this.intervalId = setInterval(this, "stepText", s, word);
		};
		target.stepText = function(w)
		{
			this.text = w.substr(this.i * this.e, this.i);
			if (this.i == this.end) {
				clearInterval(this.intervalId);
				delete this.intervalId;
				if (this.isPassword && this.end == 0) {
					this.password = true;
				}
			}
			this.i = this.i + this.step;
			updateAfterEvent();
		};
	}
}
