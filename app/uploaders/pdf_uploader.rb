class PDFUploader < CarrierWave::Uploader::Base

  if Rails.env.production?
    include Cloudinary::CarrierWave
  end

  def extension_white_list
    %w(pdf)
  end

  def public_id
    [
      model.client_name,
      model.client_id,
      model.server_asset_name,
      model.server_asset_id,
      model.display_name
    ].join('-')
  end
end
