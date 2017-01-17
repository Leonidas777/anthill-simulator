class Worker < Ant
  TIME_TO_CREATE_SPACE = 3

  MAX_LIVE_LEVEL = 50
  MAX_FOOD_LEVEL = 50

  def initialize(object_pool)
    return unless object_pool.anthill.has_free_space?(size)

    super(object_pool)
    object_pool.anthill.taken_space += size

    object_pool.anthill.workers_number += 1

    @live_level = 100
    @food_level = 50
    @consumed_food_amount = 5
    @consumed_live_points = 3
    @live_level = 100

    @last_time_space_created = Time.now
  end

  def size
    4
  end

  def update
    return unless should_update?
    @last_update = Time.now
    
    consume_food

    return unless should_create_new_space?
    @last_time_space_created = Time.now

    @object_pool.anthill.all_space += 1
  end

  private

  def should_create_new_space?
    Time.now - @last_time_space_created > TIME_TO_CREATE_SPACE
  end
end
