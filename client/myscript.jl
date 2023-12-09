using MoeLia.MoeliaProblem
using MoeLia.Implementations
using MoeLia.Runners

include("./algos/researcher_library.jl")

# 1. Inizializzare il problema
myproblem = MoeliaProblem.init_problem(3, 10)
MoeliaProblem.set_objectives!(myproblem)
MoeliaProblem.set_boundaries!(myproblem)
MoeliaProblem.set_niterations!(myproblem, 150)

# 2. richiedere l'algoritmo a Implementations
nsga_algorithm = MoeLia.Implementations.init_nsga2(myproblem)

# 3. eseguire il basic_runner di Moelia sull'algoritmo
solved_population = MoeLia.Runners.basic_runner(nsga_algorithm)