require 'appscript'

module Appscript
  class Reference
    
    def get_properties(*props)
      puts "GET_PROPERTIES"
      props = Array(props).flatten
      responses = {}
      begin
        props.each do |prop|
          responses[prop] = self.send(prop).get
        end
      rescue Appscript::CommandError
        return []
      end
      (0..(Array(responses[props.first]).length - 1)).map do |i|
        prop_hash = {}
        props.each do |prop|
          value = [responses[prop]].flatten[i]
          value = nil if value == :missing_value
          prop_hash[prop.to_s.downcase] = value
        end
        prop_hash
      end
    end
    
  end
end