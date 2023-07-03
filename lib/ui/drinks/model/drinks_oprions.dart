class DrinksOptions {
  DrinksOptions({
    required this.key,
    required this.required,
    required this.value,
  });

  String key;
  bool required;
  List<String> value;

   Map<String, Object> toJson() => {
        'key': key,
        'required': required,
        'value': value,
      };
}
