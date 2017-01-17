class Provider < Ant
  TIME_TO_GET_MORE_FOOD = 3

  MAX_LIVE_LEVEL = 40
  MAX_FOOD_LEVEL = 60

  OBTAINED_FOOD = 80

  def initialize(object_pool)
    return unless object_pool.anthill.has_free_space?(size)

    super(object_pool)
    object_pool.anthill.taken_space += size

    object_pool.anthill.providers_number += 1

    @live_level = 100
    @food_level = 50
    @consumed_food_amount = 4
    @consumed_live_points = 2

    @last_time_food_got = Time.now
  end

  def size
    5
  end

  def update
    return unless should_update?
    @last_update = Time.now

    consume_food

    return unless should_get_food?
    @last_time_food_got = Time.now

    anthill = @object_pool.anthill

    anthill.food_stock += OBTAINED_FOOD
    anthill.taken_space += OBTAINED_FOOD / Anthill::FOOD_SIZE
  end

  private

  def should_get_food?
    Time.now - @last_time_food_got > TIME_TO_GET_MORE_FOOD && has_space_for_food?
  end

  # def free_space_for_food
  #   @object_pool.anthill.free_space_amount / FOOD_SIZE
  # end

  def has_space_for_food?
    @object_pool.anthill.free_space_amount > Anthill::MINIMUM_SPACE_FOR_FOOD
  end
end
