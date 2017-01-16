class Worker < Ant
  def initialize(object_pool)
    return unless object_pool.anthill.has_free_space?(size)

    super(object_pool)
    object_pool.anthill.taken_space += size

    @live_level = 100
    @food_level = 50
    @consumed_food_amount = 3
    @consumed_live_points = 3
    @live_level = 100
  end

  def size
    4
  end

  def update
    consume_food
    @object_pool.anthill.all_space += 1
  end
end
