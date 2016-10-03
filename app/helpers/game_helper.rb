module GameHelper
  def game_revenue(bet_amount, win_amount)
    win_amount - bet_amount
  end

  def win_background(bet_amount, win_amount)
    revenue = game_revenue(bet_amount, win_amount)

    if revenue > 0
      'tag-success'
    elsif revenue == 0
      'tag-primary'
    else
      'tag-danger'
    end
  end
end
