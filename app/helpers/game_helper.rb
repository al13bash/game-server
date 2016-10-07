module GameHelper
  def game_revenue(bet_amount, win_amount)
    win_amount - bet_amount
  end

  def win_background(bet_amount, win_amount)
    revenue = game_revenue(bet_amount, win_amount)

    if revenue.positive?
      'tag-success'
    elsif revenue.zero?
      'tag-primary'
    else
      'tag-danger'
    end
  end

  def status_color(status)
    case status
    when 'pending' then 'info'
    when 'in_validation' then 'warning'
    when 'in_progress' then 'primary'
    when 'done' then 'success'
    when 'failure' then 'danger'
    end
  end
end
