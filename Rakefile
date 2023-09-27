#!/usr/bin/env rake

require File.expand_path('../config/application', __FILE__)

AdminAsconseilEu::Application.load_tasks

desc 'Loads the clients from the xls file in vendor/asconseil/clients.xls'
task load_clients: [:environment] do
  uri = 'File://' + (Rails.root + 'vendor/asconseil/clients.xls').to_s

  t = RemoteTable.new uri
  t.rows.each do |r|
    Client.find_or_create_by_name name: r['name'], email: r['email']
  end
end

desc 'Send reminder email every monday when assets are about to expire'
task send_assets_expire_soon_reminder: [:environment] do
  if Time.zone.today.monday? && (Asset.expire_soon.count > 0)
    AdminMailer.assets_expire_soon.deliver_now
  end
end

task send_urgent_tickets_report: [:environment] do
  AdminMailer.urgent_tickets_report.deliver_now
end

task send_open_tickets_report: [:environment] do
  AdminMailer.open_tickets_report.deliver_now
end

task dup_montly_reports: [:environment] do
  previous_date = Date.new(2019, 7)
  new_date = Date.new(2019, 8)

  reports = MonthlyReport.joins(server_asset: :client)
    .merge(Client.where.not(name: ['FARELLA']))
    .where(date: previous_date)

  reports.each do |r|
    next if r.server_asset.monthly_reports.any? {|rr| rr.date == new_date.to_s || rr.date == new_date }
    new_r = r.dup
    new_r.date = new_date
    new_r.tech = "Volodia"
    new_r.save
    new_r.save_pdf

    if false
      MaintenanceTicketMailer.send_montly_report(new_r).deliver_now
    end
  end

  # Use this to send the monthlys by hand
  # MonthlyReport.where(date: new_date).each do |new_r|
  #   MaintenanceTicketMailer.send_montly_report(new_r).deliver_now
  # end
end
