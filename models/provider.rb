class Provider < Ant
  def initialize(object_pool)
    return unless object_pool.anthill.has_free_space?(size)

    super(object_pool)
    object_pool.anthill.taken_space += size

    @live_level = 100
    @food_level = 50
    @consumed_food_amount = 4
    @consumed_live_points = 2
  end

  def size
    5
  end

  def update
    consume_food
    @object_pool.anthill.food_stock += 60
  end
end
