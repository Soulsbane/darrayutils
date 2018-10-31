module darrayutils.array;
/**
	Various functions for working with arrays.

	Authors:
		Paul Crane
*/

/**
	Removes the specified element from the array in place.

	Params:
		array = The array to remove value from.
		value = The value to remove.
*/
void remove(T)(ref T[] array, T value) nothrow pure @safe
{
	import std.algorithm : remove, countUntil;
	immutable size_t index = array.countUntil(value);

	if(index >= 0)
	{
		array = remove(array, index);
	}
}

///
@("remove")
unittest
{
	int[] test1 = [1, 2, 3];
	string[] test2 = ["one", "two", "three"];
	double[] test3 = [1.1, 2.2, 3.3];

	test1.remove(2);
	assert(test1 == [1, 3]);

	test2.remove("two");
	assert(test2 == ["one", "three"]);

	test3.remove(2.2);
	assert(test3 == [1.1, 3.3]);
}

/**
	Removes all of the specified values from the array in place.

	Params:
		arr = The array to remove values from.
		value = The values to remove.
*/
void removeAll(T)(ref T[] arr, T value) nothrow pure @safe
{
	import std.algorithm : filter;
	import std.array : array;
	arr = arr.filter!(a => a != value).array();
}

///
@("removeAll")
unittest
{
	int[] test1 = [1, 2, 3, 1, 2, 3, 1, 2, 3];
	string[] test2 = ["one", "one", "two", "three", "one", "five"];
	double[] test3 = [1.1, 2.2, 3.3, 1.1, 2.2, 3.3];

	test1.removeAll(2);
	assert(test1 == [1, 3, 1, 3, 1, 3]);

	test2.removeAll("one");
	assert(test2 == ["two", "three", "five"]);

	test3.removeAll(2.2);
	assert(test3 == [1.1, 3.3, 1.1, 3.3]);
}

/**
	Inserts a value into an array after a given value in place.

	Params:
		array = The array to insert value into.
		insertAfterValue = The value to insert after.
		valueToInsert = The value to insert.
*/
void insertAfter(T)(ref T[] array, T insertAfterValue, T valueToInsert) nothrow pure @safe
{
	import std.algorithm : countUntil;
	immutable size_t index = array.countUntil(insertAfterValue);

	if(index >= 0)
	{
		import std.array : insertInPlace;
		immutable size_t afterIndex = index + 1;
		array.insertInPlace(afterIndex, valueToInsert);
	}
}

///
@("insertAfter")
unittest
{
	int[] test1 = [1, 2, 3, 4, 5, 6, 7];
	string[] test2 = ["one", "two", "three"];
	double[] test3 = [1.1, 2.2, 3.3];

	test1.insertAfter(5, 88);
	assert(test1 == [1, 2, 3, 4, 5, 88, 6, 7]);

	test2.insertAfter("two", "fifteen");
	assert(test2 == ["one", "two", "fifteen", "three"]);

	test2.insertAfter("three", "ego");
	assert(test2 == ["one", "two", "fifteen", "three", "ego"]);

	test3.insertAfter(3.3, 8.8);
	assert(test3 == [1.1, 2.2, 3.3, 8.8]);
}

/**
	Inserts a value into an array before a given value in place.

	Params:
		array = The array to insert value into.
		insertAfterValue = The value to insert after.
		valueToInsert = The value to insert.
*/
void insertBefore(T)(ref T[] array, T insertAfterValue, T valueToInsert) nothrow pure @safe
{
	import std.algorithm : countUntil;
	immutable size_t index = array.countUntil(insertAfterValue);

	if(index >= 0)
	{
		import std.array : insertInPlace;
		array.insertInPlace(index, valueToInsert);
	}
}

///
@("insertBefore")
unittest
{
	int[] test1 = [1, 2, 3, 4, 5, 6, 7];
	string[] test2 = ["one", "two", "three"];
	double[] test3 = [1.1, 2.2, 3.3];

	test1.insertBefore(5, 88);
	assert(test1 == [1, 2, 3, 4, 88, 5, 6, 7]);

	test2.insertBefore("two", "fifteen");
	assert(test2 == ["one", "fifteen", "two", "three"]);

	test2.insertBefore("one", "eighty");
	assert(test2 == ["eighty", "one", "fifteen", "two", "three"]);

	test3.insertBefore(3.3, 8.8);
	assert(test3 == [1.1, 2.2, 8.8, 3.3]);
}

/**
	Checks for a last value in an array and returns it or returns the default value.

	Params:
		values = The array to get value from.
		defaultValue = The default value if the array is empty.

	Returns:
		The last value in the array and returns it or returns the default value.
*/
T lastOrDefault(T)(T[] values, const T defaultValue = T.init)
{
	import std.range : empty, back;
	return values.empty ? defaultValue : values.back;
}

///
@("lastOrDefault")
unittest
{
	int[] test1 = [1, 2, 3, 4, 5, 6, 7];
	int[] emptyArr = [];

	assert(test1.lastOrDefault(0) == 7);
	assert(emptyArr.lastOrDefault(0) == 0);
	assert(emptyArr.lastOrDefault() == 0);
}

/**
	Checks for a first value in an array and returns it or returns the default value.

	Params:
		values = The array to get value from.
		defaultValue = The default value if the array is empty.

	Returns:
		The first value in the array and returns it or returns the default value.
*/
T firstOrDefault(T)(T[] values, const T defaultValue = T.init)
{
	import std.range : empty, front;
	return values.empty ? defaultValue : values.front;
}

///
@("firstOrDefault")
unittest
{
	int[] test1 = [1, 2, 3, 4, 5, 6, 7];
	int[] emptyArr = [];

	assert(test1.firstOrDefault(0) == 1);
	assert(emptyArr.firstOrDefault(0) == 0);
	assert(emptyArr.firstOrDefault() == 0);
}

/**
	Checks for a specified element's position in the array and returns its value or returns the default value.

	Params:
		values = The array to get value from.
		element = The position in the array to get.
		defaultValue = The default value if the array is empty.

	Returns:
		The specified element's position in the array and returns its value or returns the default value.
*/
T elementAtOrDefault(T)(T[] values, T element, const T defaultValue = T.init)
{
	return element < values.length ? values[element] : defaultValue;
}

///
@("elementAtOrDefault")
unittest
{
	int[] test1 = [1, 2, 3, 4, 5, 6, 7];
	int[] emptyArr = [];

	assert(test1.elementAtOrDefault(1, 0) == 2);
	assert(test1.elementAtOrDefault(0, 888) == 1);
	assert(test1.elementAtOrDefault(6, 0) == 7);
	assert(test1.elementAtOrDefault(7, 888) == 888);

	assert(emptyArr.firstOrDefault(777) == 777);
	assert(emptyArr.firstOrDefault(777) == 777);
}

/**
	Counts the number of unique elements in an array.

	Params:
		values = The array to count the number of uniques.

	Returns:
		The number of unique elements in an array.
*/
size_t countUnique(T)(T[] values)
{
	import std.algorithm : sort, uniq, count;
	return values.sort().uniq.count;
}

///
@("countUnique")
unittest
{
	auto result = [1, 3, 2, 2, 3];
	assert(result.countUnique() == 3);
}

