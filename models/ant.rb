class Ant < GameObject
  attr_accessor :live_level, :food_level
  attr_reader   :size, :consumed_food_amount, :consumed_live_points

  def size
    0
  end

  def consume_food
    return starve if lack_of_food?

    if @live_level < self.class::MAX_LIVE_LEVEL
      @live_level += @consumed_food_amount

      if @live_level > self.class::MAX_LIVE_LEVEL
        @food_level += food_level_delta
        @live_level = self.class::MAX_LIVE_LEVEL
      end

    elsif @food_level < self.class::MAX_FOOD_LEVEL
      @food_level += @consumed_food_amount

      @food_level = self.class::MAX_FOOD_LEVEL if @food_level > self.class::MAX_FOOD_LEVEL
    end

    eat_food
    loose_space_from_food
  end

  def food_level_delta
    @live_level % self.class::MAX_LIVE_LEVEL
  end

  def message_color
    case self.class.name
      when 'Larva'    then :light_green
      when 'Provider' then :light_magenta
      when 'Worker'   then :light_red
      else :blue end
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

      if @food_level < 0
        @live_level += @food_level
        @food_level = 0
      end
    end    
  end

  def food_level_empty?
    @food_level <= 0
  end

  def live_level_empty?
    @live_level < @consumed_live_points
  end

  def consume_its_own_resources
    if live_level_empty?

      if self.is_a?(Queen)
        $game.state = :over
        puts "<== Game over! Queen died! ==>".red
        return
      end

      @object_pool.objects.delete(self)
      puts "#{self.class.name} died from starving!".red
      
      decrement_number_of_objects

      @object_pool.anthill.taken_space -= self.size
    else
      @live_level -= @consumed_live_points
      puts "#{self.class.name} is starving(live level: #{@live_level}, food level: #{@food_level})"
    end
  end

  def decrement_number_of_objects
    anthill = @object_pool.anthill
    method_name = :"#{self.class.name.downcase}s_number"
    anthill.send("#{method_name}=", anthill.send(method_name) - 1)
  end

  def eat_food
    @object_pool.anthill.food_stock -= @consumed_food_amount
  end

  def loose_space_from_food
    @object_pool.anthill.taken_space -= (@consumed_food_amount.to_f / Anthill::FOOD_SIZE).round
    @object_pool.anthill.taken_space = 0 if @object_pool.anthill.taken_space < 0
  end
end
