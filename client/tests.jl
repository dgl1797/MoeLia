function testingFunction(args::Tuple{Vararg{Int64,6}})
  return args
end

testingFunction((1,2,3,4,5,6))