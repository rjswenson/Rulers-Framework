class QuotesController < Rulers::Controller
  def a_quote
    @verb = "crying"
    render :a_quote
  end

  def exception
    raise "It's a bad one!"
  end

  def quote_1
    quote_1 = Rulers::Model::FindModel.find(1)
    render :quote, :obj => quote_1
  end
end
