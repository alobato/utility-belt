class ModelProxy  
  def initialize(klass)  
    @klass = klass  
  end

  # def /(id)  
  #   @klass.find(id)  
  # end
  
  #Allow for users/david type urls
  def /(id)
    case id
    when /\d+/
      @klass.find(id)
    else
      @klass.respond_to?(:find_by_param) ? @klass.find_by_param(id) : @klass.find(id)
    end  
  end
  
end

def define_model_find_shortcuts  
  model_files = Dir.glob("app/models/**/*.rb")  
  model_names = model_files.map { |f| File.basename(f).split('.')[0..-2].join }  
  model_names.each do |model_name|  
    Object.instance_eval do  
      define_method(model_name.pluralize) do |*args|  
        ModelProxy.new(model_name.camelize.constantize)  
      end  
    end  
  end  
end


if ENV['RAILS_ENV']
  IRB.conf[:IRB_RC] = Proc.new { define_model_find_shortcuts }
end