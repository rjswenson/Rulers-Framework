require "erubis"

template = <<TEMPLATE
Hello! This is a template.
It has <%= example %>.
TEMPLATE

eruby = Erubis::Eruby.new(template)
puts "==============="
puts eruby.result(:example => "Acid Jazz!")
