package guifes;

enum SortOrder
{
    ASCENDING;
    DESCENDING;
}

class Sort
{
    static public function withAttribute<T, V>(accessor: T -> Float, order: SortOrder = ASCENDING)
    {
        return  (a: T, b: T) ->
        {
            var a_attribute = accessor(a);
            var b_attribute = accessor(b);

            if (a_attribute < b_attribute) return order == DESCENDING ? 1 : -1;
            else if (a_attribute > b_attribute) return order == DESCENDING ? -1 : 1;
            return 0;
        };
    }
}