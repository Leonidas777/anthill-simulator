class Queen < Ant
  def initialize(object_pool)
    return unless object_pool.anthill.has_free_space?(size)

    object_pool.queen = self
    object_pool.anthill.taken_space += size

    @object_pool = object_pool

    @live_level = 100
    @food_level = 50
    @consumed_food_amount = 50
    @consumed_live_points = 20
  end

  def update
    consume_food
    produce_larva
  end

  def produce_larva
    Larva.new(@object_pool)
  end

  def size
    20
  end
end
