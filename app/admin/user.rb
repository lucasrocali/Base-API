ActiveAdmin.register User do

permit_params :name, :email, :login_type

filter :created_at


end
