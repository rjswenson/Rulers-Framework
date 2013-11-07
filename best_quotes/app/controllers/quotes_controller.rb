class QuotesController < Rulers::Controller
  def index
    @quotes = FileModel.all
    render :index
  end

  def new_quote
    attrs = {
      "submitter" => "web user",
      "quote" => "A picture is worth a thousand pixels",
      "attribution" => "Jo-mama"
    }
    m = FileModel.create attrs
    render :quote, :obj => m
  end

  def show
    @quote = FileModel.find(params["id"])
    @ua = request.user_agent
    render_response :quote, :obj => @quote
  end

  def update
    if env['REQUEST_METHOD'] == 'POST'
      @quote = FileModel.find(params["id"])
      attrs = {
        "submitter" => "web user",
        "quote" => "A picture is worth a thousand pixels",
        "attribution" => "Jo-mama"
      }
      @quote.params = attrs
      @quote.save
    else
      raise "Only updatable with POST requests!"
    end
  end

  def a_quote
    @verb = "crying"
    render :a_quote
  end

  def exception
    raise "It's a bad one!"
  end

  def quote_1
    quote_1 = Rulers::Model::FileModel.find(1)
    render :quote, :obj => quote_1
  end
end
