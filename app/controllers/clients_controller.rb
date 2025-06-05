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

  #def new
   # @client = Client.new
  #end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      redirect_to @client, notice: 'クライアント情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to clients_url, notice: 'クライアントが削除されました。'
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
      )
  end
end