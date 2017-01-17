class Anthill < GameObject
  attr_accessor :all_space, :taken_space, :food_stock,
                :larvas_number, :workers_number, :providers_number
  
  FOOD_SIZE = 10

  MINIMUM_SPACE_FOR_FOOD = 10

  def initialize(object_pool)
    @all_space = 1000
    @taken_space = 0
    @food_stock = 6000
    object_pool.anthill = self

    @object_pool = object_pool

    @larvas_number = 0
    @workers_number = 0
    @providers_number = 0

    @last_update = Time.now
  end

  def food_stock_empty?
    @food_stock <= 0
  end

  def has_free_space?(space_needed)
    @all_space - @taken_space > space_needed
  end

  def to_s
    # "Anthill ==> all space: #{@all_space}; taken space: #{@taken_space}; food stock: #{@food_stock}"#.colorize(color: :black, background: :yellow)
  end

  def update
  end

  def draw
    return unless should_update?
    @last_update = Time.now
    puts "#{'Anthill'.colorize(color: :light_cyan)} ==> all space: #{@all_space.to_s.light_green}; taken space: #{@taken_space.to_s.light_green}; food stock: #{@food_stock.to_s.light_green}; larvas: #{@larvas_number.to_s.light_green}; workers: #{@workers_number.to_s.light_green}; providers: #{@providers_number.to_s.light_green}; #{'Queen'.colorize(color: :light_cyan)} ==> live level: #{@object_pool.queen.live_level.to_s.light_green}; food level: #{@object_pool.queen.food_level.to_s.light_green}"#.colorize(color: :black, background: :yellow)
    # $stdout.flush
  end

  def should_draw?
    Time.now - @last_update > UPDATE_RATE
  end

  def free_space_amount
    @all_space - @taken_space
  end
end
