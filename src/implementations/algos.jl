export Algos
module Algos

  using MoeLia

  function nr_nsga2(problem::MoeliaProblemTypes.MPT, pop_size::Int64)::MoeliaAlgoTypes.MAT
    # TODO completare
    apipeline = MoeliaTypes.MPipe(Vector{Tuple{String, Function, Any}}[
      ("crossover", Functions.Crossovers.single_point, 0.6),
      ("mutation", Functions.Mutators.one_position, 0.5, problem.bounds),
      ("concatenatePQ", (p) -> vcat(filter(x -> !isempty(x), [p,apipeline.inputs[1].data,apipeline.outputs[1].data])...)),
      ("fast_non_dominated_sort", Functions.Auxiliaries.fnds.fast_non_dominated_sort),
      ("filter_frontiers", (f) -> Functions.Auxiliaries.fnds.frontier_filter(f, apipeline.outputs[3].data, pop_size )),
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