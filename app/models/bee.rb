class Bee
  include Virtus.model

  BEE_TYPES = [:queen, :worker, :drone]

  attribute :key, String
  attribute :current_bee, Hash

  def self.bee_hash
    {
      queen: { label: "Queen Bee", max_hp: 100, per_hit: 8, quantity: 1 },
      worker: { label: "Worker Bee", max_hp: 75, per_hit: 10, quantity: 5 },
      drone: { label: "Drone Bee", max_hp: 50, per_hit: 12, quantity: 8 },
    }
  end

  %w(max_hp per_hit quantity).each do |method|
    define_method method do
      type = current_bee[:type]
      Bee.bee_hash[type.to_sym][method.to_sym]
    end
  end
end
