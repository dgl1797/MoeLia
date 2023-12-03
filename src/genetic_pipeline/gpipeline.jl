module GPipeline
  mutable struct GPipe
    # TODO -> declare a global abstract type MoeaFunction as Union{Function, Ptr{Nothing}}
    mutation_algorithm::Union{Function, Ptr{Nothing}}
    mutator_args::Any
    
    optimizer::Union{Function, Ptr{Nothing}}
    optimizer_args::Any
  end
end