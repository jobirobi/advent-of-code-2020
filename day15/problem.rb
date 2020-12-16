input = "1,20,8,12,0,14".split(/,/).map{ |n| n.to_i }
last_one = Hash.new

# store the starting-at-one index for each of the initial inputs
input.each.with_index { |n, i| last_one[n] = i + 1 }

# reduce the problem to just the last input its index
i = input.length
input = input[-1]

until i == 30000000

  # test whether this was the first time that input was said
  # if it was the first time, the next number will be 0
  # if it was not, the next number will be the difference between the current and previous indices
  # record the index in last_one
  next_one = last_one[input].nil? ? 0 : i - last_one[input]
  last_one[input] = i

  # update input and index
  input = next_one
  i += 1

  # problem 1
  if i == 2020
    puts input
  end
end

# problem 2
puts input
