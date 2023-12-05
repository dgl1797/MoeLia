module MoeliaTypes
    #= 
      IF we need to sort names, Dictionary is better IDEA: array with sorted names, 
      so we access dictionary in order of sorted names array.
    =#
    struct MData{Type}
      data::Type
    end

    struct MPipe
      mpipe::Vector{Tuple{String, Function, Any}}
      inputs::Vector{MData}
      outputs::Vector{MData}
    end
    
end