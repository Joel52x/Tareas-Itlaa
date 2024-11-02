String invertirCadena(String cadena) {
  return cadena.split('').reversed.join('');
}

void main() {
  print(invertirCadena("Hola"));
  print(invertirCadena("987654321"));
}
