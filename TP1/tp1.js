const recoridos = {
  ciudad1: ["ciudad2", "ciudad4"],
  ciudad2: ["ciudad3", "ciudad5", "ciudad1"],
  ciudad3: [],
  ciudad4: ["ciudad5", "ciudad6"],
  ciudad5: ["ciudad6"],
  ciudad6: []
};

function conexion(A, B, A_original) {
  debugger;
  // console.log('Buscar conexion %s con %s', A, B);
  if (A === B) return true;
  let exite_conexion = false;
  recoridos[A].forEach(destino => {
    if (destino === B) exite_conexion = true;
    if (!exite_conexion) {
      exite_conexion = A === A_original || conexion(destino, B, A_original || A);
    }
  });
  return exite_conexion;
}
console.log('1', conexion("ciudad1", "ciudad1") && "Exite conexion");
console.log('2', conexion("ciudad1", "ciudad2") && "Exite conexion");
console.log('3', conexion("ciudad1", "ciudad3") && "Exite conexion");
console.log('4', conexion("ciudad1", "ciudad4") && "Exite conexion");
console.log('5', conexion("ciudad1", "ciudad5") && "Exite conexion");
console.log('6', conexion("ciudad1", "ciudad6") && "Exite conexion");
console.log('7', conexion("ciudad2", "ciudad1") && "Exite conexion");
console.log('8', conexion("ciudad2", "ciudad4") && "Exite conexion");
console.log('9', conexion("ciudad2", "ciudad5") && "Exite conexion");
console.log('10', conexion("ciudad2", "ciudad6") && "Exite conexion");
console.log('11', conexion("ciudad3", "ciudad2") || "No exite conexion");
console.log('12', conexion("ciudad3", "ciudad6") || "No exite conexion");
console.log('13', conexion("ciudad4", "ciudad1") || "No exite conexion");
console.log('14', conexion("ciudad5", "ciudad2") || "No exite conexion");
console.log('15', conexion("ciudad6", "ciudad1") || "No exite conexion");
