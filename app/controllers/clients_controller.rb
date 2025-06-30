class ClientsController < ApplicationController
  #before_action :check_client
  def index
    @clients = Client.all
  end

  def show
    @client = Client.find(params[:id])
    #@estimates = current_client.estimates
  end

  def disclose
    @client = Client.find(params[:id])
    @client.update(disclosure_clicked_at: Time.current)
    # 開示された案件情報を表示するためのロジック
    redirect_to client_path(@client)
  end

  def info
    @client = Client.find(params[:id])  # 例：params[:id]から取得している想定
  end

  #def new
   # @client = Client.new
  #end

  def edit
    @client = Client.find(params[:id])
  end

  #def update
  #  @client = Client.find(params[:id])
  #  if @client.update(client_params)
  #    redirect_to @client, notice: 'クライアント情報が更新されました。'
  #  else
  #    render :edit
  #  end
  #end

  def update
    @client = Client.find(params[:id])
  
    if @client.update(client_params)
      # conclusion.html.slimからの送信で、かつ同意が得られた場合
      if @client.agree == "同意しました"
          # メール送信処理
          ClientMailer.contract_received_email(@client).deliver_now
          ClientMailer.contract_send_email(@client).deliver_now
          flash[:notice] = "契約が完了しました"
          redirect_to client_path(@client)
        # edit.html.slimからの送信、またはconclusion.html.slimからの送信でも同意が得られなかった場合
      else
        redirect_to client_path(@client)
      end
    else
      # 更新が失敗した場合の処理
      render :edit
    end
  end

  def conclusion
    @client = Client.find(params[:id])
    today = Date.today.strftime("%Y-%m-%d")
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to clients_url, notice: 'クライアントが削除されました。'
  end

  def send_mail
    @client = Client.find(params[:id])
    ClientMailer.received_first_email(@client).deliver_now
    ClientMailer.send_first_email(@client).deliver_now
    redirect_to info_client_path(@client), notice: "#{@client.company}へ契約依頼のメール送信を行いました。"
  end

  def send_mail_start
    @client = Client.find(params[:id])
    ClientMailer.received_start_email(@client).deliver_now
    ClientMailer.send_start_email(@client).deliver_now
    redirect_to info_client_path(@client), notice: "#{@client.company}へ開始日のメール送信を行いました。"
  end

  private
  def client_params
    params.require(:client).permit(
      :company,                     # 会社名
      :representative_name,
      :representative_kana,
      :contact_name,
      :contact_kana,
      :tel,                         # 携帯番号
      :address,                     # 所在地
      :url,                         # 会社URL
      :area,                        # 対応可能エリア
      
      # ヒアリングフォーム
      :question_area,              # 「はい」「いいえ」 ラジオボタン
      :question_price,             # 「はい」「いいえ」 ラジオボタン
      :question_tax,               # 「問題ありません」 チェックボックス
      :question_responce,          # 「問題ありません」 チェックボックス
      :question_contract,          # 「問題ありません」 チェックボックス（または text にするなら変更）
      :question_picture,           # 「はい」「いいえ」 ラジオボタン
      :question_appeal,            # アピールテキスト（50文字以上）
      :post_title,
      :agree,
      :contract_date,

      :agree_1,
      :agree_2,
      :agree_3,
      :agree_4,
      :agree_5,
      :agree_6,
      :agree_7,
      :agree_8,
      :agree_9,

      :face,
      :logo,
      :before_1,
      :after_1,
      :before_2,
      :after_2,
      :before_3,
      :after_3,
      :other_1,
      :other_2,
      :other_3,
      )
  end
end