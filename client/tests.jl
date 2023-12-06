function myfunction(x1, x2)
  return x1+x2
end

Base.return_types(myfunction)[1] == Any