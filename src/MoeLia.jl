module MoeLia

struct Solutions
  first_frontier::Array{AbstractFloat,1}
  second_frontier::Array{AbstractFloat,1}
  third_frontier::Array{AbstractFloat,1}
end # chiedere quali tipi di soluzioni possono esistere

struct Algorithm
  result::Solutions
end

end # module MoeLia
