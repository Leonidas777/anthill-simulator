class Larva < Ant
  MAX_MATURITY_LEVEL = 100

  attr_reader :maturity_level

  def initialize(object_pool)
    return unless object_pool.anthill.has_free_space?(size)

    super(object_pool)
    object_pool.anthill.taken_space += size

    @live_level = 100
    @food_level = 50
    @maturity_level = 1
    @consumed_food_amount = 5
    @consumed_live_points = 5
  end

  def size
    1
  end

  def update
    consume_food
    @maturity_level += 2

    if mature?
      create_random_ant
      @object_pool.objects.delete(self)
    end
  end

  def mature?
    @maturity_level >= 100
  end

  def to_s
    "Larva. Maturity_level: #{@maturity_level}; live level: #{@live_level}; food level: #{@food_level}"
  end

  private

  def create_random_ant
    rand(0..1) == 0 ? Provider.new(@object_pool) : Worker.new(@object_pool)
  end
end
