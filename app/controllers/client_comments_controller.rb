class ClientCommentsController < ApplicationController
  before_action :set_client_comment

  def edit
    @estimate = Estimate.find(params[:estimate_id])
    @client = Client.find(params[:client_id])
    @client_comment = ClientComment.find_or_initialize_by(estimate_id: @estimate.id, client_id: @client.id)
  end
  
  def update
    @estimate = Estimate.find(params[:estimate_id])
    @client = Client.find(params[:client_id])
    @client_comment = ClientComment.find_or_create_by(estimate_id: @estimate.id, client_id: @client.id)
    if @client_comment.update(client_comment_params)
      EstimateMailer.estimate_status_notification(@client_comment, @client).deliver_now
      flash[:notice] = "案件提案が完了しました"
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def set_client_comment
    @client_comment = ClientComment.find_or_initialize_by(
      estimate_id: params[:estimate_id],
      client_id: params[:client_id]
    )
  end

  def client_comment_params
    params.require(:client_comment).permit(:status, :file, :remarks)
  end
end
