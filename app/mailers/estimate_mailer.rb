class EstimateMailer < ActionMailer::Base
  include Rails.application.routes.url_helpers
  default from: "info@exterior-garden.jp"
  def received_email(estimate)
    @estimate = estimate
    mail to: "info@exterior-garden.jp"
    mail(subject: 'エクステリアガーデンにお見積もり依頼がありました') do |format|
      format.text
    end
  end

  def send_email(estimate)
    @estimate = estimate
    mail to: estimate.email
    mail(subject: '自販機現地調査開始のご案内') do |format|
      format.text
    end
  end

  def old_email(estimate)
    @estimate = estimate
    mail to: estimate.email
    mail(subject: '最長5年保証で運営出来る新中古自販機のご案内') do |format|
      format.text
    end
  end

  def share_email(estimate)
    @estimate = estimate
    mail to: estimate.email
    mail(subject: 'ドコモシェアサイクルで副収入と社会貢献！') do |format|
      format.text
    end
  end

  def outside_email(estimate)
    @estimate = estimate
    mail to: estimate.email
    mail(subject: '収益性の高い貸出型自販機のご案内') do |format|
      format.text
    end
  end

  def client_email(estimate,customer_id)
    @estimate = estimate
    mail bcc: Client.all.map{|client| client.email}
    mail(subject: '自販機お見積もり依頼') do |format|
      format.text
    end
  end

  def client_email_select(estimate, client)
    @estimate = estimate
    @client = client
    @accept_link = accept_estimate_url(@estimate, client_id: @client.id)
    @decline_link = decline_estimate_url(@estimate, client_id: @client.id)
    mail(to: client.email, subject: "自販機現地調査依頼【#{@estimate.co}】", content_type: "text/plain; charset=UTF-8", content_transfer_encoding: '7bit') 
  end

  def status_update_email(comment)
    @comment = comment
    mail(to: 'info@exterior-garden.jp', from: comment.client.email, subject: 'ステータス更新通知')
  end

  def client_public_email(estimate, client, comment)
    @estimate = estimate
    @client = client
    @comment = comment
    mail(to: @client.email, subject: "#{client.company}の情報が公開されました。")
  end
  
  def net_accept_email(estimate, client)
    @estimate = estimate
    @client = client
    mail(from: @client.email, to: 'info@exterior-garden.jp', subject: "#{client.company}が案件を受託しました。")
  end

  def net_decline_email(estimate, client)
    @estimate = estimate
    @client = client
    mail(from: @client.email, to: 'info@exterior-garden.jp', subject: "#{client.company}が案件を辞退しました")
  end

  #催促
  def expiration_notification(client, comment, estimate)
    @client = client
    @comment = comment
    @estimate = estimate
    mail(to: @client.email,  subject: "【#{@estimate.co}】現地調査結果を更新してください")
  end
  #契約メール
  def contract_email(estimate, comment, client)
    @estimate = estimate
    @comment = comment
    @client = client
    mail(to: client.email, subject: '【#{@estimate.co}】で契約依頼がありました')
  end
  #競合NGメール
  def conflict_email(estimate, comment, client)
    @estimate = estimate
    @comment = comment
    @client = client
    mail(to: client.email, subject: '【#{@estimate.co}】はご検討の結果落選となりました')
  end
  #見積提示中メール
  def presentation_email(estimate, comment, client)
    @estimate = estimate
    @comment = comment
    @client = client
    mail(to: "info@exterior-garden.jp", from: client.email, subject: '【#{@estimate.co}】#{@client.company}が提案を行いました')
  end

  # ステータスが依頼中の場合の催促メール送信
  def requested_status_remaind(comment, client)
    @comment = comment
    @estimate = comment.estimate
    @client = client
    to = @client.email

    mail(to: to, subject: "#{@estimate.co}様の依頼判断可否について")
  end

  # ステータスが現地調査中の場合の催促メール送信
  def investigated_status_remaind(comment, client)
    @comment = comment
    @estimate = comment.estimate
    @client = client
    to = @client.email

    mail(to: to, subject: "#{@estimate.co}様の現地結果について")
  end

  # ステータスが見積提示中となった場合の通知メール送信
  def estimate_status_notification(comment, client)
    @comment = comment
    @estimate = comment.estimate
    @client = client
    to = @client.email

    mail(to: to, subject: "#{@client.company}より#{@estimate.co}の提案がありました。")
  end

  # ステータスが契約となった場合の通知メール送信
  def contracted_status_notification(comment, client)
    @comment = comment
    @estimate = comment.estimate
    @client = client
    to = @client.email

    mail(to: to, subject: "#{@estimate.co}様の契約のお知らせ")
  end

  # ステータスが見送りNGとなった場合の通知メール送信
  def send_off_status_notification(comment, client)
    @comment = comment
    @estimate = comment.estimate
    @client = client
    to = @client.email

    mail(to: to, subject: "#{@estimate.co}様より見送りのお知らせ")
  end

end
