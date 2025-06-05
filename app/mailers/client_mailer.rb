class ClientMailer < ActionMailer::Base
  default from: "info@exterior-garden.jp"
  def received_email(client)
    @client = client
    mail from: client.email
    mail to: "info@exterior-garden.jp"
    mail(subject: 'エクステリアガーデンにお問い合わせがありました') do |format|
      format.text
    end
  end

  def send_email(client)
    @client = client
    mail to: client.email
    mail(subject: 'エクステリアガーデンにお問い合わせ頂きありがとうございます。') do |format|
      format.text
    end
  end

  def client_received_email(client)
    @client = client
    mail to: "info@exterior-garden.jp"
    mail(subject: 'エクステリアガーデンで契約同意がありました') do |format|
      format.text
    end
  end

  def client_send_email(client)
    @client = client
    mail to: client.email
    mail(subject: 'エクステリアガーデンの加盟店契約をいただきありがとうございます。') do |format|
      format.text
    end
  end

  def received_first_email(client)
    @client = client
    @client_url = "https://ri-plus.jp/clients/#{client.id}"
    mail(to: "okuyama@ri-plus.jp", subject: "【#{@client.company}】契約発行通知")
  end

  def send_first_email(client)
    @client = client
    @client_url = "https://ri-plus.jp/clients/#{client.id}"
    mail(from:"info@exterior-garden.jp", to: @client.email, subject: "契約締結のご案内")
  end

  def new_advance_notification(advance)
    @advance = advance
    @client = advance.client
    @client_url = "https://ri-plus.jp/clients/#{@client.id}"
    mail to: "reply@ri-plus.jp"
    mail(subject: "#{@client.company}のステータスが#{@advance.status}に更新されました") do |format|
      format.text
    end
  end

end
