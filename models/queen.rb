class Queen < Ant
  TIME_TO_PRODUCE_LAVRA = 10
  MINIMUM_ACTUAL_SPACE = 20
  MINIMUM_SPACE_PERCENTAGE = 5
  SPACE_TO_PRODUCE_LARVAS = 10

  MAX_LIVE_LEVEL = 200
  MAX_FOOD_LEVEL = 200

  def initialize(object_pool)
    return unless object_pool.anthill.has_free_space?(size)

    object_pool.queen = self
    object_pool.anthill.taken_space += size

    @object_pool = object_pool

    @live_level = 100
    @food_level = 50    
    @consumed_food_amount = 10
    @consumed_live_points = 5

    @last_update = Time.now
    @last_produced_lavra_time = Time.now
  end

  def update
    return unless should_update?
    @last_update = Time.now

    consume_food

    if should_produce_larva?
      produce_larvas(count_of_produced_larvas_by_food)

      @last_produced_lavra_time = Time.now
    end    
  end  

  def free_space_percentage
    anthill = @object_pool.anthill
    100 - (anthill.taken_space.to_f / anthill.all_space) * 100
  end

  def actual_free_space
    anthill = @object_pool.anthill
    anthill.all_space - anthill.taken_space
  end

  def count_of_produced_larvas_by_food
    case @object_pool.anthill.food_stock
    when 0..10 then 0
    when 10..20 then 1
    when 20..30 then 2
    when 30..40 then 3
    else 4 end
  end

  def produce_larva
    Larva.new(@object_pool)
  end

  def produce_larvas(number=1)
    number.times { |num| puts produce_larva }
  end

  def size
    20
  end

  private

  def should_produce_larva?
    Time.now - @last_produced_lavra_time > TIME_TO_PRODUCE_LAVRA && has_free_space?
  end

  def has_free_space?
    @object_pool.anthill.free_space_amount > SPACE_TO_PRODUCE_LARVAS
  end
end
