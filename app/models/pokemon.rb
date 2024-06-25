class Pokemon < ApplicationRecord

    has_many :pokemon_moves
    has_many :moves, through: :pokemon_moves

    has_many :pokemon_types
    has_many :types, through: :pokemon_types
  
    validates :name_english, presence: true, uniqueness: true
    validates :pokemon_type, presence: true
    validates :base_hp, :base_attack, :base_defense, :base_sp_attack, :base_sp_defense, :base_speed, presence: true, numericality: true
  
    has_many :pokemon_regions
    has_many :regions, through: :pokemon_regions
  

  def moves_by_type
    Move.where(move_type: self.pokemon_type.split(', '))
  end
end
