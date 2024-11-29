module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type.to_sym
    when :notice
      "alert-info"
    when :success
      "alert-success"
    when :error, :alert
      "alert-danger"
    else
      "alert-warning"
    end
  end
end
