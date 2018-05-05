recorridos = [
  {:ciudad1, ["ciudad2", "ciudad4"]},
  {:ciudad2, ["ciudad3", "ciudad5", "ciudad1"]},
  {:ciudad4, ["ciudad6", "ciudad5"]},
  {:ciudad5, ["ciudad6"]}
]

defmodule Main do
  def buscar_origen(recorridos, destino) do
    Enum.find(recorridos, fn ruta ->
      {ciudad_origen, destinos} = ruta
      Enum.find(destinos, fn ciudad -> destino == ciudad end)
    end)
  end

  def conexioan(recorridos, {origen, nil}) do
    "No exite conexion"
  end

  def conexion(recorridos, {origen, destino}) do
    IO.puts("Buscar para  #{origen}, #{destino}")
    rta = buscar_origen(recorridos, destino)

    if rta do
      {ciudad_origen, destinos} = rta

      if ciudad_origen == origen do
        "Exite conexion"
      else
        IO.puts("#{ciudad_origen}, #{origen}, #{destino}")
        conexion(recorridos, {origen, ciudad_origen})
      end
    end
  end
end

IO.inspect(
  recorridos
  |> Main.conexion({:ciudad1, "ciudad4"})
)

IO.inspect(
  recorridos
  |> Main.conexion({:ciudad1, "ciudad2"})
)

IO.inspect(
  recorridos
  |> Main.conexion({:ciudad1, "ciudad5"})
)
