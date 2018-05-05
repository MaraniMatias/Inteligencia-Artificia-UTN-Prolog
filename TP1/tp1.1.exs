recorridos = [
  {"ciudad1", ["ciudad2", "ciudad4"]},
  {"ciudad2", ["ciudad3", "ciudad5", "ciudad1"]},
  {"ciudad2", ["ciudad3", "ciudad5"]},
  {"ciudad3", []},
  {"ciudad4", ["ciudad6", "ciudad5"]},
  {"ciudad5", ["ciudad6"]},
  {"ciudad5", []}
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
    {ciudad_origen, destinos} = buscar_origen(recorridos, destino)

    if ciudad_origen == origen do
      "Exite conexion"
    else
      conexion(recorridos, {origen, ciudad_origen})
    end
  end
end

IO.puts(recorridos |> Main.conexion({"ciudad4", "ciudad1"}))
IO.puts(recorridos |> Main.conexion({"ciudad5", "ciudad2"}))

IO.puts(recorridos |> Main.conexion({"ciudad1", "ciudad1"}))
IO.puts(recorridos |> Main.conexion({"ciudad1", "ciudad2"}))
IO.puts(recorridos |> Main.conexion({"ciudad1", "ciudad3"}))
IO.puts(recorridos |> Main.conexion({"ciudad1", "ciudad4"}))
IO.puts(recorridos |> Main.conexion({"ciudad1", "ciudad5"}))
IO.puts(recorridos |> Main.conexion({"ciudad1", "ciudad6"}))
IO.puts(recorridos |> Main.conexion({"ciudad2", "ciudad1"}))
IO.puts(recorridos |> Main.conexion({"ciudad2", "ciudad5"}))
IO.puts(recorridos |> Main.conexion({"ciudad3", "ciudad2"}))
IO.puts(recorridos |> Main.conexion({"ciudad3", "ciudad6"}))
IO.puts(recorridos |> Main.conexion({"ciudad6", "ciudad1"}))
