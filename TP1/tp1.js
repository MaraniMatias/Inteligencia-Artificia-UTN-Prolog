const recoridos = {
  ciudad1: ["ciudad2", "ciudad4"],
  // ciudad2: ["ciudad3", "ciudad5", "ciudad1"],
  ciudad2: ["ciudad3", "ciudad5"],
  ciudad4: ["ciudad6", "ciudad5"],
  ciudad5: ["ciudad6"]
};

function conexion(A, B) {
  console.log('Buscar conexion %s con %s', A, B);
  if (A == B) {
    return true;
  }
  if(typeof recoridos[A] === 'undefined'){
    return false;
  }

  // obtengo todos los destionos
  return recoridos[A].find(
    // busco un destino que tenga como desino B
    destino => conexion(destino, B)
  );
}

console.log(conexion("ciudad1", "ciudad6") && "Exite conexion"); // falla
console.log(conexion("ciudad1", "ciudad3") && "Exite conexion"); // falla

console.log(conexion("ciudad1", "ciudad1") && "Exite conexion");

console.log(conexion("ciudad1", "ciudad4") && "Exite conexion");
console.log(conexion("ciudad1", "ciudad2") && "Exite conexion");
console.log(conexion("ciudad2", "ciudad5") && "Exite conexion");

console.log(conexion("ciudad3", "ciudad6") || "No exite conexion");
