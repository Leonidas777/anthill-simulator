class Game
  attr_accessor :state

  def initialize
    @object_pool = ObjectPool.new
    anthill = Anthill.new(@object_pool)

    queen = Queen.new(@object_pool)
    # create_larvas(1)

    create_workers(10)
    create_providers(15)

    @state = :play
  end

  def update
    @object_pool.queen.update
    @object_pool.objects.map(&:update)

    @object_pool.anthill.draw
  end

  def play_state?
    @state == :play
  end

  private

  def create_larvas(number=1)
    number.times { |num| puts @object_pool.queen.produce_larva }
  end

  def create_workers(number=1)
    number.times { |num| Worker.new(@object_pool) }
  end

  def create_providers(number=1)
    number.times { |num| Provider.new(@object_pool) }
  end
end
