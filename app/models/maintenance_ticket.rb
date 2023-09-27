class MaintenanceTicket < ActiveRecord::Base

  # Constants
  ###########

  MAINTAINED_BY = [
    'Téléphone',
    'Prise de main',
    'Sur site',
    'Atelier',
    'Email'
  ]

  STATES = [
    'Ouvert',
    'Ouvert - Attente client',
    'Ouvert - Attente fournisseur',
    'Ouvert - Urgent',
    'Fermé'
  ]

  TECH_PEOPLE = ENV['TECH_PEOPLE'].split(',')

  # Associations
  ##############

  belongs_to :client

  # Validations
  #############

  validates :client_id, presence: true
  validates :duration, presence: true
  validates :maintenance_date, presence: true

  # Callbacks
  ###########

  before_save :_remove_blank_from_assigned_to
  after_save :notify

  scope :not_closed, -> {
    where(arel_table[:state].matches('%Ouvert%'))
  }

  scope :urgent, -> {
    where(state: "Ouvert - Urgent")
  }

  scope :open, -> {
    where(state: "Ouvert")
  }

  # Instance methods
  ##################

  delegate :name, :email, to: :client, prefix: true

  def notify(options = {force: false})
    _notify and return if options[:force] == true

    return if do_not_send_email
    return unless created_at_changed? || closed?

    _notify
  end

  def _notify
    tech_emails = {
      "Jérome" => "direction@asconseil.eu",
      "Paul" => "paul.loze@asconseil.eu",
      "Damien" => "damien.lacassagne@asconseil.eu",
      "Volodia" => "volodia.tortosa@asconseil.eu",
      "Sylvain" => "sylvain.rigaud@asconseil.eu",
      "Technicien" => "support@asconseil.eu",
      "N2" => "n2@asconseil.eu"
    }

    tech_recipient = tech_emails[assigned_to.first]
    emails = recipients.split(',').map(&:strip) | [client_email].compact

    MaintenanceTicketMailer.send_ticket_infos(self, emails, tech_recipient)
      .deliver_now unless emails.empty?
  end

  def opened?
    !(state =~ /Ouvert/).nil?
  end

  def closed?
    state == 'Fermé'
  end

  private

  def _remove_blank_from_assigned_to
    assigned_to.reject!(&:blank?)
  end

end
