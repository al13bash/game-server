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

  def status_color(status)
    case status
    when 'pending' then 'info'
    when 'in_progress' then 'warning'
    when 'done' then 'success'
    when 'failure' then 'danged'
    end
  end
end
