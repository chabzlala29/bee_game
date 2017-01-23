class CalculatePercentageService
  include Virtus.model

  attribute :key, Symbol
  attribute :bee_hash, Hash
  attribute :original_key, String

  attr_reader :original_hash, :current_hash

  def call
    _call
  end

  private

  def _call
    ((total_current_hp / total_max_hp) * 100).round(1)
  end

  def total_current_hp
    current_hash[:current_hp].to_f
  end

  def remainder_hp
    (original_hash[:quantity] - 1) *
      original_hash[:max_hp].to_f
  end

  def current_hash
    @current_hash ||= _current_hash
  end

  def original_hash
    @original_hash ||= _original_hash
  end

  def _current_hash
    @bee_hash[@key]
  end

  def _original_hash
    Bee.bee_hash[@original_key.to_sym]
  end

  def total_max_hp
    original_hash[:max_hp].to_f
  end
end
