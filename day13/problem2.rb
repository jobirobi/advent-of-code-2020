schedule = "1007153
29,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,433,x,x,x,x,x,x,x,x,x,x,x,x,13,17,x,x,x,x,19,x,x,x,23,x,x,x,x,x,x,x,977,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,41".split(/[,\n]/)[1..-1]

# convert schedule to a hash: k=bus frequency, v=desired offset from t
schedule = schedule.map.with_index{ |x, i| [x.to_i, i] }.to_h.select{ |k, v| k != 0 }
# = {29=>0, 37=>23, 433=>29, 13=>42, 17=>43, 19=>48, 23=>52, 977=>60, 41=>101}

# find t such that n_i are all integers
# k_i * n_i = t + v_i

# let the greatest k define t for all other k:
delta = schedule.max  # = [977, 60]
schedule.delete(delta[0])

# for next-highest k, determine the lowest n_977 where
# t = delta[0] * n_977 - delta[1]
# AND
# k * n_k = t + v -> (t + v) % k == 0
(k, v) = schedule.max  # = [433, 29]

step = 1
n = 1
t = delta[0] * n - delta[1]
until (t + v) % k == 0
  n += step
  t = delta[0] * n - delta[1]  # same formula as before
end

# now n is the first n_977 where the 433 and 977 buses agree on t
# the second n_977 where they agree is 433 greater than the first
# k = step size, n = first agreeable value for n_977

# ... after one more pass ...
# now n is the first n_977 where the 41, 433, and 977 buses all agree on t
# the second n_977 where they all agree is 41 * 433 greater than the first
# step *= k, n = still first agreeable value for n_977
# repeat until done

until schedule.length == 1
  schedule.delete(k)
  step *= k
  (k, v) = schedule.max

  until (t + v) % k == 0
    n += step
    t = delta[0] * n - delta[1]  # still same formula
  end
end

puts delta[0] * n - delta[1]
