module darrayutils.array;

/**
	Various functions for working with arrays.

	Authors:
		Paul Crane
*/
import std.algorithm : countUntil, filter;
import std.array : insertInPlace, array;

version(unittest)
{
	import fluent.asserts;
}

/**
	Removes the specified element from the array in place.

	Params:
		array = The array to remove value from.
		value = The value to remove.
*/
void remove(T)(ref T[] array, T value) nothrow pure @safe
{
	import std.algorithm : remove;
	immutable size_t index = array.countUntil(value);

	if(index >= 0)
	{
		array = remove(array, index);
	}
}

unittest
{
	int[] test1 = [1, 2, 3];
	string[] test2 = ["one", "two", "three"];
	double[] test3 = [1.1, 2.2, 3.3];

	test1.remove(2);
	test1.should.equal([1, 3]);

	test2.remove("two");
	test2.should.equal(["one", "three"]);

	test3.remove(2.2);
	test3.should.equal([1.1, 3.3]);
}

/**
	Removes all of the specified values from the array in place.

	Params:
		array = The array to remove values from.
		value = The values to remove.
*/
void removeAll(T)(ref T[] arr, T value) nothrow pure @safe
{
	arr = arr.filter!(a => a != value).array();
}

unittest
{
	int[] test1 = [1, 2, 3, 1, 2, 3, 1, 2, 3];
	string[] test2 = ["one", "one", "two", "three", "one", "five"];
	double[] test3 = [1.1, 2.2, 3.3, 1.1, 2.2, 3.3];

	test1.removeAll(2);
	test1.should.equal([1, 3, 1, 3, 1, 3]);

	test2.removeAll("one");
	test2.should.equal(["two", "three", "five"]);

	test3.removeAll(2.2);
	test3.should.equal([1.1, 3.3, 1.1, 3.3]);
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
	immutable size_t index = array.countUntil(insertAfterValue);

	if(index >= 0)
	{
		immutable size_t afterIndex = index + 1;
		array.insertInPlace(afterIndex, valueToInsert);
	}
}

unittest
{
	int[] test1 = [1, 2, 3, 4, 5, 6, 7];
	string[] test2 = ["one", "two", "three"];
	double[] test3 = [1.1, 2.2, 3.3];

	test1.insertAfter(5, 88);
	test1.should.equal([1, 2, 3, 4, 5, 88, 6, 7]);

	test2.insertAfter("two", "fifteen");
	test2.should.equal(["one", "two", "fifteen", "three"]);

	test2.insertAfter("three", "ego");
	test2.should.equal(["one", "two", "fifteen", "three", "ego"]);

	test3.insertAfter(3.3, 8.8);
	test3.should.equal([1.1, 2.2, 3.3, 8.8]);
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
	immutable size_t index = array.countUntil(insertAfterValue);

	if(index >= 0)
	{
		array.insertInPlace(index, valueToInsert);
	}
}

unittest
{
	int[] test1 = [1, 2, 3, 4, 5, 6, 7];
	string[] test2 = ["one", "two", "three"];
	double[] test3 = [1.1, 2.2, 3.3];

	test1.insertBefore(5, 88);
	test1.should.equal([1, 2, 3, 4, 88, 5, 6, 7]);

	test2.insertBefore("two", "fifteen");
	test2.should.equal(["one", "fifteen", "two", "three"]);

	test2.insertBefore("one", "eighty");
	test2.should.equal(["eighty", "one", "fifteen", "two", "three"]);

	test3.insertBefore(3.3, 8.8);
	test3.should.equal([1.1, 2.2, 8.8, 3.3]);
}
