class Ant < GameObject
  attr_accessor :live_level, :food_level
  attr_reader   :size, :consumed_food_amount, :consumed_live_points

  def size
    0
  end

  def consume_food
    return starve if lack_of_food?

    @object_pool.anthill.food_stock -= @consumed_food_amount

    if @live_level < 100
      @live_level += @consumed_food_amount
      @food_level += @live_level % 100
    else
      @food_level += @consumed_food_amount
      @food_level = 100 if @food_level > 100
    end
  end

  private

  def lack_of_food?
    @object_pool.anthill.food_stock < @consumed_food_amount
  end

  def starve
    if food_level_empty?
      consume_its_own_resources
    else
      @food_level -= @consumed_live_points
    end    
  end

  def food_level_empty?
    @food_level < @consumed_food_amount
  end

  def live_level_empty?
    @live_level < @consumed_food_amount
  end

  def consume_its_own_resources
    if live_level_empty?
      @object_pool.objects.delete(self)
    else
      @live_level -= @consumed_live_points
    end
  end
end 
