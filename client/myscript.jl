include("../src/MoeLia.jl")
using .MoeLia

include("./algos/researcher_library.jl")

# 0. Definition of constant parameters
const POP_SIZE = 5
const MAX_IT = 150

# 1. Initialize Problem
myproblem = MoeliaProblem.init_problem(2, 3)
MoeliaProblem.set_objectives!(myproblem, ResearcherLibrary.researcher_objective1, ResearcherLibrary.researcher_objective2)
MoeliaProblem.set_boundaries!(myproblem, (-4,4), (-4,4), (-4,4))
MoeliaProblem.set_criteria!(myproblem, ResearcherLibrary.stop_criteria, false, true, MAX_IT)

# 2. Request algorithm
nsga_algorithm = Implementations.get_algorithm("naive_random_nsga2", myproblem, POP_SIZE)
println(MoeliaPipeline.inspect(nsga_algorithm.algorithm_pipeline, Matrix{Float64}))

# 3. Run Algorithm through basic runner
best_population = MoeLia.Runners.basic_runner(nsga_algorithm)

# 4. Modification of the Pipeline

# 5. Run Algorithm again through basic runner