package guifes.collection;

class CommandQueue
{
	private var commandQueue:List<Command>;

	public function new()
	{
		commandQueue = new List<Command>();
	}

	public function enqueue(command:Command):Void
	{
		commandQueue.add(command);

		if (commandQueue.length == 1)
		{
			command.play();
		}
	}

	public function dequeue():Void
	{
		if(!(commandQueue.length > 0))
		{
			throw new flash.errors.Error("Error: Trying to dequeue empty queue");
		}

		commandQueue.pop();

		if(commandQueue.length > 0)
		{
			commandQueue.first().play();
		}
	}

	public function toString():String
	{		
		return "";
	}
}