module ApplicationHelper
  def get_percentage(key, bee_hash, original_key)
    CalculatePercentageService.new(key: key, bee_hash: bee_hash, original_key: original_key).call
  end
end
