module ServerAssetHelper

  def server_memory(server)
    "#{server.quantity} Go" if server.quantity
  end

end
