extension StringExtensions on String {
  String get toCamelCase {
    final split = this.split('_');
    final first = split.first;
    final rest = split.sublist(1);
    final camelCase = [
      first,
      ...rest.map(
        (e) => e[0].toUpperCase() + e.substring(1),
      ),
    ];
    return camelCase.join();
  }
}
