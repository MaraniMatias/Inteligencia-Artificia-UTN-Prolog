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
    # IO.puts("Buscar origen para #{origen} y #{destino}")
    destinos = recorridos[origen]
    ciudad = Enum.find(destinos, fn destino_nuevo -> destino_nuevo === destino end)

    if ciudad != nil do
      ciudad
    else
      Enum.find(destinos, fn destino_nuevo ->
        buscar(recorridos, {origen, destino_nuevo})
      end)
    end
  end

  def conexion(_, {origen, destino}) when origen == destino do
    "Con Conexion"
  end

  def conexion(_, {nil, _}) do
    "Sin Conexion"
  end

  def conexion(recorridos, {origen, destino}) when origen != destino do
    ciudad = buscar(recorridos, {origen, destino})
    conexion(recorridos, {ciudad, destino})
  end

  def conexion_string(recorridos, {origen, destino}) do
    IO.puts("Conxion entre #{origen} y #{destino}")
    conexion(recorridos, {origen, destino})
  end
end

IO.puts(recorridos |> Main.conexion_string({:ciudad1, :ciudad6}))

IO.puts(recorridos |> Main.conexion_string({:ciudad1, :ciudad1}))
IO.puts(recorridos |> Main.conexion_string({:ciudad1, :ciudad2}))
IO.puts(recorridos |> Main.conexion_string({:ciudad1, :ciudad3}))
IO.puts(recorridos |> Main.conexion_string({:ciudad1, :ciudad4}))
IO.puts(recorridos |> Main.conexion_string({:ciudad1, :ciudad5}))
IO.puts(recorridos |> Main.conexion_string({:ciudad2, :ciudad1}))
IO.puts(recorridos |> Main.conexion_string({:ciudad2, :ciudad5}))
IO.puts(recorridos |> Main.conexion_string({:ciudad3, :ciudad2}))
IO.puts(recorridos |> Main.conexion_string({:ciudad3, :ciudad6}))
IO.puts(recorridos |> Main.conexion_string({:ciudad4, :ciudad1}))
IO.puts(recorridos |> Main.conexion_string({:ciudad5, :ciudad2}))
IO.puts(recorridos |> Main.conexion_string({:ciudad6, :ciudad1}))
