class Larva < Ant
  MAX_MATURITY_LEVEL = 100

  MAX_LIVE_LEVEL = 30
  MAX_FOOD_LEVEL = 40

  attr_reader :maturity_level

  def initialize(object_pool)
    return unless object_pool.anthill.has_free_space?(size)

    super(object_pool)
    object_pool.anthill.taken_space += size

    object_pool.anthill.larvas_number += 1

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
    return unless should_update?
    @last_update = Time.now

    consume_food
    @maturity_level += 2

    if mature?
      create_random_ant
      @object_pool.objects.delete(self)
      @object_pool.anthill.larvas_number -= 1
      @object_pool.anthill.taken_space -= size
    end
  end

  def mature?
    @maturity_level >= MAX_MATURITY_LEVEL
  end

  def to_s
    "Larva. Maturity_level: #{@maturity_level}; live level: #{@live_level}; food level: #{@food_level}"
  end

  private

  def create_random_ant
    new_ant = rand(0..1) == 0 ? Provider.new(@object_pool) : Worker.new(@object_pool)
    puts "Larva (#{self.object_id}) turned into a #{new_ant.class.name} (#{new_ant.object_id})"
  end
end
