package guifes.flixel.extension;

import flixel.graphics.frames.FlxAtlasFrames;
import haxe.Exception;
import haxe.Json;
import haxe.io.Path;
import lime.utils.Assets;
import openfl.display.BitmapData;
import sys.FileSystem;
import sys.io.File;

private typedef TexturePackerMeta = {
	image: String
}

private typedef TexturePackerInfo = {
	> TexturePackerObject,
	meta: TexturePackerMeta
};

class FlxAtlasFramesExtension
{
	static public function fromTexturePackerJsonAsset(cl: Class<FlxAtlasFrames>, Description: String): FlxAtlasFrames
	{
		if(!Assets.exists(Description))
			return null;

		var json = Assets.getText(Description);

		var data: TexturePackerInfo = Json.parse(json);

		var dir = Path.directory(Description);

		try
		{
			return FlxAtlasFrames.fromTexturePackerJson('${dir}/${data.meta.image}', Description);
		} catch (e:Exception)
		{
			return null;
		}
	}

	static public function fromTexturePackerJsonFile(cl: Class<FlxAtlasFrames>, path: String): FlxAtlasFrames
	{
		if(!FileSystem.exists(path))
			return null;

		var json = File.getContent(path);

		var data: TexturePackerInfo = Json.parse(json);

		if(data.meta == null)
			return null;

		try
		{
			var dir = Path.directory(path);
			var imgPath = '${dir}/${data.meta.image}';

			if(!FileSystem.exists(imgPath))
				return null;
	
			var imageData = File.getBytes(imgPath);
	
			var bitmapData = BitmapData.fromBytes(imageData);
	
			return FlxAtlasFrames.fromTexturePackerJson(bitmapData, json);
		}
		catch(e: Exception)
		{
			return null;
		}
	}
}
