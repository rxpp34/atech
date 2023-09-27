module MaintenanceTicketHelper
  def ticket_assigned_to_human(ticket)
    ticket.assigned_to.join(' et ')
  end

  def ticket_visit_card_url(ticket)
    first_tech = ticket.assigned_to.first
    return unless first_tech

    tech_visit_card_url(first_tech)
  end
end
