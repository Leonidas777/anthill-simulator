class Anthill
  attr_accessor :all_space, :taken_space, :food_stock

  def initialize(object_pool)
    @all_space = 1000
    @taken_space = 0
    @food_stock = 1000
    object_pool.anthill = self
  end

  def food_stock_empty?
    @food_stock <= 0
  end

  def has_free_space?(space_needed)
    @all_space - @taken_space > space_needed
  end  
end
