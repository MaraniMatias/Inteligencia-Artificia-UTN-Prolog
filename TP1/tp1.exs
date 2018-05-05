destinos = [
  ciudad1: "ciudad2",
  ciudad1: "ciudad4",
  ciudad2: "ciudad3",
  ciudad4: "ciudad6",
  ciudad4: "ciudad5",
  ciudad5: "ciudad6",
  ciudad2: "ciudad5",
  ciudad2: "ciudad1"
]

{:ok, value} = {:ok, "Successful!"} # {:ok, "Successful!"}
IO.puts value # "Successful!"

for {ciudad_origen, ciudad_destino} <- destinos, ciudad_destino do
  IO.puts  "Desde #{ciudad_origen} hasta #{ciudad_destino}"
end

