class AdminMailer < ActionMailer::Base

  default from: 'direction@asconseil.eu'

  def assets_expire_soon
    @assets = Asset.expire_soon.includes(:client).order(expiration_date: :desc)
    mail(
      to: 'direction@asconseil.eu',
      subject: 'Des objets arrivent bientôt à expiration'
    )
  end

  def urgent_tickets_report
    @tickets = MaintenanceTicket.where(state: 'Ouvert - Urgent').includes(:client)
    mail(
      to: 'support@asconseil.eu',
      subject: 'Tickets état "Ouvert - Urgent"'
    )
  end

  def open_tickets_report
    @tickets = MaintenanceTicket.where(
      state: [
        'Ouvert',
        'Ouvert - Attente client',
        'Ouvert - Attente fournisseur',
        'Ouvert - Urgent'
      ]).includes(:client)
    mail(
      to: 'support@asconseil.eu',
      subject: 'Tickets état "Ouvert" (tous)'
    )
  end

end
