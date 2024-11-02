int encontrarMayor(List<int> numeros) {
  int mayor = numeros[0];
  for (int numero in numeros) {
    if (numero > mayor) {
      mayor = numero;
    }
  }
  return mayor;
}

void main() {
  print(encontrarMayor([3, 7, 2, 9, 4]));
}
