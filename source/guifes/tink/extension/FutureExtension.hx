package guifes.tink.extension;

using tink.CoreApi;

class FutureExtension
{
    static public function start<T>(f: Future<T>): CallbackLink
    {
        return f.handle(_ -> {});
    }

    static public function delay<T>(f: Future<T>, ms: Int): Future<T>
    {
        return f.flatMap(_ -> Future.delay(ms, _));
    }

    static public function then<T, U>(f: Future<T>, thenF: Future<U>): Future<U>
    {
        return f.flatMap(_ -> thenF);
    }

    static public function defer<T>(f: Future<T>, cb: T -> Void): Future<T>
    {
        return f.map(_ ->
        {
            cb(_);
            
            return _; 
        });
    }

    static public function value<T, U>(f: Future<T>, value: U): Future<U>
    {
        return f.map(_ -> value);
    }
}