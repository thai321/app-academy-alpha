
def search_for_sum(arr, n)
  low = 0
  high = (arr.length - 1)

  while low < high

    if arr[low] + arr[high] == n
      return true
    elsif arr[low] + arr[high] > n # if the lowest number and the highest number are greater than the sum
      high -=1  # then we need to start from a lower highest number
      next
    else
      low += 1  #if the lowest and highest are less than the sum, go up a low number - can this happen too early?
    end

  end
  false
end

puts search_for_sum([1, 5, 8, 22], 27)
puts search_for_sum([1, 5, 8, 22], 14)
puts search_for_sum([rand(1..4), rand(4..6), 7, 8, rand(8..100), rand(100..200)], 15)
#
#
# def search_for_sum2(arr,k):
#
#     if len(arr) < 2:
#         return
#
#     #Sets for tracking
#     seen = set()
#     output = set()
#
#     for num in arr:
#
#         target = k - num
#
#         if target not in seen:
#             seen.add(num)  # this make thing unique , ex: [1,2,3,1], 3
#         else:
#             output.add( ((min(num,target)), max(num,target)) )
# #     return len(output)
#     print '\n'.join(map(str,list(output)))

require 'set'
# My version of search for sum, *tesed, and passed*
# Time complexity should be O(n), worst case O(n) , best case O(1)
# Since I'm using data structure of Set, space complexity should also be O(n),
# worst case of returning false will appending n elements.

require 'set'
def search_for_sum2(arr,n)
  return false if (arr[0] >= n) || (arr.length < 2)

  seen = Set.new()

  arr.each do |num|
    return false if (num > n) # can't find a pair sum in the list of
                              #  elements less than n --> no need to go further
    target = n - num
    if !seen.include?(target) then seen.add(num) else return true end
  end
  false # The worst case that no pair are found in the list,
           # then set of seen will have all elements of arr.
end

# puts search_for_sum2([1, 5, 8, 22], 27)
# puts search_for_sum2([1, 5, 8, 22], 14)
# puts search_for_sum2([rand(1..4), rand(4..6), 7, 8, rand(8..100), rand(100..200)], 15)
# #
