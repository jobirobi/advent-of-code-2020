card = 8421034
door = 15993936

subj = 7
value = 1
n = 0
until value == card or value == door
  n += 1
  value = (subj * value) % 20201227
end

# now I have the loop size for one of the keys
# so just loop the other key using the known loop size
subj = (value == card) ? door : card
value = 1
(1..n).each do
  value = (subj * value) % 20201227
end

puts value
