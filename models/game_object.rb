class GameObject
  UPDATE_RATE = 0.5

  def initialize(object_pool)
    @object_pool = object_pool
    @object_pool.objects << self

    @last_update = Time.now

    puts "#{self.class.name} (#{self.object_id}) has been created.".colorize(self.message_color)
  end  

  def update
  end

  def should_update?
    now = Time.now
    now - @last_update > UPDATE_RATE
  end
end
