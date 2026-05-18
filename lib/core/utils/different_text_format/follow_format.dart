String followFormat(int count) {
  if (count >= 1000000) {
    double value = count / 1000000;
    return value % 1 == 0 ? '${value.toInt()}M' : '${value.toStringAsFixed(1)}M';
  } else if (count >= 1000) {
    double value = count / 1000;
    return value % 1 == 0 ? '${value.toInt()}K' : '${value.toStringAsFixed(1)}K';
  }
  return count.toString();
}