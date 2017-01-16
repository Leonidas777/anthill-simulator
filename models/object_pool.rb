class ObjectPool
  attr_accessor :objects, :anthill, :queen

  def initialize
    @objects = []
  end

  def size
    @objects.size
  end
end
