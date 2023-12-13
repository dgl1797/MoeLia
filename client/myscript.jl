include("../src/MoeLia.jl")
using .MoeLia

include("./algos/researcher_library.jl")

# 1. Inizializzare il problema
myproblem = MoeliaProblem.init_problem(2, 3)
MoeliaProblem.set_objectives!(myproblem, ResearcherLibrary.researcher_objective1, ResearcherLibrary.researcher_objective2)
MoeliaProblem.set_boundaries!(myproblem, (-4,4), (-4,4), (-4,4))
MoeliaProblem.set_niterations!(myproblem, 150)

population = Functions.Populators.random_initializer(myproblem, 3)
mypipe = MoeliaPipeline.init_pipeline()
MoeliaPipeline.add_step!(mypipe, "crossover", Functions.Crossovers.single_point, 0.9)
MoeliaPipeline.add_step!(mypipe, "mutation", Functions.Mutators.one_position, 0.7, myproblem.bounds)
MoeliaPipeline.add_step!(mypipe, "concatenatePQ", (p) -> vcat(filter(x -> !isempty(x), [p,mypipe.inputs[1].data,mypipe.outputs[1].data])...))
MoeliaPipeline.add_step!(mypipe, "FNDS", Functions.Auxiliaries.fnds.fast_non_dominated_sort)
MoeliaPipeline.add_step!(mypipe, "frontier_filter", (p) -> Functions.Auxiliaries.fnds.frontier_filter(p,mypipe.outputs[3].data, 3))
MoeliaPipeline.add_step!(
  mypipe, 
  "crowding_distance", 
  (p) -> Functions.Auxiliaries.fnds.crowding_distance(
    p[2], 
    myproblem.objective_functions, 
    3-size(mypipe.outputs[5].data[1])[1]
  )
)


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


# 2. richiedere l'algoritmo a Implementations
#nsga_algorithm = Implementations.get_algorithm("naive_random_nsga2", myproblem)

# 3. eseguire il basic_runner di Moelia sull'algoritmo
#solved_population = MoeLia.Runners.basic_runner(nsga_algorithm)