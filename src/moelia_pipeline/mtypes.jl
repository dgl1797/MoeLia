export MoeliaTypes
module MoeliaTypes
    #= 
      IF we need to sort names, Dictionary is better IDEA: array with sorted names, 
      so we access dictionary in order of sorted names array.
    =#
    struct MData{T}
      data::T
    end

    struct Iteration
      inputs::Vector{MData}
      outputs::Vector{MData}
    end

    struct MPipe
      mpipe::Vector{Tuple{String, Function, Any}}
      iter::Vector{Iteration}
    end
    
end