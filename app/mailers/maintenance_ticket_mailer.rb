# encoding: utf-8

class MaintenanceTicketMailer < ActionMailer::Base

  add_template_helper(MaintenanceTicketHelper)
  add_template_helper(ApplicationHelper)

  default from: 'support@asconseil.eu'

  def send_ticket_infos(ticket, recipients, tech_recipient)
    @ticket = ticket
    mail from: 'nepasrepondre@asconseil.eu', to: recipients, bcc: tech_recipient, subject: send_ticket_subject
  end

  def send_montly_report(monthly_report)
    @monthly_report              = monthly_report
    attachment_name              = 'Visite mensuelle - ' \
                                   "#{monthly_report.display_name}.pdf"

    # see https://github.com/cloudinary/cloudinary_gem/issues/175
    if monthly_report.pdf.class.storage == Cloudinary::CarrierWave::Storage
      attachment_content =
        Cloudinary::Downloader.download monthly_report.pdf.full_public_id
    else
      attachment_content = monthly_report.pdf.file.read
    end

    attachments[attachment_name] = attachment_content

    @localized_montly_remort_name =
      if [4, 8, 10].include?(monthly_report.date.month)
        "d'#{monthly_report.display_name}"
      else
        "de #{monthly_report.display_name}"
      end

    mail to: monthly_report.recipients,
         subject: "Visite Mensuelle : #{monthly_report.display_name}"
  end

  private

  def ticket_created?
    @ticket.created_at_changed?
  end

  def send_ticket_subject
    status = if ticket_created?
               'crée'
             elsif @ticket.closed?
               'clôturé'
             end

    "Ticket numéro #{@ticket.id} #{status} - #{@ticket.client_name}"
  end

end
