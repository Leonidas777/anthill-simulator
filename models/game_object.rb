class GameObject
  def initialize(object_pool)
    @object_pool = object_pool
    @object_pool.objects << self
  end

  def update
  end
end
