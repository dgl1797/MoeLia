export MoeliaPipeline
module MoeliaPipeline
  #= TODO
    Module containing all the necessary structures to:
    initialize, configure and run a pipeline specific for genetic MOEA algorithms
  =#
  using MoeLia
  
  include("mtypes.jl")

  function init_pipeline()::MoeliaTypes.MPipe
    return MoeliaTypes.MPipe(Vector{Tuple{String, Function, Any}}[], Vector{MoeliaTypes.MData}[], Vector{MoeliaTypes.MData}[])
  end

  """
    pushes a new action to be performed in the pipeline. Actions are executed in the same order they are inserted
    and their output type needs to be coherent with the next step's input type\n
    \t@arg pipe::MoeliaTypes.MPipe -> the pipeline where to push the new action
    \t@arg name::String -> the name that identifies the action (?allow name-based sorting?)
    \t@arg action::Function -> the action to be taken
    \t@arg action_args::Tuple{Any...} -> configuration parameters for the action\n
      EXAMPLE OF USAGE:
    \t mypipe = MoeliaPipeline.init_pipeline()
    \t MoeliaPipeline.add_step!(mypipe, "step1", first_action, config_param1, config_param2, ...)\n
    notice that first_action is any functionality that takes a single input + some configuration parameters and returns a
    single output which is the elaborated input.\n
    \t@throws error if previous action's output is incompatible with new action's input
  """
  function add_step!(pipe::MoeliaTypes.MPipe, name::String, action::Function, action_args...)
    push!(pipe.mpipe, (name, action, action_args))
  end

  """
    runs a configured pipeline\n
    \t@arg pipeline::MoeliaTypes.MPipe -> the configured pipeline to run
    \t@arg startingInputs::MoeliaTypes.MInputs -> inputs that will be forwarded through the pipeline
    \t@returns the most fitting solutions until stop criteria are met
    \t@throws errors when steps output are incompatible with next inputs
    \t
  """
  function run_pipeline(pipe::MoeliaTypes.MPipe, x::Any)::Any
    for (_, action, args) in pipe.mpipe
      push!(pipe.inputs, MoeliaTypes.MData{typeof(x)}(x))
      x = action(x, args...)
      push!(pipe.outputs, MoeliaTypes.MData{typeof(x)}(x))
    end
    return x
  end
end