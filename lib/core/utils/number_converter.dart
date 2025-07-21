String formatNumber({num? number}) {
  if(number == null){
    return '0';
  }
  else if (number < 1000) {
    return number.toString();
  } else if (number < 1000000) {
    double result = number / 1000;
    return result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1) + 'K';
  } else {
    double result = number / 1000000;
    return result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1) + 'M';
  }
}
