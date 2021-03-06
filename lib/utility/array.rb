class Array
  def is_a_record?
    if self.length > 0
      answer = true
      self.each {|i| answer = false if !i.is_a?(Hash)}
      return false unless answer
      schema = self[0].keys
      self.each {|i| answer = false if !i.keys == schema}
      return answer
    else
      return false
    end
  end
end