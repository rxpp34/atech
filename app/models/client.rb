class Client < ActiveRecord::Base

  # Validations
  #############

  validates :name, presence: true
  validates :email, presence: true

  # Associations
  ##############

  has_many :maintenance_tickets
  has_many :assets

  # Class methods
  ###############

  default_scope -> {order(:name)}

end
