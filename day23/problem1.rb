circle = '962713854'.split('').map{ |x| x.to_i }

(1..100).each do
  current = circle[0]
  grab = circle.slice!(1, 3)
  target = current - 1
  until circle.include? target
    if (target == 0)
      target = circle.max
    else
      target -= 1
    end
  end
  circle.insert(circle.index(target) + 1, grab)
  circle = circle.flatten
  circle = circle[1..-1] + [current]
end

one = circle.index(1)
puts "#{(circle[one + 1..-1] + circle[0...one]).join('')}"
