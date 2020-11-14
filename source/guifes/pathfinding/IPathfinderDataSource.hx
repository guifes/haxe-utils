package guifes.pathfinding;

interface IPathfinderDataSource<State, Transition>
{
	// Should return a estimate of shortest distance. The estimate must me admissible (never overestimate)
	function heuristic(fromLocation:State, toLocation:State) : Float;
	
	// Return the legal moves from a state
	function expand(position:State) : List<Transition>;

	// Return the legal moves from a state considering steps
	function expandMovement(state:State, steps:Int) : List<Transition>;
	
	// Return the cost between two adjecent locations for path purposes
	function pathCost(fromLocation:State, transition:Transition) : Float;

	// Returns the new state after an transition has been applied
	function applyTransition(location:State, transition:Transition):State;

	// Returns the new steps value after checking for terrain effect on state
	function stepsForState(state:State, steps:Int):Int;
}