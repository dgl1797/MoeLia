export Mutators
module Mutators
  function classic_mutator(population::Vector{Float64})::Vector{Float64}
    final_array = zeros(Int64(floor(length(population)/2)))
    for i in 1:2:length(final_array)
      final_array[i] = (population[i] + population[i+1])/2
    end
    return final_array
  end
end