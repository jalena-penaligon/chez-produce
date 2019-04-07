class Cart
  def initialize(initial_contents)
    @contents = initial_contents
  end

  def total_count
    if @contents != nil
      @contents.values.sum
    else
      0
    end
  end
end
