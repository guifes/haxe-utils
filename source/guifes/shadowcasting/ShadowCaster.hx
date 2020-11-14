package guifes.shadowcasting;

import guifes.math.Vector2i;

private class ShadowLine
{
    private var shadows: Array<Shadow>;

    public function new()
    {
        shadows = new Array<Shadow>();
    }

    public function isFullShadow()
    {
        return shadows.length == 1 && shadows[0].start == 0 && shadows[0].end == 1;
    }

    public function isInShadow(projection: Shadow): Bool
    {
        for(shadow in shadows)
        {
            if(shadow.contains(projection))
            {
                return true;
            }
        }

        return false;
    }

    public function add(shadow:Shadow)
    {
        var index = 0;

        for(i in 0...shadows.length)
        {
            if(shadows[i].start >= shadow.start)
            {
                index = i;
                break;
            }
            else
            {
                index = i + 1;
            }
        }

        var overlappingPrevious = null;
        if(index > 0 && shadows[index - 1].end > shadow.start)
        {
            overlappingPrevious = shadows[index - 1];
        }

        var overlappingNext = null;
        if(index < shadows.length && shadows[index].start < shadow.end)
        {
            overlappingNext = shadows[index];
        }

        if(overlappingNext != null)
        {
            if(overlappingPrevious != null)
            {
                overlappingPrevious.end = overlappingNext.end;
                shadows.splice(index, 1);
            }
            else
            {
                overlappingNext.start = shadow.start;
            }
        }
        else
        {
            if(overlappingPrevious != null)
            {
                overlappingPrevious.end = shadow.end;
            }
            else
            {
                shadows.insert(index, shadow);
            }
        }
    }
}

private class Shadow
{
    public var start: Float;
    public var end: Float;

    public function new(start: Float, end: Float)
    {
        this.start = start;
        this.end = end;
    }

    public function contains(other: Shadow)
    {
        return start <= other.start && end >= other.end;
    }
}

class ShadowCaster
{
    private var map: IShadowCaster;

    public function new(_map: IShadowCaster)
	{
		map = _map;
	}

    private function projectTile(row: Int, col: Int):Shadow
    {
        var topLeft: Float = col / (row + 2);
        var bottomRight: Float = (col + 1) / (row + 1);
        
        return new Shadow(topLeft, bottomRight);
    }

    private function transformOctant(row: Int, col: Int, octant: Int): Vector2i
    {
        switch(octant)
        {
            case 0: return new Vector2i(col, -row);
            case 1: return new Vector2i(row, -col);
            case 2: return new Vector2i(row, col);
            case 3: return new Vector2i(col, row);
            case 4: return new Vector2i(-col, row);
            case 5: return new Vector2i(-row, col);
            case 6: return new Vector2i(-row, -col);
            case 7: return new Vector2i(-col, -row);
            default: return null;
        }
    }

    private function refreshOctant(from: Vector2i, octant: Int, radius)
    {
        var line = new ShadowLine();
        var fullShadow = false;

        var row = 0;
        while(true)
        {
            row++;
            
            var offset = transformOctant(row, 0, octant);
            var pos = Vector2i.add(from, offset);

            // Stop once we go out of bounds.
            if (!map.inBounds(pos))
                return;

            for (col in 0...(row + 1))
            {
                var offset = transformOctant(row, col, octant);
                var pos = Vector2i.add(from, offset);

                if(radius > 0)
                {
                    var p_radius = Vector2i.subtract(pos, from);
                    var mag = Math.floor(p_radius.magnitude);

                    if(mag > radius)
                    {
                        continue;
                    }
                }
                
                // If we've traversed out of bounds, bail on this row.
                if (!map.inBounds(pos))
                    break;

                var projection: Shadow = projectTile(row, col);

                // Set the visibility of this tile.
                var visible: Bool = !line.isInShadow(projection);

                if(visible)
                    map.reveal(pos);

                // Add any opaque tiles to the shadow map.
                if (visible && map.isBlocking(pos))
                {
                    line.add(projection);
                    
                    if(line.isFullShadow())
                    {
                        return;
                    }
                }
            }
        }
    }

    public function castShadows(from: Vector2i, radius: Int)
    {
        map.reveal(from);

        for(i in 0...8)
		{
			refreshOctant(from, i, radius);
		}
    }
}