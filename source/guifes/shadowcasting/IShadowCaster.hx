package guifes.shadowcasting;

import guifes.math.Vector2i;

interface IShadowCaster
{
    function reveal(tile: Vector2i): Void;
    function inBounds(tile: Vector2i): Bool;
    function isBlocking(tile: Vector2i): Bool;
}