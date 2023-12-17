export MoeliaTypes
module MoeliaTypes

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