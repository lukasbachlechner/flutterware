String limitToThreshold(
  num input, {
  int threshold = 100,
  String overflowCharacter = '+',
}) {
  if (input < threshold) {
    return input.toString();
  } else {
    return "${threshold - 1}$overflowCharacter";
  }
}
