class BuildSessionHashService
  include Virtus.model

  class << self
    Bee::BEE_TYPES.each do |bee|
      define_method "default_#{bee}_hash" do
        { current_hp: Bee.bee_hash[bee][:max_hp], current_quantity: Bee.bee_hash[bee][:quantity] }
      end
    end
  end

  attribute :queen, Hash, default: BuildSessionHashService.default_queen_hash
  attribute :worker, Hash, default: BuildSessionHashService.default_worker_hash
  attribute :drone, Hash, default: BuildSessionHashService.default_drone_hash
  attribute :current_hash, Hash, {}

  def call
    _call
  end

  private

  def _call
    hash ||= current_hash
    Bee::BEE_TYPES.each do |bee|
      if bee.eql?("queen")
        bee_hash = hash[:queen] || @queen
        hash[bee] ||= {
          current_hp: bee_hash[:current_hp],
          type: bee
        }
      else
        Bee.bee_hash[bee][:quantity].times do |index|
          key = bee.to_s + (index + 1).to_s
          current_hp = hash[key.to_sym][:current_hp] rescue instance_variable_get("@#{bee}")[:current_hp]
          hash[key] ||= {
            current_hp: current_hp,
            type: bee
          }
        end
      end
    end
    hash
  end
end
