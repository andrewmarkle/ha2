class RegistrationsController < Devise::RegistrationsController
  # layout Proc.new { |controller| controller.user_signed_in? ? "application" : "no_nav" }
end
