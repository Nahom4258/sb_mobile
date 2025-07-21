DateTime convertToGMT(DateTime localTime) {
  final timeOffset = localTime.timeZoneOffset;

  return localTime.subtract(timeOffset);
}

DateTime convertToLocal(DateTime gmtTime) {
  final now = DateTime.now();
  final timeOffset = now.timeZoneOffset;

  return gmtTime.add(timeOffset);
}