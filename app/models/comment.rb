class Comment < ApplicationRecord
  belongs_to :estimate

  # ステータス変更を検知するためのコールバック
  #after_save :send_email_notifications, if: :status_changed?

  # 催促メール対象取得の取得(ステータス:依頼中)
  # 引数：days_ago(何日前のデータを取得するか)
  scope :requested_remind_email_target, ->(days_ago) {
    target_date = days_ago.days.ago.to_date
    where(asahi: '依頼中', created_at: target_date.beginning_of_day..target_date.end_of_day)
      .or(Comment.where(cocacola: '依頼中', created_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(itoen: '依頼中', created_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(dydo: '依頼中', created_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(yamakyu: '依頼中', created_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(neos: '依頼中', created_at: target_date.beginning_of_day..target_date.end_of_day))
  }

  # 催促メール対象取得の取得(ステータス:現地調査中)
  # 引数：days_ago(何日前のデータを取得するか)
  scope :investigated_remind_email_target, ->(days_ago) {
    target_date = days_ago.days.ago.to_date
    where(asahi: '現地調査中', updated_at: target_date.beginning_of_day..target_date.end_of_day)
      .or(Comment.where(cocacola: '現地調査中', updated_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(itoen: '現地調査中', updated_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(dydo: '現地調査中', updated_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(yamakyu: '現地調査中', updated_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(neos: '現地調査中', updated_at: target_date.beginning_of_day..target_date.end_of_day))
  }

  # ステータス変更に応じたメール通知
  def send_change_status_notifications(changed_column)
    # 先にClientを取得
    clients = Client.where(company: Comment::STATUS_TO_CLIENT.values.flatten).index_by(&:company)

    # 引数で受け取ったカラムの現在のステータス
    status = send(changed_column)

    # 対応するclientに対してメール送信
    Comment::STATUS_TO_CLIENT[changed_column].each do |company|
      client = clients[company]
      if client.present?
        EstimateMailer.estimate_status_notification(self, client).deliver_now if status == '見積提示中'
        EstimateMailer.contracted_status_notification(self, client).deliver_now if status == '契約'
        EstimateMailer.send_off_status_notification(self, client).deliver_now if status == '見送りNG'
      end
    end
  end

  private

  #def status_changed?
  #  cocacola_changed? || neos_changed? || itoen_changed? || asahi_changed? || dydo_changed? || yamakyu_changed? || body_changed?
  #end

  def send_email_notifications
    client = estimate.client
    if body == '契約'
      send_contract_email(client)
    elsif body == '見送りNG'
      send_conflict_email(client)
    elsif body == '見積提示中'
      send_presentation_email(client)
    end
    # ...[他の条件]...
  end

  def send_contract_email(client)
    EstimateMailer.contract_email(estimate, self, client).deliver_now
  end

  def send_conflict_email(client)
    EstimateMailer.conflict_email(estimate, self, client).deliver_now
  end

  def send_presentation_email(client)
    EstimateMailer.presentation_email(estimate, self, client).deliver_now
  end

end
