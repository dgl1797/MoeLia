include("../src/MoeLia.jl")
using .MoeLia

include("./algos/researcher_library.jl")

# 1. Inizializzare il problema
myproblem = MoeliaProblem.init_problem(2, 3)
MoeliaProblem.set_objectives!(myproblem, ResearcherLibrary.researcher_objective1, ResearcherLibrary.researcher_objective2)
MoeliaProblem.set_boundaries!(myproblem, (-4,4), (-4,4), (-4,4))
MoeliaProblem.set_niterations!(myproblem, 150)

population = Functions.Populators.random_initializer(myproblem, 2)
mypipe = MoeliaPipeline.init_pipeline()
MoeliaPipeline.add_step!(mypipe, "crossover", Functions.Crossovers.single_point, 0.9)
MoeliaPipeline.add_step!(mypipe, "mutation", Functions.Mutators.one_position, 0.99, myproblem.bounds)
MoeliaPipeline.add_step!(mypipe, "concatenatePQ", (p, q) -> hcat(p, q))

MoeliaPipeline.run_pipeline(mypipe,population)


println(mypipe.outputs[2].data)
println(size(mypipe.outputs[2].data))


# 2. richiedere l'algoritmo a Implementations
#nsga_algorithm = Implementations.get_algorithm("naive_random_nsga2", myproblem)

# 3. eseguire il basic_runner di Moelia sull'algoritmo
#solved_population = MoeLia.Runners.basic_runner(nsga_algorithm)