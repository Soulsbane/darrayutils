module darrayutils.array;

/**
	Various functions for working with arrays.

	Authors:
		Paul Crane
*/
import std.algorithm : countUntil;
import std.array : insertInPlace;

/**
	Removes the specified element from the array in place.

	Params:
		array = The array to remove value from.
		value = The value to remove.
*/
void remove(T)(ref T[] array, T value)
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
	import fluent.asserts;

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
	Inserts a value into an array after a given value in place.

	Params:
		array = The array to insert value into.
		insertAfterValue = The value to insert after.
		valueToInsert = The value to insert.
*/
void insertValueAfter(T)(ref T[] array, T insertAfterValue, T valueToInsert)
{
	size_t index = array.countUntil(insertAfterValue);

	if(index >= 0)
	{
		array.insertInPlace(++index, valueToInsert);
	}
}

unittest
{
	import fluent.asserts;

	int[] test1 = [1, 2, 3, 4, 5, 6, 7];
	string[] test2 = ["one", "two", "three"];
	double[] test3 = [1.1, 2.2, 3.3];

	test1.insertValueAfter(5, 88);
	test1.should.equal([1, 2, 3, 4, 5, 88, 6, 7]);

	test2.insertValueAfter("two", "fifteen");
	test2.should.equal(["one", "two", "fifteen", "three"]);

	test3.insertValueAfter(3.3, 8.8);
	test3.should.equal([1.1, 2.2, 3.3, 8.8]);
}

/**
	Inserts a value into an array before a given value in place.

	Params:
		array = The array to insert value into.
		insertAfterValue = The value to insert after.
		valueToInsert = The value to insert.
*/
void insertValueBefore(T)(ref T[] array, T insertAfterValue, T valueToInsert)
{
	immutable size_t index = array.countUntil(insertAfterValue);

	if(index >= 0)
	{
		array.insertInPlace(index, valueToInsert);
	}
}

unittest
{
	import fluent.asserts;

	int[] test1 = [1, 2, 3, 4, 5, 6, 7];
	string[] test2 = ["one", "two", "three"];
	double[] test3 = [1.1, 2.2, 3.3];

	test1.insertValueBefore(5, 88);
	test1.should.equal([1, 2, 3, 4, 88, 5, 6, 7]);

	test2.insertValueBefore("two", "fifteen");
	test2.should.equal(["one", "fifteen", "two", "three"]);

	test3.insertValueBefore(3.3, 8.8);
	test3.should.equal([1.1, 2.2, 8.8, 3.3]);
}
