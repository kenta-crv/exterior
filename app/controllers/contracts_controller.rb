class ContractsController < ApplicationController
    before_action :authenticate_admin!, only: [:index, :destroy, :send_mail]

    def new
      @contract = Contract.new
      @contract.client_id = params[:client_id]
    end
    
    def create
      @contract = Contract.new(contract_params)
    
      if @contract.save
        # 管理者・一般ユーザーでメール送信を分ける
        ContractMailer.received_email(@contract).deliver
        ContractMailer.send_email(@contract).deliver unless admin_signed_in?
    
        # client.id が存在する場合（紐づけ済み）、そのマイページへ
        if @contract.client
          redirect_to client_path(@contract.client), notice: "企業登録が完了しました。審査完了後ご連絡致します。"
        else
          redirect_to root_path, notice: "企業登録が完了しました"
        end
      else
        render :new
      end
    end
  
    def confirm
      @contract = Contract.new(contract_params)
    end
  
    def show
      @contract = Contract.find(params[:id])
      @comment = Comment.new
    end
  
    def edit
      @contract = Contract.find(params[:id])
    end

    def info
      @contract = Contract.find(params[:id])
      Rails.logger.debug "Contract ID: #{params[:id]}"
      Rails.logger.debug "Contract Loaded: #{@contract.inspect}"
    end

    def payment
      @contract = Contract.find(params[:id])
    end

    def conclusion
      @contract = Contract.find(params[:id])
      today = Date.today.strftime("%Y-%m-%d")
    end

def register
  @contract = Contract.find(params[:id])

  if request.post?
    @client = Client.new(client_params)
    @client.contract = @contract

    # email 重複チェック
    if Client.exists?(email: @client.email)
      @client.errors.add(:email, "はすでに使用されています。")
      render :register
      return
    end

    # Save the client and handle failure more clearly
    if @client.save
      redirect_to info_contract_path(@contract), notice: "ログイン情報が登録されました"
    else
      # Inspect the errors
      puts @client.errors.full_messages
      render :register
    end
  else
    @client = Client.new(email: @contract.email) # Contractのemailをデフォルトで設定
  end
end

    def destroy
      @contract = Contract.find(params[:id])
      @contract.destroy
      redirect_to contracts_path, alert:"削除しました"
    end
  
    def update
      @contract = Contract.find(params[:id])
    
      if @contract.update(contract_params)
        # conclusion.html.slimからの送信で、かつ同意が得られた場合
        if @contract.agree == "同意しました"
            # メール送信処理
            ContractMailer.contract_received_email(@contract).deliver_now
            ContractMailer.contract_send_email(@contract).deliver_now
            flash[:notice] = "契約が完了しました"
            redirect_to info_contract_path(@contract)
          # edit.html.slimからの送信、またはconclusion.html.slimからの送信でも同意が得られなかった場合
        else
          redirect_to info_contract_path(@contract)
        end
      else
        # 更新が失敗した場合の処理
        render :edit
      end
    end
  
    def send_mail
      @contract = Contract.find(params[:id])
      ContractMailer.received_first_email(@contract).deliver_now
      ContractMailer.send_first_email(@contract).deliver_now
      redirect_to info_contract_path(@contract), notice: "#{@contract.company}へ契約依頼のメール送信を行いました。"
    end

    def send_mail_start
      @contract = Contract.find(params[:id])
      ContractMailer.received_start_email(@contract).deliver_now
      ContractMailer.send_start_email(@contract).deliver_now
      redirect_to info_contract_path(@contract), notice: "#{@contract.company}へ開始日のメール送信を行いました。"
    end

    private
    def contract_params
      params.require(:contract).permit(
      #問い合わせ項目
      :company, #会社名
      :name, #担当者
      :tel, #電話番号
      :email, #メールアドレス
      :address, #所在地
      :period, #導入時期
      :area, #導入エリア
      :message, #備考
      #契約情報
      :president_name, #代表取締役
      :agree, #契約同意
      :post_title, #代表取締役
      :contract_date, #契約日
      :client_id
      )
    end
end
