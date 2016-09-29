module AccountHelper
  def accounts_select(accounts)
    accounts.map do |ac| 
      ["#{ac.amount.currency} - (Balance: #{ac.amount.format})", ac.id]
    end
  end
end
