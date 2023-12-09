module Algos

  include("../moelia_problems/mptypes.jl")
  include("../moelia_algorithms/matypes.jl")
  include("../moelia_pipeline/mtypes.jl")
  include("../functions/populators/Populators.jl")
  include("../functions/crossovers/Crossovers.jl")

  function nr_nsga2(problem::MoeliaProblemTypes.MPT, pop_size::Int64)::MoeliaAlgoTypes.MAT
    # TODO completare
    apipeline = MoeliaTypes.MPipe(Vector{Tuple{String, Function, Any}}[
      ("crossover", Crossovers.single_point, 0.4, pop_size, problem.nvar),
      ("mutation", action, params),
      ("local search", action, params),
      ("evaluation", action, params),
      ("selection", action, params)
    ], Vector{MoeliaTypes.MData}[], Vector{MoeliaTypes.MData}[])

    return MoeliaAlgoTypes.MAT(
      Populators.random_initializer(problem, pop_size),
      (problem, pop_size),
      apipeline,
      problem,
      pop_size
    )
  end

  MoeliaImplementations = Dict{String, Function}([
    ("naive_random_nsga2", nr_nsga2) 
  ])

end