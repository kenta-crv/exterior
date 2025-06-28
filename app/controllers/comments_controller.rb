class CommentsController < ApplicationController
  before_action :check_admin, except: [:edit, :update]
  before_action :check_client, only: [:edit, :update]
  before_action :load_estimate
  before_action :load_comment, only: [:edit,:update,:show,:destroy]
  #before_action :authenticate_user!

  def load_estimate
    @estimate = Estimate.find(params[:estimate_id])
    @comment = Comment.new
  end

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def edit
    @estimate = Estimate.find(params[:estimate_id])
    @client_comment = ClientComment.find(params[:id])
    # adminユーザーであれば、@clientは設定しない
    if admin_signed_in?
      # admin用の処理（必要に応じて）
    else
      # clientユーザーであれば、@clientを設定（params[:client_id]が無ければ @client_comment.client から取得）
      @client = if params[:client_id].present?
                  Client.find(params[:client_id])
                else
                  @client_comment.client
                end
    end
  end

  def create
    @comment = @estimate.build_comment(comment_params)
    if @comment.save
      redirect_to estimate_path(@estimate)
    else
      render 'new'
    end
  end
  
  def destroy
    @comment = @estimate.comment
    @comment.destroy
    redirect_to estimate_path(@estimate)
  end
  
  def update
    @comment = @estimate.comment
    if admin_signed_in?
     if @comment.update(comment_params)
      send_status_change_notifications
      redirect_to estimate_path(@estimate)
     else
      render 'edit'
     end
    elsif client_signed_in?
      if @comment.update(comment_params)
        send_status_change_notifications
        flash[:notice] = "案件提案が完了しました"
        redirect_to root_path
       else
        render 'edit'
       end
    end
  end

  def update_status
    estimate = Estimate.find(params[:id])
    client = Client.find(params[:client_id])
    comment = Comment.find_or_initialize_by(estimate_id: estimate.id)

    # ステータスを更新する条件に基づいたロジック（例：params[:status_type]）
    case params[:status_type]
    when "contract"
      update_comment_status(client.company, "契約", comment)
    when "presentation"
      update_comment_status(client.company, "見積提示中", comment)
    when "conflict"
      update_comment_status(client.company, "提示NG", comment)
    end
  end

  private

  def update_comment_status(client, status, comment)
    comment.net_info ||= {}
  
    client_id_str = client.id.to_s
  
    comment.net_info[client_id_str] ||= {
      company: client.company,
      email: client.email
    }
  
    comment.net_info[client_id_str]["net"] = status
    comment.save
  end
  #削除
  def valid_status_change?(comment, new_status)
    valid_statuses = ['見積提示', '提示NG']
    valid_statuses.include?(new_status)
  end
  #削除
  def send_status_update_email(comment)
    EstimateMailer.status_update_email(comment).deliver_now
  end

 	def comment_params
 		params.require(:comment).permit(
 		#:asahi,
    #:cocacola,
    #:dydo,
    #:itoen,
    #:kirin,
    #:otsuka,
    #:suntory,
    #:yamakyu,
    #:neos, #sute-t
    :net, #ステータス
    :net_info,
    #:neos_suggestion,
    :body,
    :neos_file,
    :neos_remarks,
    :inspection_start_date,
    :status, 
    :status_info, 
    :file, 

    :remarks, 
    #:yamakyu_suggestion,
    #:yamakyu_file,
    #:yamakyu_remarks,
    #:dydo_suggestion,
    #:dydo_file,
    #:dydo_remarks,
    )
 	end

  # ステータス変更に応じたメール通知
  def send_status_change_notifications
    # メール送信対象となる変更カラム
    fields = ['cocacola', 'neos', 'itoen', 'asahi', 'dydo', 'yamakyu', 'body']

    fields.each do |field|
      # カラムが更新されたかどうか
      field_updated = @comment.saved_change_to_attribute?(field)
      # メールチェックボックスがチェックされたか
      mail_checked = params["#{field}_mail"].present?

      if field_updated && mail_checked
        @comment.send_change_status_notifications(field)
      end
    end
  end

end
