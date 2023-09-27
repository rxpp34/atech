#= require active_admin/base
#= require select2/select2.min
#= require active_admin_select2/active_admin_select2
#= require jquery-ui/ui/i18n/datepicker-fr

$ ->
  $('#maintenance_ticket_assigned_to').select2
    width: '400px'
