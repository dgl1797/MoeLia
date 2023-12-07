export PopulationHandlers
module PopulationHandlers

  using Moelia 

  function random_initializer(pop_size::Int8)
    return zeros(pop_size)
  end
  
end