module MoeLia
  # Using/Imports
  using Pkg
  Pkg.add("Random")
  Pkg.add("Dates")
  # Export APIs
  export MoeliaPipeline
  export Functions
  export Implementations
  export Runners
  export MoeliaAlgorithm
  export MoeliaProblem
  export Algos

  # Export Types
  export MoeliaAlgoTypes
  export MoeliaProblemTypes
  export MoeliaTypes

  # Include Types
  include("moelia_pipeline/mtypes.jl")
  include("moelia_problems/mptypes.jl")
  

  # Include APIs
  include("functions/Functions.jl")
  include("implementations/Implementations.jl")
  include("runners/Runners.jl")
  include("moelia_pipeline/MoeliaPipeline.jl")
  include("moelia_algorithms/MoeliaAlgorithm.jl")
  include("moelia_problems/MoeliaProblem.jl")
  include("implementations/algos.jl")

end # module MoeLia
