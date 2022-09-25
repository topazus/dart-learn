import 'dart:math';

late String description;

void variables() {
  var gem = 'ruby';
  print(gem);
  // with type annotation
  String name = 'smith';
  Object str = "a string";
  var count = 0;
  int a;
  // Uninitialized variables that have a nullable type have an initial value of null
  int? b;
  assert(b == null);
  description = "hello, dart";
  // final set only once
  final dog = 'harry';
  final barValue = 1e6.toInt();
  print(barValue);
  // Returns the integer closest to this number.
  // Rounds away from zero when there is no closest integer
  assert(1.5.round() == 1);
  assert(-1.5.round() == -1);
  assert(1.7.round() == 2);
  assert(1.1.round() == 1);
  // const is a compile-time constant.
  // If the const variable is at the class level, mark it 'static const'.
  const bar = 1e6;
  const atm = bar * 1.01325;
  print(atm);
  const Object i = 1;
  const ls = [i as int];
  const map = {i: 'int'};
  const set = {...ls};
  print(map);
  print(set);
  num x = 1;
  print(x + 1.1);
}

void typesConversion() {
  var one = int.parse('12');
  assert(one == 1);
  var onePointOne = double.parse('1.1');
  assert(onePointOne == 1.1);
  var oneAsString = 1.toString();
  assert(oneAsString == '1');
  var piAsString = 3.1415926.toStringAsFixed(4);
  print(piAsString);
}

Iterable<int> createIntList(int n, int max) sync* {
  // create random number
  var randomNum = Random().nextInt(max);
  if (n > 0) {
    yield randomNum;
    yield* createIntList(n - 1, max);
  }
}

double doubleInRange(double start, double end) {
  // in the range from 0.0, inclusive, to 1.0, exclusive.
  return Random().nextDouble() * (end - start) + start;
}

Iterable<num> createListWithSwitch(int n, num min, num max,
    {int accuracy = 0}) sync* {
  // create random number
  switch (max.runtimeType.toString()) {
    case 'int':
      var a = min.toInt();
      var b = max.toInt();
      var num = a + Random().nextInt(b - a);
      if (n > 0) {
        yield num;
        yield* createListWithSwitch(n - 1, min, max);
      }
      break;
    case 'double':
      var num = double.parse(
          doubleInRange(min.toDouble(), max.toDouble()).toStringAsFixed(4));
      if (n > 0) {
        yield num;
        yield* createListWithSwitch(n - 1, min, max, accuracy: accuracy);
      }
      break;
    default:
  }
}

Iterable<num> createListWithIf(int n, num min, num max,
    {int accuracy = 0}) sync* {
  // create random number
  if (min is int) {
    var a = min.toInt();
    var b = max.toInt();
    var num = a + Random().nextInt(b - a);
    if (n > 0) {
      yield num;
      yield* createListWithIf(n - 1, min, max);
    }
  } else if (min is double) {
    var num = double.parse(doubleInRange(min.toDouble(), max.toDouble())
        .toStringAsFixed(accuracy));
    if (n > 0) {
      yield num;
      yield* createListWithIf(n - 1, min, max, accuracy: accuracy);
    }
  }
}

void testList() {
  var nums1 = createListWithIf(10, 1, 20);
  print(nums1);
  var nums2 = createListWithIf(5, 1.0, 20.0, accuracy: 4);
  print(nums2);
  var nums3 = createListWithSwitch(10, 1, 20);
  print(nums3);
  var nums4 = createListWithSwitch(5, 1.0, 20.0, accuracy: 4);
  print(nums4);
}

void BitWiseOperators() {
  var a = 9;
  var b = 4;
  print("a = ${a.toRadixString(2)}, b = ${b.toRadixString(2)}");
  print("a << b = ${a << b}, ${(a << b).toRadixString(2)}");
  print("a | b = ${a | b}, ${(a | b).toRadixString(2)}");
  print("a & b = ${a & b}, ${(a & b).toRadixString(2)}");
  print("a >>> b = ${a >>> b}, ${(a >>> b).toRadixString(2)}");
  print("a ^ b = ${a ^ b} ${(a ^ b).toRadixString(2)}");
  print("~a = ${~a}, ${(~a).toRadixString(2)}");
}

void strings() {
  var a = 'hello world';
  var b = "hello world";
  assert(a == 'hello' ' world');
  assert(b == 'hello' + ' world');
  var c = '''
  apple
  banana''';
  var d = 'hello\nworld';
  print(d);
  var e = r'hello\nworld';
  print(e);
}
