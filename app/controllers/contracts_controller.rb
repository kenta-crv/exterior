class ContractsController < ApplicationController
    before_action :authenticate_admin!, only: [:index, :destroy, :send_mail]

    def index
      @contracts = Contract.order(created_at: "DESC").page(params[:page])
    end
  
    def new
      @contract = Contract.new
    end
  
    def confirm
      @contract = Contract.new(contract_params)
    end
  
    def thanks
      @contract = Contract.new(contract_params)
      @contract.save
      if admin_signed_in?
        ContractMailer.received_email(@contract).deliver # 管理者に通知
        flash[:notice] = "管理者送信のため、取引先にはメールを送らず完了しました。"
      else
        # 一般ユーザーの場合はメール送信を行う
        ContractMailer.received_email(@contract).deliver # 管理者に通知
        ContractMailer.send_email(@contract).deliver # 送信者に通知
      end
    end
  
    def create
      @contract = Contract.new(contract_params)
      @contract.save
      redirect_to thanks_contracts_path
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
      )
    end

    def client_params
      params.require(:client).permit(:email, :password, :password_confirmation)
    end
end
