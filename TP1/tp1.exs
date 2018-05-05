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
  def listar_destinos(destinos) do
    for {ciudad_origen, ciudad_destino} <- destinos, ciudad_destino do
      IO.puts("Desde #{ciudad_origen} hasta #{ciudad_destino}")
    end
  end

  # def conexion(destinos, {a, b}) do
  #  IO.puts("#{a} -> #{b}")
  #  %{^a => ciudad_destino} = %{a => destinos[a]}
  #  IO.puts(ciudad_destino == b)
  # end

  def conexion(destinos, viaje) do
    Enum.find(destinos, fn ciudades ->
      viaje == ciudades
    end)
  end
end

# IO.puts(Main.listar_destinos(destinos))

IO.inspect(
  destinos
  |> Main.conexion({:ciudad1, "ciudad4"})
)

IO.inspect(
  destinos
  |> Main.conexion({:ciudad1, "ciudad5"})
)
