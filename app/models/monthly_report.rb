class MonthlyReport < ActiveRecord::Base

  BACKUP_STATES = %w(Terminé Incomplet Échec)
  HARD_DRIVE_STATES = %w(Ok Détérioré HS)

  belongs_to :server_asset
  has_one :client, through: :server_asset
  has_many :disks, through: :server_asset

  accepts_nested_attributes_for :server_asset

  validates_presence_of :server_asset
  validates_presence_of :date

  after_initialize do
    self.date ||= Time.zone.today unless persisted?
  end

  mount_uploader :pdf, PDFUploader

  delegate :id, :name, :email, to: :client, prefix: true
  delegate :name, to: :server_asset, prefix: true

  def display_name
    I18n.l date, format: '%B %Y'
  end

  def full_name
    [client_name, server_asset_name, display_name].join('-')
  end

  # @return [MonthlyReportPDF]
  def to_pdf
    pdf = MonthlyReportPDF.new self

    pdf.background
    pdf.cartouche
    pdf.backup
    pdf.restore
    pdf.disks
    pdf.antivirus
    pdf.notes

    pdf
  end

  def save_pdf
    # generate the pdf file
    path = Rails.root + "tmp/#{full_name}.pdf"
    to_pdf.save_as path

    # attach the file to the pdf uploader
    file = File.new path
    self.pdf = file
    save

    # remove the tmp file as it should be saved in the uploader now
    path.unlink
  end

  def additional_recipients
    []
  end

  def recipients
    additional_recipients << client_email
  end
end
