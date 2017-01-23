class HitBeeService
  include Virtus.model

  attribute :bee, Bee
  attribute :bee_game, Hash
  attribute :hits, Integer
  attribute :min_hits, Integer

  def call
    _call
  end

  private

  def _call
    key = bee.key.to_sym
    current_hp = bee_game[key][:current_hp]
    remaining_hp = current_hp - bee.per_hit
    current_hp = (remaining_hp < 0) ? 0 : remaining_hp
    bee_game[key][:current_hp] = current_hp

    @hits += 1

    if current_hp == 0 && key.eql?(:queen1)
      @min_hits = if @hits > 0
                    if @min_hits == 0
                      @hits
                    elsif @hits < @min_hits
                      @hits
                    else
                      0
                    end
                  end
      @hits = 0
      BuildSessionHashService.new(current_hash: {}).call
    else
      BuildSessionHashService.new(current_hash: bee_game).call
    end
  end
end
