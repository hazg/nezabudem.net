class Message < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  is_private_message
  
  # The :to accessor is used by the scaffolding,
  # uncomment it if using it or you can remove it if not
  attr_accessor :to
  
  def thread_messages
    Message.where("thread = #{self.thread}")
  end

  def read_thread(user)
    !to_user_thread_messages(user).update_all({:read_at => Time.now})
  end
  
  def thread_read?(user)
    !to_user_thread_messages(user).any?
  end
  
  def subject
    if self[:subject].blank?
      truncate(body, :length => 30) 
    else
      self[:subject]
    end
  end
  private
  
  def to_user_thread_messages(user)
    Message.where("thread = #{self.thread} AND read_at IS NULL AND recipient_id = #{user.id}")
  end
  
end
