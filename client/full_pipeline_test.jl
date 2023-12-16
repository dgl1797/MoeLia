include("../src/MoeLia.jl")
using .MoeLia

include("./algos/researcher_library.jl")

# Problem initialization
myproblem = MoeliaProblem.init_problem(2, 3)
MoeliaProblem.set_objectives!(myproblem, ResearcherLibrary.researcher_objective1, ResearcherLibrary.researcher_objective2)
MoeliaProblem.set_boundaries!(myproblem, (-4,4), (-4,4), (-4,4))
MoeliaProblem.set_niterations!(myproblem, 150)

# Pipeline construction
population = Functions.Populators.random_initializer(myproblem, 3)
mypipe = MoeliaPipeline.init_pipeline()
MoeliaPipeline.add_step!(mypipe, "crossover", Functions.Crossovers.single_point, 0.9)
MoeliaPipeline.add_step!(mypipe, "mutation", Functions.Mutators.one_position, 0.7, myproblem.bounds)
MoeliaPipeline.add_step!(mypipe, "concatenatePQ", (p) -> vcat(filter(x -> !isempty(x), [p,mypipe.inputs[1].data,mypipe.outputs[1].data])...))
MoeliaPipeline.add_step!(mypipe, "FNDS", Functions.Auxiliaries.fnds.fast_non_dominated_sort)
MoeliaPipeline.add_step!(mypipe, "frontier_filter", (p) -> Functions.Auxiliaries.fnds.frontier_filter(p,mypipe.outputs[3].data, size(population)[1]))
MoeliaPipeline.add_step!(
  mypipe, 
  "crowding_distance", 
  (p) -> Functions.Auxiliaries.fnds.crowding_distance(
    p[2], 
    myproblem.objective_functions, 
    size(population)[1]-(isempty(mypipe.outputs[5].data[1]) ? 0 : size(mypipe.outputs[5].data[1])[1])
  )
) 
MoeliaPipeline.add_step!(mypipe, "build_final_population", (p) -> 
  vcat(filter(x -> !isempty(x), [ p, mypipe.outputs[5].data[1] ])...)
)

# Pipeline execution and printing
MoeliaPipeline.run_pipeline(mypipe,population)
println("-- pop")
println(population)
println("-- cross")
println(mypipe.outputs[1].data)
println("-- mut")
println(mypipe.outputs[2].data)
println("-- conc")
println(mypipe.outputs[3].data)
println("-- fnds")
println(mypipe.outputs[4].data)
println("-- filt")
println(mypipe.outputs[5].data)
println("-- crowd")
println(mypipe.outputs[6].data)
println("--final_pop")
println(mypipe.outputs[7].data)
