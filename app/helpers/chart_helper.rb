module ChartHelper
  def min_y(int)
    (int - 200) / 100 * 100
  end

  def max_y(int)
    (int + 200) / 100 * 100
  end
end
