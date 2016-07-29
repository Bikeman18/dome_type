class OurCasSessionsController < Devise::CasSessionsController
#    skip_before_action :redirect_to_sign_in,
#    only: [:new, :destroy, :single_sign_out,
#           :service, :unregistered]
   skip_before_action :verify_signed_out_user 
end