class ContractMailer < ActionMailer::Base
  default from: "info@exterior-garden.jp"
  def received_email(contract)
    @contract = contract
    mail from: contract.email
    mail to: "info@exterior-garden.jp"
    mail(subject: 'エクステリアガーデンにお問い合わせがありました') do |format|
      format.text
    end
  end

  def send_email(contract)
    @contract = contract
    mail to: contract.email
    mail(subject: 'エクステリアガーデンにお問い合わせ頂きありがとうございます。') do |format|
      format.text
    end
  end

  def contract_received_email(contract)
    @contract = contract
    mail to: "info@exterior-garden.jp"
    mail(subject: 'エクステリアガーデンで契約同意がありました') do |format|
      format.text
    end
  end

  def contract_send_email(contract)
    @contract = contract
    mail to: contract.email
    mail(subject: 'エクステリアガーデンの加盟店契約をいただきありがとうございます。') do |format|
      format.text
    end
  end

  def received_first_email(contract)
    @contract = contract
    @contract_url = "https://ri-plus.jp/contracts/#{contract.id}"
    mail(to: "okuyama@ri-plus.jp", subject: "【#{@contract.company}】契約発行通知")
  end

  def send_first_email(contract)
    @contract = contract
    @contract_url = "https://ri-plus.jp/contracts/#{contract.id}"
    mail(from:"info@exterior-garden.jp", to: @contract.email, subject: "契約締結のご案内")
  end

  def new_advance_notification(advance)
    @advance = advance
    @contract = advance.contract
    @contract_url = "https://ri-plus.jp/contracts/#{@contract.id}"
    mail to: "reply@ri-plus.jp"
    mail(subject: "#{@contract.company}のステータスが#{@advance.status}に更新されました") do |format|
      format.text
    end
  end

end
