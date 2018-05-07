const recoridos = {
  ciudad1: ["ciudad2", "ciudad4"],
  ciudad2: ["ciudad3", "ciudad5", "ciudad1"],
  ciudad3: [],
  ciudad4: ["ciudad6", "ciudad5"],
  ciudad5: ["ciudad6"],
  ciudad6: []
};

function conexion(A, B) {
  console.log('Buscar conexion %s con %s', A, B);
  let rta = recoridos[A].find(destino => {
    return (B !== destino) ? true : conexion(destino, B);
  });
  return rta ? true : false;
}

console.log(conexion("ciudad4", "ciudad1") || "No exite conexion");
console.log(conexion("ciudad5", "ciudad2") || "No exite conexion");

console.log(conexion("ciudad1", "ciudad1") && "Exite conexion");
console.log(conexion("ciudad1", "ciudad2") && "Exite conexion");
console.log(conexion("ciudad1", "ciudad3") && "Exite conexion");
console.log(conexion("ciudad1", "ciudad4") && "Exite conexion");
console.log(conexion("ciudad1", "ciudad5") && "Exite conexion");
console.log(conexion("ciudad1", "ciudad6") && "Exite conexion");
console.log(conexion("ciudad2", "ciudad1") && "Exite conexion");
console.log(conexion("ciudad2", "ciudad5") && "Exite conexion");
console.log(conexion("ciudad3", "ciudad2") || "No exite conexion");
console.log(conexion("ciudad3", "ciudad6") || "No exite conexion");
console.log(conexion("ciudad6", "ciudad1") || "No exite conexion");
