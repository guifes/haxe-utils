package guifes.flixel.extension;

import flixel.animation.FlxAnimationController;
import flixel.graphics.frames.FlxAtlasFrames;
import haxe.Exception;
import haxe.ds.StringMap;
import haxe.io.Path;
import json2object.JsonParser;
import lime.utils.Assets;

class Animation
{
	public var frames: Array<String>;
	public var looped: Bool;
	public var flipX: Bool;
	public var flipY: Bool;
	public var frameRate: Int;
}

class AnimationData
{
	public var animations: Map<String, Animation>;
}

class FlxAnimationControllerExtension
{
	static public function loadFromFlixelAnimationEditorJson(self: FlxAnimationController, Description: String): Void
	{
		if(!Assets.exists(Description))
			return;

		var json = Assets.getText(Description);

		var parser = new JsonParser<AnimationData>();
		parser.fromJson(json);
		
		var data: AnimationData = parser.value;

		var dir = Path.directory(Description);

		try
		{
			for(key in data.animations.keys())
			{
				var animation = data.animations.get(key);
				self.addByNames(key, animation.frames, animation.frameRate, animation.looped, animation.flipX, animation.flipY);
			}
		}
		catch (e:Exception)
		{
			throw new Exception('Invalid or corrupted animatio file: $Description. Message: ${e.message}');
		}
	}
}
