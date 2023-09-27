class AsConseilAuthorization < ActiveAdmin::AuthorizationAdapter

  def authorized?(action, subject = nil)
    return true if user.username == "crux"
    return true if (ENV["SUPER_ADMINS"] || []).split(',').include? user.username
    return true if action == :read

    case subject
    when normalized(MaintenanceTicket)
      return true
    when normalized(MonthlyReport)
      return true
    when normalized(PhoneAsset)
      (ENV["PHONE_ADMINS"] || []).split(',').include? user.username
    else
      ![:update, :create, :destroy].include?(action)
    end
  end

end
