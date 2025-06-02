class EstimatesController < ApplicationController
  before_action :check_admin, except: [:decline, :accept, :update_status, :new, :confirm, :thanks]
  before_action :check_client, only: [:decline, :accept, :update_status]
  add_breadcrumb "フォーム入力ページ", :new_estimate_path, only: [:confirm]
  def index
    @q = Estimate.ransack(params[:q])
    @estimates = @q.result.order(created_at: :desc)
    @estimates_for_view = @estimates.page(params[:page]).per(100)
    
    respond_to do |format|
      format.html
      format.csv do
        send_data @estimates.generate_csv, filename: "estimates-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"
      end
    end
  end

  def new
    @estimate = Estimate.new
  end

  def confirm
    @estimate = Estimate.new(estimate_params)
    add_breadcrumb "入力内容確認"
    if @estimate.valid?
      render :action =>  'confirm'
    else
      render :action => 'new'
    end
  end

  def thanks
    @estimate = Estimate.new(estimate_params)
    @estimate.save
    EstimateMailer.received_email(@estimate).deliver # 管理者に通知
    EstimateMailer.send_email(@estimate).deliver # 送信者に通知
  end

  def contract
    @estimates = Estimate.joins(:comment).where.not(sales_price: nil).where("comments.cocacola = ? OR comments.asahi = ? OR comments.itoen = ? OR comments.dydo = ? OR comments.yamakyu = ? OR comments.neos = ?", "契約", "契約", "契約", "契約", "契約", "契約")
  end

  def create
    @estimate = Estimate.new(estimate_params)
    @estimate.save
    redirect_to thanks_estimates_path
  end

  def show
    @estimate = Estimate.find_by(id: params[:id])
  
    if @estimate.nil?
      redirect_to estimates_path, alert: "指定された見積もりは見つかりませんでした。"
      return
    end
  
    if admin_signed_in?
      # 管理者の場合、制限なしにアクセス許可
    elsif admin_signed_in? && !@estimate.accepted_by_client?
      # クライアントユーザーで案件が承諾されていない場合
      redirect_to root_path, alert: 'この案件にはアクセスできません。'
      return
    end
  
    # 必要なインスタンス変数の設定
    @comment = @estimate.comment || Comment.new
    @progress = Progress.new
    @payment = Payment.new
  end


  def edit
    @estimate = Estimate.find(params[:id])
  end

  def select_sent
    @client = Client.all
    render "selectcomp"
  end

  def destroy
    @estimate = Estimate.find(params[:id])
    @estimate.destroy
    redirect_to estimates_path, alert:"削除しました"
  end

  def update
    @estimate = Estimate.find(params[:id])
    if @estimate.update(estimate_params)
      redirect_to estimates_path(@estimate), alert: "更新しました"
    else
      render 'edit'
    end
  end

  def send_mail
    @estimate = Estimate.find(params[:id])
    @estimate.update(send_mail_flag: true)
    EstimateMailer.client_email(@estimate).deliver # 全企業に送信
    redirect_to estimate_path(@estimate), alert: "送信しました"
  end

  def send_mail_cfsl
    @estimate = Estimate.find(params[:id])
    @comment = Comment.find_or_initialize_by(estimate_id: params[:id])
  
    # クライアントIDを処理
    params[:clients].each do |_key, client_ids|
      client_ids.each do |client_id|
        next if client_id.blank?
  
        client = Client.find(client_id)

        # メール送信
        EstimateMailer.client_email_select(@estimate, client).deliver_now
  
        # コメントの更新
        case client.company
        when "アサヒ飲料株式会社 中部支社", "アサヒ飲料株式会社 関西支社", "アサヒ飲料株式会社"
          @comment.update(asahi: "依頼中")
        when "コカ･コーラボトラーズジャパン株式会社"
          @comment.update(cocacola: "依頼中")
        when "株式会社伊藤園"
          @comment.update(itoen: "依頼中")
        when "ダイドードリンコ株式会社"
          @comment.update(dydo: "依頼中")
        when "合同会社ファクトル"
          @comment.update(yamakyu: "依頼中")
        when "ネオス株式会社"
          @comment.update(neos: "依頼中")
        when "合同会社ファクトル"
          @comment.update(body: "依頼中")
        end
      end
    end
    redirect_to estimates_path, alert: "#{@estimate.co}が指定した企業へ送信しました。"
  end

  def accept
    estimate = Estimate.find(params[:id])
    client = Client.find(params[:client_id])
    comment = Comment.find_or_initialize_by(estimate_id: estimate.id)
    # 現地調査開始日を更新
    comment.inspection_start_date = Date.today

    case client.company
    when "アサヒ飲料株式会社 中部支社", "アサヒ飲料株式会社 関西支社", "アサヒ飲料株式会社"
      comment.update(asahi: "現地調査中")
    when "コカ･コーラボトラーズジャパン株式会社"
      comment.update(cocacola: "現地調査中")
    when "株式会社伊藤園"
      comment.update(itoen: "現地調査中")
    when "ダイドードリンコ株式会社"
      comment.update(dydo: "現地調査中")
    when "合同会社ファクトル"
      comment.update(yamakyu: "現地調査中")
    when "ネオス株式会社"
      comment.update(neos: "現地調査中")
    when "合同会社ファクトル"
      comment.update(body: "現地調査中")
    end
    EstimateMailer.client_public_email(estimate, client, comment).deliver_now
    EstimateMailer.net_accept_email(estimate, client).deliver_now
    flash[:notice] = "案件詳細メールを送信しました。"
    redirect_to root_path
  end
  
  def decline
    estimate = Estimate.find(params[:id])
    client = Client.find(params[:client_id])
    comment = Comment.find_or_initialize_by(estimate_id: estimate.id)
    case client.company
    when "アサヒ飲料株式会社 中部支社", "アサヒ飲料株式会社 関西支社", "アサヒ飲料株式会社"
      comment.update(asahi: "設置NG")
    when "コカ･コーラボトラーズジャパン株式会社"
      comment.update(cocacola: "設置NG")
    when "株式会社伊藤園"
      comment.update(itoen: "設置NG")
    when "ダイドードリンコ株式会社"
      comment.update(dydo: "設置NG")
    when "合同会社ファクトル"
      comment.update(yamakyu: "設置NG")
    when "ネオス株式会社"
      comment.update(neos: "設置NG")
    when "合同会社ファクトル"
      comment.update(body: "設置NG")
    end
    EstimateMailer.net_decline_email(estimate, client).deliver_now
    flash[:notice] = "案件を辞退しました。"
    redirect_to root_path
  end

  def recruit
    @estimates = Estimate.order(created_at: "DESC").where(send_mail_flag: "送信済").page(params[:page])
  end

  def manufacturer
    @q = Estimate.with_specific_comments.ransack(params[:q])
    @estimates_for_view = @q.result(distinct: true).page(params[:page]).per(100).order(created_at: :desc)
  end

  def info
    @clients = Client.all
  end

  def import
    cnt = Estimate.import(params[:file])
    redirect_to estimates_url, notice:"#{cnt}件登録されました。"
  end

  private
  def estimate_params
    params.require(:estimate).permit(
      :co, #会社名
      :name,  #名前
      :tel, #電話番号
      :postnumber, #郵便番号
      :address, #施工先住所
      :email, #メールアドレス
      :which_one, #新築or改築
      :square_meter, #平米
      :schedule, #施工予定月
      :bring, #既に他社で見積もりや図面を取得しているか？
      :importance, #施工決定における重要点
      :period, #いつまでに決めたいか
      :remarks, #要望
    )
  end
end
