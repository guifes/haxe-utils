package source.guifes.macro;

import haxe.macro.Context;
import haxe.macro.Expr;
import sys.FileSystem;

using guifes.extension.ArrayExtension;
using StringTools;

class AssetPathsCatalog
{
    public static function buildFileReferences(directory:String = "assets/", subDirectories:Bool = false, ?filterExtensions:Array<String>,
        ?rename:String->String):Array<Field>
    {
        if (!directory.endsWith("/"))
            directory += "/";

        Context.registerModuleDependency(Context.getLocalModule(), directory);

        var fileReferences:Array<FileReference> = getFileReferences(directory, subDirectories, filterExtensions, rename);
        var fields:Array<Field> = Context.getBuildFields();

        for (fileRef in fileReferences)
        {
            // create new field based on file references!
            fields.push({
                name: fileRef.name,
                doc: fileRef.documentation,
                access: [Access.APublic, Access.AStatic, Access.AInline],
                kind: FieldType.FVar(macro:String, macro $v{fileRef.value}),
                pos: Context.currentPos()
            });
        }
        return fields;
    }
}