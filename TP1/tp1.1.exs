recorridos = %{
  ciudad1: [:ciudad2, :ciudad4],
  # ciudad2: [:ciudad3, :ciudad5, :ciudad1],
  ciudad2: [:ciudad3, :ciudad5],
  ciudad3: [],
  ciudad4: [:ciudad6, :ciudad5],
  ciudad5: [:ciudad6],
  ciudad6: []
}

defmodule Main do
  defp conexion(_, {origen, destino}) when origen == destino do
    true
  end

  defp conexion(recorridos, {origen, destino}) when origen != destino do
    exite_conexion = false

    for ciudad <- recorridos[origen] do
      if !exite_conexion do
        exite_conexion = conexion(recorridos, {ciudad, destino})
      end

      exite_conexion
    end

    IO.puts("conec #{exite_conexion}")

    exite_conexion
  end

  def conexion_string(recorridos, {origen, destino}) do
    IO.puts("Conxion entre #{origen} y #{destino}")
    conexion(recorridos, {origen, destino})
  end
end

IO.puts("1 #{recorridos |> Main.conexion_string({:ciudad3, :ciudad1})}")

IO.puts("2 #{recorridos |> Main.conexion_string({:ciudad1, :ciudad6})}")
IO.puts("3 #{recorridos |> Main.conexion_string({:ciudad1, :ciudad1})}")
IO.puts("4 #{recorridos |> Main.conexion_string({:ciudad1, :ciudad2})}")
IO.puts("5 #{recorridos |> Main.conexion_string({:ciudad1, :ciudad3})}")
IO.puts("6 #{recorridos |> Main.conexion_string({:ciudad1, :ciudad4})}")
IO.puts("7 #{recorridos |> Main.conexion_string({:ciudad1, :ciudad5})}")
IO.puts("8 #{recorridos |> Main.conexion_string({:ciudad2, :ciudad1})}")
IO.puts("9 #{recorridos |> Main.conexion_string({:ciudad2, :ciudad5})}")
IO.puts("10 #{recorridos |> Main.conexion_string({:ciudad3, :ciudad2})}")
IO.puts("11 #{recorridos |> Main.conexion_string({:ciudad3, :ciudad6})}")
IO.puts("12 #{recorridos |> Main.conexion_string({:ciudad4, :ciudad1})}")
IO.puts("13 #{recorridos |> Main.conexion_string({:ciudad5, :ciudad2})}")
IO.puts("14 #{recorridos |> Main.conexion_string({:ciudad6, :ciudad1})}")
