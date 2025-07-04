# frozen_string_literal: true

class Clients::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def create
    @client = Client.new(sign_up_params)
    if @client.save
      ClientMailer.received_email(@client).deliver
      ClientMailer.send_email(@client).deliver unless admin_signed_in?
      redirect_to client_path(id: @client.id), notice: '登録が完了しました。担当者より内容を確認しLINEにてご連絡致します。'
    else
      render 'clients/registrations/new'
    end
  end

  protected

  def after_sign_up_path_for(resource)
    client_path(id: resource.id)  # ✅ ここでリダイレクトを制御
  end

  # アカウント更新後のリダイレクト先
  def after_update_path_for(resource)
    "/clients/#{current_client.id}"  
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:company, :name, :tel, :representative_name, :representative_kana, :contact_name, :contact_kana, :address, :url, :area, :email, :question_area, :question_price, :question_tax, :question_responce, :question_contract, :question_picture, :question_appeal, :post_title, :agree, :contract_date, :agree_1, :agree_2, :agree_3, :agree_4, :agree_5, :agree_6, :agree_7, :agree_8, :agree_9, :face, :logo, :before_1, :after_1,  :before_2, :after_2, :before_3, :after_3,  :other_1, :other_2, :other_3,])
    devise_parameter_sanitizer.permit(:account_update, keys: [:company, :name, :tel, :representative_name, :representative_kana, :contact_name, :contact_kana, :address, :url, :area, :email, :question_area, :question_price, :question_tax, :question_responce, :question_contract, :question_picture, :question_appeal, :post_title, :agree, :contract_date, :agree_1, :agree_2, :agree_3, :agree_4, :agree_5, :agree_6, :agree_7, :agree_8, :agree_9, :face, :logo, :before_1, :after_1,  :before_2, :after_2, :before_3, :after_3,  :other_1, :other_2, :other_3,])
  end  # GET /resource/sign_up
  # def new
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
