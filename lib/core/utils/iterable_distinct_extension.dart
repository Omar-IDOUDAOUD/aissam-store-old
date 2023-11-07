// ignore_for_file: curly_braces_in_flow_control_structures

extension IterableExtension<T> on Iterable<T> {
  Iterable<T> distinctBy(Object getCompareValue(T e)) {
    var result = <T>[];
    for (var element in this) {
      if (!result.any((x) => getCompareValue(x) == getCompareValue(element)))
        result.add(element);
    }
    return result;
  }
}
