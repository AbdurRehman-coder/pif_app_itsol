class FilterUtils {
  static String filterBy({required String key, required String value, required String operator}) {
    return '$key $operator $value';
  }
}

enum FilterOperator {
  equal('eq'),
  notEqual('ne'),
  greaterThan('gt'),
  greaterOrEqual('ge'),
  lessThan('lt'),
  lessOrEqual('le'),
  startsWith('startsWith');

  const FilterOperator(this.value);

  final String value;
}
