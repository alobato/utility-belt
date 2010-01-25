class Object
  include Hirb::Console
  def table_methods
    defaults = local_methods.inject({}) {|h, e| h[e] = [];h }
    table defaults.map {|e| [e[0], e[1].join(",")] }, :headers => %w{commands aliases}, :max_width=>80
  end

  # Return a list of methods defined locally for a particular object.  Useful
  # for seeing what it does whilst losing all the guff that's implemented
  # by its parents (eg Object).
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
end