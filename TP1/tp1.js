// ciudad1 to ciduad2 = { ciudad2:'ciudad1' } 
// destino, orignes[]
const desde = {
  ciudad6: ["ciudad5","ciudad4"],
  ciudad5: ["ciudad2", "ciudad4"], // Pont d
  ciudad4: ["ciudad1"],
  ciudad3: ["ciudad2"],
  ciudad2: ["ciudad1"],
  ciudad1: []
}

const recoridos = {
  ciudad1: ["ciudad2", "ciudad4"],
  ciudad2: ["ciudad3", "ciudad5", "ciudad1"],
  ciudad4: ["ciudad6", "ciudad5"],
  ciudad5: ["ciudad6"]
};

/*function conexion(A, B) {
  return Object.keys(recoridos).find(ruta => {
      ruta.find(destino => destino === B);
    });
}*/

function conexion(A, B) {
  return desde[B].find(ciudad_origen => ciudad_origen === A ) && "Exite conexion";
}


console.log(conexion("ciudad1", "ciudad4"));
console.log(conexion("ciudad1", "ciudad2"));
console.log(conexion("ciudad1", "ciudad6")); // falla
console.log(conexion("ciudad2", "ciudad5"));

console.log(conexion("ciudad3", "ciudad6"));

