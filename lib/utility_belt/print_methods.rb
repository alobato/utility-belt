# Helps to inspect the list of methods in a class without clutter
# It will categorize and also filter out the Object's methods to help out
# just visualizing the relevant methods
#
# ex. String.print_methods
#
# author: Fabio Akita (akitaonrails.com)
module UtilityBelt
  module Editor
    def mate_class(obj)
      edit_class 'mate', obj
    end
    
    def vi_class(obj)
      edit_class 'vi', obj
    end
    
    # allows you to create a class interactively bit by bit 
    # and then edit the whole thing within an editor
    def edit_class(editor, obj)
      require 'ruby2ruby'
      unless @file
        @file = Tempfile.new("irb_tempfile")
        File.open(@file.path, 'w+') do |f|
          f.write Ruby2Ruby.translate(obj)
        end
      end
      system("#{editor} #{@file.path}")
      Object.class_eval(File.read(@file.path).gsub("\r", "\n"))
    rescue Exception => error
      puts @file.path
      puts error
    end
  end
  
  module PrintMethods
    INSPECTORS = [
      :public_methods,
      :public_instance_methods,
      :protected_methods,
      :protected_instance_methods,
      :private_methods,
      :private_instance_methods
      ]
    def print_methods(inspector = nil)
      buffer = []
      kself = self.class == Class ? self : self.class
      clist = kself.included_modules
      clist -= Object.included_modules unless kself == Object
      clist = clist.map { |m| m.name }.reject { |m| m =~ /UtilityBelt/ || m =~ /Wirble/ }.sort.map { |m| m.constantize }
      clist.unshift(kself.superclass) if kself.superclass && kself.superclass != Object
      clist.unshift(kself)

      inspector_methods = INSPECTORS.include?(inspector) ? [inspector] : INSPECTORS
      clist.each do |klass|
        inspector_methods.each do |insmethod|
          mlist = klass.send(insmethod).sort
          mlist -= klass.superclass.send(insmethod) if klass.respond_to?(:superclass) && clist.include?(klass.superclass)
          mlist -= Object.send(insmethod) unless klass == Object
          mlist -= ['append_features'] # dunno where this method comes from
          unless mlist.empty?
            return mlist if inspector_methods.size == 1
            buffer << "=== #{klass.name} === #{mlist.size} #{insmethod.to_s.split('_').join(' ')}"
            buffer << mlist.join(", ")
            buffer << ""
          end
        end
      end
      puts buffer.join("\n")
      nil
    end
  end

  # extracted from ActiveSupport. will only add if not already available
  module Inflector
    def constantize
      names = self.split('::')
      names.shift if names.empty? || names.first.empty?

      constant = Object
      names.each do |name|
        constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
      end
      constant
    end
  end
end
if Object.const_defined? :IRB
  Object.send(:extend, UtilityBelt::PrintMethods) 
  self.send(:extend, UtilityBelt::Editor) 
  String.send(:include, UtilityBelt::Inflector) if String.instance_methods.select { |m| m == 'constantize' }.empty?
end