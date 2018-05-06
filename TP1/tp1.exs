recorridos = %{
  ciudad1: [:ciudad2, :ciudad4],
  # ciudad2 => ["ciudad3", "ciudad5", "ciudad1"],
  ciudad2: [:ciudad3, :ciudad5],
  ciudad3: [],
  ciudad4: [:ciudad6, :ciudad5],
  ciudad5: [:ciudad6],
  ciudad6: []
}

defmodule Main do
  def buscar(recorridos, {origen, destino}) do
    destinos = recorridos[origen]
    destinos && Enum.find(destinos, fn destino2 -> destino2 === destino end)
  end

  def conexion(recorridos, {origen, destino}) when origen == destino do
    "Con conexion"
  end

  def conexion(recorridos, {nil, destino}) do
    "Sin conexion"
  end

  def conexion(recorridos, {origen, destino}) when origen != destino do
    conexion(recorridos, {buscar(recorridos, {origen, destino}), destino})
  end
end

IO.puts(recorridos |> Main.conexion({:ciudad1, :ciudad2}))

# IO.puts(recorridos |> Main.conexion({"ciudad4", "ciudad1"}))
# IO.puts(recorridos |> Main.conexion({"ciudad5", "ciudad2"}))

IO.puts(recorridos |> Main.conexion({:ciudad1, :ciudad1}))
IO.puts(recorridos |> Main.conexion({:ciudad1, :ciudad2}))
IO.puts(recorridos |> Main.conexion({:ciudad1, :ciudad3}))
IO.puts(recorridos |> Main.conexion({:ciudad1, :ciudad4}))
IO.puts(recorridos |> Main.conexion({:ciudad1, :ciudad5}))
IO.puts(recorridos |> Main.conexion({:ciudad1, :ciudad6}))
IO.puts(recorridos |> Main.conexion({:ciudad2, :ciudad1}))
IO.puts(recorridos |> Main.conexion({:ciudad2, :ciudad5}))
IO.puts(recorridos |> Main.conexion({:ciudad3, :ciudad2}))
IO.puts(recorridos |> Main.conexion({:ciudad3, :ciudad6}))
IO.puts(recorridos |> Main.conexion({:ciudad6, :ciudad1}))
