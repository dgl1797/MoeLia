export Functions 
module Functions

  export Crossovers
  export Mutators
  export Populators
  export Selectors
  export Auxiliaries

  include("crossovers/Crossovers.jl")
  include("mutators/Mutators.jl")
  include("populators/Populators.jl")
  include("selectors/Selectors.jl")
  include("auxiliaries/Auxiliaries.jl")
end