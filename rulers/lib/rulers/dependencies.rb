class Object
  def self.const_missing(c)
    @looked_for ||= {}
    str_of_class = c.to_s
    raise "Class not found: #{str_of_class}" if @looked_for[str_of_class]

    @looked_for[str_of_class] = true
    require Rulers.to_underscore(str_of_class)
    klass = Object.const_get(c)

    return klass if klass
    raise "Class not found: #{c}"
  end
end
