module MoeLia
  # Using/Imports

  # Exports
  export MoeliaPipeline
  export PopulationHandlers
  export Mutators

  # Include
  include("moelia_pipeline/MoeliaPipeline.jl")
  include("population_handlers/PopulationHandlers.jl")
  include("mutators/Mutators.jl")

end # module MoeLia