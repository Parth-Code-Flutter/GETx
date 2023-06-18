double returnGstCalcValue(
    {required double productPrice, required double gstValue}) {
  double finalGstValue = 0.0;

  // finalGstValue = (((productPrice * qty) * gstValue) / 100);
  finalGstValue = ((productPrice * gstValue) / 100);
  return finalGstValue;
}
