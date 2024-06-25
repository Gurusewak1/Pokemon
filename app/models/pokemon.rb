class Pokemon < ApplicationRecord
  has_and_belongs_to_many :types
  
  
    validates :name_english, presence: true, uniqueness: true
    validates :pokemon_type, presence: true
    validates :base_hp, :base_attack, :base_defense, :base_sp_attack, :base_sp_defense, :base_speed, numericality: { greater_than_or_equal_to: 0 }

  
    def moves_by_type
        Move.where(move_type: self.pokemon_type.split(', '))
      end
end
