double calcularvalores(double _capital, int _plazo, int _interes) {
  double interesmensual = (_interes / 12) / 100;
  print(interesmensual);
  print(_capital / _plazo);
  print((_capital / _plazo) * interesmensual);
  return (_capital / _plazo) + (_capital * interesmensual);
}
