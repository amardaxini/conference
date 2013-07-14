require 'terminal-table/import'
 
class SubsetSumMatrix
  class << self
    def create_empty_for(array)
      matrix = []
      header = [nil] + build_header_from(array)
      matrix << header
      array.each_with_index do |element,i|
        row = header.collect{|value| 'F'}
        row[0] = i
        matrix << row
      end
      matrix
    end
 
    def build_header_from(array)
      sorted_array = array.sort
      sum_negative = 0
      sum_positive = 0
      sorted_array.each do |element|
        sum_negative += element if element < 0
        sum_positive += element if element > 0
      end
      (sum_negative..sum_positive).to_a
    end
 
    def build_column_value_to_index_hash(matrix_header)
      hash = {}
      matrix_header.each_with_index do |element,i|
        next if i == 0 #skipping the first index since it has no value
        hash[element] = i
      end
      hash 
    end
  end
  def initialize(array)
    @array = array
    @matrix = SubsetSumMatrix.create_empty_for(array)
    @column_value_to_index = SubsetSumMatrix.build_column_value_to_index_hash(@matrix[0])
  end
 
  def initialize_first_row
    @matrix[1].each_with_index do |element,i|
      next if i == 0 # skipping the first one since it is the index into the array
      if @array[@matrix[1][0]] == @matrix[0][i] # the only sum we can have is the first number itself
        @matrix[1][i] = 'T'
      end
    end
    @matrix
  end
 
  def populate
    (2...@matrix.size).each do |row|
      @matrix[row].each_with_index do |element,i|
        next if i == 0
        if @array[@matrix[row][0]] == @matrix[0][i] || @matrix[row-1][i] == 'T' || current_sum_possible(row, i) 
          @matrix[row][i] = 'T'
        end
      end
    end
    @matrix
  end
 
  def current_sum_possible(row, column)
    column_sum = @matrix[0][column] - @array[@matrix[row][0]]
    column_index = @column_value_to_index[column_sum]
    return false unless column_index
    @matrix[row-1][column_index] == 'T'
  end
 
  def derive_subset_for(reference_value)
    subset = []
    column_index = @column_value_to_index[reference_value]
    (1...@matrix.size).to_a.reverse.each do |row|
      if @matrix[row][column_index] == 'F'
        return subset
      elsif @matrix[row-1][column_index] == 'T'
        next
      else
        array_value = @array[row - 1] # the -1 is to account for the fact that our rows are 1 larger than indexes of input array due to row 0 in matrix being header
        subset.insert(0, array_value)
        column_index = @column_value_to_index[@matrix[0][column_index] - array_value]
      end
    end
    subset
  end
 
  def to_s
    puts "Input: #{@array.inspect}"
    puts "Reference value: #{@reference_value}"
    puts table(*@matrix)
  end
end
 
def subset_sum_dynamic(array, target_value)
  matrix = SubsetSumMatrix.new(array)
  #matrix.to_s
  matrix.initialize_first_row
  #matrix.to_s
  matrix.populate
  #matrix.to_s
  subset = matrix.derive_subset_for(target_value)
  puts "Subset sums to: #{ subset.reduce(0){|accumulator, value| accumulator + value} }"
  subset
end
 
def n_integers_randomized_between(range, n)
  range.to_a.shuffle[0...n]
end
 
#puts subset_sum_dynamic([1, -3, 4, 5, -8, 7, -1], 0).inspect
#puts subset_sum_dynamic([1, -3, 2, 4], 0).inspect
#puts subset_sum_dynamic([ 802, 421, 143, -302, 137, 316, 150, -611, -466, -42, -195, -295 ], 0).inspect
#puts subset_sum_dynamic(n_integers_randomized_between((-1000..1000), 50), 0).inspect
 values = [5, 30, 30, 30, 30, 30, 30, 30, 45, 45, 45, 45, 45, 45, 60, 60, 60, 60, 60]
 puts subset_sum_dynamic(n_integers_randomized_between(values, 50), 180).inspect
if ENV["attest"]
  this_tests "generating subset sums using dynamic programming" do
    test("subset should be [1,-3,2]") do
      actual_subset_sum = subset_sum_dynamic([1, -3, 2, 4], 0)
      should_equal([1,-3,2], actual_subset_sum)
    end
    test("subset should be [1,-8, 7]") do
      actual_subset_sum = subset_sum_dynamic([1, -3, 4, 5, -8, 7, -1], 0)
      should_equal([1,-8,7], actual_subset_sum)
    end
    test("subset should be [316, 150,-466]") do
      actual_subset_sum = subset_sum_dynamic([ 802, 421, 143, -302, 137, 316, 150, -611, -466, -42, -195, -295 ], 0)
      should_equal([316,150,-466], actual_subset_sum)
    end
  end
end
