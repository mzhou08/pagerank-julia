module IOModule

using DelimitedFiles

include("GraphModule.jl")
using .GraphModule

export read_edge_list

function read_edge_list(filepath::String)
  file = open(filepath)
  num_vertices, num_edges = map(x -> convert(UInt32, x), readdlm(IOBuffer(readline(file))))
  vertices = Array{Vertex}(undef, num_vertices)
  for i in 1:num_vertices
    vertices[i] = Vertex(i, Array{UInt32}(undef, 0), Array{UInt32}(undef, 0));
  end
  for _ in 1:num_edges
    index_from, index_to = map(x -> convert(UInt32, x), readdlm(IOBuffer(readline(file))))
    push!(vertices[index_from].out_neighbors, index_to)
    push!(vertices[index_to].in_neighbors, index_from)
  end
  close(file)
  vertices
end

end
