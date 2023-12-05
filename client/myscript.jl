using MoeLia.MoeliaPipeline

include("algos/researcher_library.jl")

function step1_function(x::Array{Float64, 3}, param::Int8)
  println("Im step1, will execute $x+1+$param")
  return x .+ 1 .+ param
end

function step2_function(x::Array{Float64, 3}, param::Int64)
  println("Im step2, will execute $x*$param")
  return x .* param
end

mypipeline = MoeliaPipeline.init_pipeline()
MoeliaPipeline.add_step!(mypipeline, "step1", step1_function, Int8(8))
MoeliaPipeline.add_step!(mypipeline, "step2", step2_function, 12)

outputs = MoeliaPipeline.run_pipeline(mypipeline, zeros(5,5,5))
