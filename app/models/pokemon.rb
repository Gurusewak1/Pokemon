class Pokemon < ApplicationRecord
    def moves_by_type
        Move.where(move_type: self.pokemon_type.split(', '))
      end
end
