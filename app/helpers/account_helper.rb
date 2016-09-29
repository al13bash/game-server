module AccountHelper
  def accounts_select(accounts)
    accounts.map do |ac|
      {
        value: ac.id,
        label: "#{ac.amount.currency} - (Balance: #{ac.amount.format})"
      }
    end
  end
end
