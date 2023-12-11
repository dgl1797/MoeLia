using MoeLia.Implementations
using MoeLia.MoeliaPipeline
#using MoeLia.Runners
using MoeLia.Functions
using MoeLia.MoeliaProblem


include("./algos/researcher_library.jl")

# 1. Inizializzare il problema
myproblem = MoeliaProblem.init_problem(2, 3)
MoeliaProblem.set_objectives!(myproblem, ResearcherLibrary.researcher_objective1, ResearcherLibrary.researcher_objective2)
MoeliaProblem.set_boundaries!(myproblem, (-4,4), (-4,4), (-4,4))
MoeliaProblem.set_niterations!(myproblem, 150)

population = Functions.Populators.random_initializer(myproblem, 100)
mypipe = MoeliaPipeline.init_pipeline()
cp = add_step!(mypipe, "crossover", MoeLia.Functions.Crossovers.single_point(population, 0.5))
mp = add_step!(mypipe, "mutation", MoeLia.Functions.Mutators.one_position(cp, 0.5, myproblem.bounds)


# 2. richiedere l'algoritmo a Implementations
nsga_algorithm = MoeLia.Implementations.get_algorithm("naive_random_nsga2", myproblem)

# 3. eseguire il basic_runner di Moelia sull'algoritmo
#solved_population = MoeLia.Runners.basic_runner(nsga_algorithm)