# Helps to inspect the list of methods in a class without clutter
# It will categorize and also filter out the Object's methods to help out
# just visualizing the relevant methods
#
# ex. String.print_methods
#
# author: Fabio Akita (akitaonrails.com)
module UtilityBelt
  module Editor
    # shortcut to textmate
    def mate
      edit_interactively 'mate'
    end
    
    # shortcut to vi
    def vi
      edit_interactively 'vi'
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
Object.send(:extend, UtilityBelt::PrintMethods)
String.send(:include, UtilityBelt::Inflector) if String.instance_methods.select { |m| m == 'constantize' }.empty?
