package guifes.collection;

class Command
{
	private var action:Dynamic -> Void;
	private var params:Dynamic;

	public function new(action:Dynamic -> Void, params:Dynamic = null)
	{
		this.action = action;
		this.params = params;
	}

	public function play():Void
	{
		action(params);
	}
}