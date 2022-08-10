class Project < ApplicationRecord

    has_many :bugs
    has_many :userprojects
    belongs_to :creator  
    has_many :users, through: :userprojects
end
