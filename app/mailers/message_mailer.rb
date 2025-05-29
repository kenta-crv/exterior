class MessageMailer < ActionMailer::Base
  default from: "info@exterior-garden.jp"
  def received_email(message)
    @message = message
    @room = message.room
    if message.is_user
      @send_user_name = @room.user.user_name
      @received_user_name = @room.member.company
    else
      @send_user_name = @room.member.company
      @received_user_name = @room.user_name
    end
    mail to: "info@exterior-garden.jp"
    mail(subject: 'メッセージが送信されました') do |format|
      format.text
    end
  end

  def send_email(message)
    @message = message
    @room = message.room
    if message.is_user
      @send_user_name = @room.user.email
      @received_user_email = @room.member.company
    else
      @send_user_name = @room.member.company
      @received_user_email = @room.user.email
    end
    mail to: @received_user_email
    mail(subject: 'メッセージが届いています') do |format|
      format.text
    end
  end
end
