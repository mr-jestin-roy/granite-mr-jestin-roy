# frozen_string_literal: true

def intersection(arr1, arr2)
  common_elements = arr1.select { |item| arr2.include?(item) }
  common_elements.map! { |item| item.to_i }
  common_elements
end

array = gets.chomp
array = array.split(" ")
another_array = gets.chomp
another_array = another_array.split(" ")
print(intersection(array, another_array))
