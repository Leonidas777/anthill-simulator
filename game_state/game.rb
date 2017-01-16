class Game

  def initialize
    @object_pool = ObjectPool.new
    anthill = Anthill.new(@object_pool)

    queen = Queen.new(@object_pool)
    create_larvas(3)

    create_workers(10)
    create_providers(10)
  end

  def update
    @object_pool.objects.map(&:update)
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
