# encoding: utf-8
class UserNotify < ActionMailer::Base
  default from: "info@nezabudem.net"
  
  def new_private_message(message)
    @message = message
    mail({:to => message.recipient.email, :subject => 'Новое личное сообщение на Nezabudem.net'})
  end
  
  def new_comment(comment)
    @comment      = comment
    @target       = comment.commentable
    @comment_url  = polymorphic_path( @target, :only_path => false )
    if not @target.user.blank?
      @target_name  = @target.class.model_name.human
      mail({:to => @target.user.email, :subject => "#{@target_name} комментируется"})
    end
  end

end
