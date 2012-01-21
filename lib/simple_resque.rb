module SimpleResque
  extend self

  def resque=(r)
    @resque = r
  end

  def push(klass,args = nil)
    queue_name = make_queue_name(klass)
    resque.push(queue_name, class: klass, args: args)
  end

  def pop(klass)
    queue_name = make_queue_name(klass)
    resque.pop(queue_name)
  end

  def size(klass)
    queue_name = make_queue_name(klass)
    resque.size(queue_name)
  end

  def clear(klass)
    queue_name = make_queue_name(klass)
    resque.remove_queue(queue_name)
  end

  private

  # this code borrowed from active_support's underscore method
  def make_queue_name(klass)
    name = klass.dup
    name.gsub!(/::/, '/')
    name.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
    name.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    name.tr!("-", "_")
    name.downcase!
    name
  end

  def resque
    @resque || Resque
  end
end
