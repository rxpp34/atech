class Asset < ActiveRecord::Base

  # Associations
  ##############
  belongs_to :client

  # Class methods
  ###############

  # expire in ENV["ASSET_EXPIRE_SOON_DAYS_DELAY"] days or less
  scope :expire_soon, -> {
    t = arel_table
    where(
      t[:expiration_date].lt(
        Time.zone.today + ENV["ASSET_EXPIRE_SOON_DAYS_DELAY"].to_i
      )
    )
  }

  # Validations
  #############

  validates :expiration_date, presence: true

  # Instance methods
  ##################

  delegate :name, to: :client, prefix: true

end
