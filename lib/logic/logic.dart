class SimpleEncoding {
  static const List<List<String>> qwerty = [
    ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
    ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
    ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';'],
    ['z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/']
  ];

  String process(String input1, String input2) {
    final transforms = input1.split(',');
    final inputs = input2.split('');
    String result = '';

    for (String input in inputs) {
      for (String transform in transforms) {
        input = _execute(transform, input);
      }
      result += input;
    }

    return result;
  }

  String _execute(String transform, String input) {
    String result = '';

    switch (transform) {
      case 'H':
        result = _horizontalFlip(input);
        break;
      case 'V':
        result = _verticalFlip(input);
        break;
      default:
        final check = int.tryParse(transform) != null;
        if (check) {
          result = _shift(input, int.parse(transform));
        } else {
          result = input;
        }
    }

    return result;
  }

  List<int> _findIndex(String input) {
    List<int> result = [];
    int indexKeyboard = 0;
    for (var element in qwerty) {
      final index = element.indexOf(input);
      if (index != -1) {
        result
          ..add(indexKeyboard)
          ..add(index);
        break;
      }
      indexKeyboard++;
    }

    return result;
  }

  String _horizontalFlip(String input) {
    final index = _findIndex(input);
    if (index.isEmpty) return input;

    final reverse = qwerty[index[0]].reversed;
    return reverse.elementAt(index[1]);
  }

  String _verticalFlip(String input) {
    final index = _findIndex(input);
    if (index.isEmpty) return input;

    final reverse = qwerty.reversed.toList();
    return reverse[index[0]].elementAt(index[1]);
  }

  String _shift(String input, int n) {
    final index = _findIndex(input);
    if (index.isEmpty) return input;

    int sum = index[1] + n;
    if (sum < 0) {
      index[0]--;
      int result1 = sum.abs() ~/ 10;
      index[0] -= result1;
      int result2 = sum.abs() % 10;

      if (index[0] < 0) index[0] = 3;

      return qwerty[index[0]].elementAt(10 - result2);
    } else if (sum > 9) {
      int result1 = sum.abs() ~/ 10;
      index[0] += result1;
      int result2 = sum.abs() % 10;

      if (index[0] > 3) index[0] = 0;

      return qwerty[index[0]].elementAt(result2);
    }
    return qwerty[index[0]].elementAt(index[1] + n);
  }
}
