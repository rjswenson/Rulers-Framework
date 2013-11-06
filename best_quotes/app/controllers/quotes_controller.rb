class QuotesController < Rulers::Controller
  def a_quote
    @verb = "crying"
    render :a_quote
  end

  def exception
    raise "It's a bad one!"
  end
 end
