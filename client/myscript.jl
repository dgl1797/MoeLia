include("../src/MoeLia.jl")
using .MoeLia

include("./algos/researcher_library.jl")

# 0. Definition of constant parameters
const POP_SIZE = 3

# 1. Inizializzare il problema
myproblem = MoeliaProblem.init_problem(2, 3)
MoeliaProblem.set_objectives!(myproblem, ResearcherLibrary.researcher_objective1, ResearcherLibrary.researcher_objective2)
MoeliaProblem.set_boundaries!(myproblem, (-4,4), (-4,4), (-4,4))
MoeliaProblem.set_niterations!(myproblem, 150)

# 2. richiedere l'algoritmo a Implementations
nsga_algorithm = Implementations.get_algorithm("naive_random_nsga2", myproblem, POP_SIZE)
MoeliaPipeline.inspect(nsga_algorithm.apipeline, Matrix{Float64})

# 3. eseguire il basic_runner di Moelia sull'algoritmo
#best_population = MoeLia.Runners.basic_runner(nsga_algorithm)