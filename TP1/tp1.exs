destinos = [
  {:ciudad1, "ciudad2"},
  {:ciudad1, "ciudad4"},
  {:ciudad2, "ciudad3"},
  {:ciudad4, "ciudad6"},
  {:ciudad4, "ciudad5"},
  {:ciudad5, "ciudad6"},
  {:ciudad2, "ciudad5"},
  {:ciudad2, "ciudad1"}
]

defmodule Main do
  # def conexion(destinos, {a, b}) do
  #  IO.puts("#{a} -> #{b}")
  #  %{^a => ciudad_destino} = %{a => destinos[a]}
  #  IO.puts(ciudad_destino == b)
  # end

  def find_destinos(recorridos, origen) do
    Enum.find(recorridos, fn ciudades ->
      {^origen, destinos} = ciudades
    end)
  end

  def find(destinos, viaje) do
    Enum.find(destinos, fn ciudades ->
      viaje == ciudades
    end)
  end

  def conexion(destinos, viaje) do
    destinos = find_destinos(destinos, origen)
    IO.inspect(destinos)
    viaje_posible = find(destinos, viaje)
    viaje_posible
  end
end

IO.inspect(
  destinos
  |> Main.conexion({:ciudad1, "ciudad4"})
)

IO.inspect(
  destinos
  |> Main.conexion({:ciudad1, "ciudad5"})
)
