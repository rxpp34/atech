class Disk < ActiveRecord::Base

  # Constants
  ###########

  STATES = %w(Ok Acceptable Dangereux)

  belongs_to :server_asset

end
