extension StringExtension on String {
  bool get isNil => this == null || this.isEmpty;
  bool get isNotNil => !this.isNil;
}
