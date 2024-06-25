class Move < ApplicationRecord
    self.inheritance_column = nil
  
    # Validations
    validates :accuracy, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    validates :ename, presence: true
    validates :power, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :pp, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :move_type, presence: true
  
  end
  