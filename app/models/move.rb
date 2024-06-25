class Move < ApplicationRecord
    self.inheritance_column = nil
    has_many :pokemon_moves
    has_many :pokemons, through: :pokemon_moves

  
    # Validations
    validates :accuracy, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    validates :ename, presence: true
    validates :pp, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :move_type, presence: true
  
  end
  