extension BooleanExt on bool {
  int compareTo(bool compare) {
    if (!this && compare) return -1;
    if (this && !compare) return 1;
    return 0;
  }
}
