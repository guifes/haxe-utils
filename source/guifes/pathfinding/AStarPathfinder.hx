package guifes.pathfinding;

#if hl
import temp.Prioritizable;
import temp.PriorityQueue;
#else
import polygonal.ds.Prioritizable;
import polygonal.ds.PriorityQueue;
#end
import guifes.collection.HashSet;
import guifes.collection.IHashable;

private class AStarNode<State, Transition> implements Prioritizable
{
	public var parent(default, null): AStarNode<State, Transition>;
	public var state(default, null): State;
	public var transition(default, null): Transition;
	public var g(default, null): Float; // cost
	public var f(default, null): Float; // cost + heuristic
	public var h(default, null): Float; // heuristic
	
	public function new (parent: AStarNode<State, Transition>, cost: Float, h: Float, state: State, transition: Transition)
	{
		this.parent = parent;
		this.g = (parent != null) ? parent.g + cost : 0;
		this.f = this.g + h;
		this.h = h;
		this.state = state;
		this.transition = transition;
		this.priority = this.f;
	}
	
	public function toString(): String
	{
		return "Node {f: " + f + ", g: " + g + ", state: " + state + " transition: " + transition + "}";
	}

	// Prioritizable
	public var priority(default, null): Float;
	public var position(default, null): Int;
}

private class AStarMovementNode<State, Transition> implements Prioritizable
{
	public var state(default, null): State;
	public var steps(default, null): Int;
	
	public function new(steps: Int, state: State)
	{
		this.steps = steps;
		this.state = state;
		this.priority = steps;
	}
	
	public function toString(): String
	{
		return "Node {steps: " + steps + ", state: " + state + "}";
	}

	// Prioritizable
	public var priority(default, null): Float;
	public var position(default, null): Int;
}

class AStarPathfinder<State: (IComparable<State> & IHashable), Transition>
{
	// A* Pathfinding Algorithm implementation

	private var map: IPathfinderDataSource<State, Transition>;

	public function new(_map: IPathfinderDataSource<State, Transition>)
	{
		map = _map;
	}

	public function getShortestPath(fromState: State, toState: State, collision: Bool = false, debug: Bool = false): Array<Transition>
	{
		var bestNode: AStarNode<State, Transition> = null;
		var openList: PriorityQueue<AStarNode<State, Transition>> = new PriorityQueue<AStarNode<State, Transition>>(true);
		var openListDictionary: Map<State, AStarNode<State, Transition>> = new Map<State, AStarNode<State, Transition>>();
		var closedSet: HashSet<State> = new HashSet<State>();

		var startNode: AStarNode<State, Transition> = createSearchNode(null, null, fromState, toState); // Create node for origin

		openList.enqueue(startNode);
		openListDictionary.set(fromState, startNode); // Insert the node in the open list

		while(!openList.isEmpty())
		{
			var node: AStarNode<State, Transition> = openList.dequeue(); // Get lowest score node from open list
			openListDictionary.remove(node.state);

			if(debug) trace("Dequeueing " + node.state);

			if(bestNode == null || bestNode.h > node.h)
			{
				bestNode = node;
			}

			if (node.state.equals(toState)) // If this node is the final one, build and return solution
			{
				return buildSolution(node);
			}

			closedSet.add(node.state); // Add this node to the closed set

			for (transition in map.expand(node.state)) // For every node reachable from this node (transitions)
			{
				var child: State = map.applyTransition(node.state, transition); // Get following state
				var isNodeInFrontier: Bool = openListDictionary.exists(child); // Gets node for state if it was already in the open list

				if(debug) trace("Evaluating " + child + " -> " + isNodeInFrontier + ", " + !closedSet.exists(child));

				if (!closedSet.exists(child) && !isNodeInFrontier) // If following state isn't in the closed list and is not in the open list too
				{
					var searchNode: AStarNode<State, Transition> = createSearchNode(node, transition, child, toState);

					openList.enqueue(searchNode);
					openListDictionary.set(searchNode.state, searchNode);

					if(debug) trace("Enqueueing new node " + openList);
					if(debug) trace("Enqueueing new node " + searchNode.state);
				}
				else if(isNodeInFrontier) // Replaces node score if it's lower
				{
					var openListNode: AStarNode<State, Transition> = openListDictionary.get(child);
					var searchNode: AStarNode<State, Transition> = createSearchNode(node, transition, child, toState);

					if (openListNode.f > searchNode.f)
					{
						openList.reprioritize(openListNode, searchNode.f);

						if(debug) trace("Reprioritizing existing node " + openList);
						if(debug) trace("Reprioritizing existing node " + openListNode);
					}
				}
			}
		}

		if(collision)
		{
			return buildSolution(bestNode);
		}

		return null;
	}

	public function getMovementRange(fromState: State, movementRange: Int, debug: Bool = false): HashSet<State>
	{
		var openList: PriorityQueue<AStarMovementNode<State, Transition>> = new PriorityQueue<AStarMovementNode<State, Transition>>();
		var openListDictionary: Map<State, AStarMovementNode<State, Transition>> = new Map<State, AStarMovementNode<State, Transition>>();
		var closedSet: HashSet<State> = new HashSet<State>();
		
		var startNode: AStarMovementNode<State, Transition> = new AStarMovementNode<State, Transition>(map.stepsForState(fromState, movementRange), fromState);
		
		openList.enqueue(startNode);
		openListDictionary.set(fromState, startNode); // Insert the node in the open list
		
		while(!openList.isEmpty())
		{
			var node: AStarMovementNode<State, Transition> = openList.dequeue();
			openListDictionary.remove(node.state);
			
			if(debug) trace("Dequeuing state: " + node.state + " with steps: " + node.steps);
			
			closedSet.add(node.state); // Add this node to the closed set
			
			for (transition in map.expandMovement(node.state, node.steps)) // For every node reachable from this node (transitions)
			{
				var child: State = map.applyTransition(node.state, transition); // Get following state
				
				var isNodeInFrontier: Bool = openListDictionary.exists(child); // Gets node for state if it was already in the open list
				var searchNode: AStarMovementNode<State, Transition> = new AStarMovementNode<State, Transition>(map.stepsForState(child, node.steps) - 1, child);

				if (!closedSet.exists(child) && !isNodeInFrontier) // If following state isn't in the frontier
				{
					if(debug) trace("Inserting state: " + searchNode.state + " with steps: " + searchNode.steps);

					openList.enqueue(searchNode);
					openListDictionary.set(searchNode.state, searchNode);
				}
				else if(isNodeInFrontier)
				{
					var openListNode: AStarMovementNode<State, Transition> = openListDictionary.get(child);

					if(debug) trace("- Comparing new state: " + searchNode.state + " with steps: " + searchNode.steps + " with old state " + openListNode.state + " with steps: " + openListNode.steps);

					if (searchNode.steps > openListNode.steps)
					{
						if(debug) trace("Replacing state");

						openList.reprioritize(openListNode, searchNode.steps);
					}
				}
			}

			if(debug) trace("------");
		}

		return closedSet;
	}

	private function createSearchNode(parent: AStarNode<State, Transition>, transition: Transition, state: State, toState: State): AStarNode<State, Transition>
	{
		if(parent != null)
		{
			var cost: Float = map.pathCost(parent.state, transition);
			var h: Float = map.heuristic(state, toState);
			
			return new AStarNode<State, Transition>(parent, cost, h, state, transition);
		}
		else
		{
			var h:Float = map.heuristic(state, toState);
			
			return new AStarNode<State, Transition>(null, 0, h, state, transition);
		}
	}

	private function buildSolution(searchNode: AStarNode<State, Transition>): Array<Transition>
	{
		var list: Array<Transition> = new Array<Transition>();

		while(searchNode != null)
		{
			if (searchNode.transition != null)
			{
				list.push(searchNode.transition);
			}

			searchNode = searchNode.parent;
		}

		return list;
	}
}