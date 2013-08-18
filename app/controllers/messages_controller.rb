# @encoding: utf-8
class MessagesController < ApplicationController
  
  before_filter :set_user
  
  def index
      @messages = @user.messages.group(:thread)
  end
  
  def show
    @message = Message.find(params[:id])
    @message.read_thread(current_user)
    expire_action(:action => 'index')
    @messages = Message.where({:thread => @message.thread}).order('created_at DESC')
    @reply_message = Message.new({
      :to => ((@message.sender.id == current_user.id) ? @message.recipient.id : @message.sender.id),
      :thread => @message.thread,
      :sender_id => current_user
    })

    add_breadcrumb @message.subject, message_path( @message )
  end
  
  def new
    
    @message = Message.new({:to => params[:to]})

    if params[:reply_to]
      @reply_to = @user.messages.find(params[:reply_to])
      unless @reply_to.nil?
        #TODO: WTF???
        @message.to = ((@reply_to.sender.id == current_user.id) ? @reply_to.recipient.id : @reply_to.sender.id)
        @message.thread = @reply_to.thread
        #@message.subject = "Re: #{@reply_to.subject}"
        
        #@message.body = "\n\n> #{@reply_to.sender.nick} пишет:\n ------- \n#{@reply_to.body}\n-------"
      end
    else
      last_thread = Message.maximum(:thread)
      last_thread = 0 if last_thread.blank?

      @message.thread = last_thread + 1
    end
  end
  
  def create
    @message = Message.new(params[:message])
    @message.sender = @user
    @message.recipient = User.find(params[:message][:to])

    if @message.save!
      UserNotify.new_private_message(@message).deliver
      flash[:notice] = "Сообщение отправлено"
      redirect_to messages_path(@message)
    else
      render :action => :new
    end
  end
  
  def delete_selected
    if request.post?
      if params[:delete]
        params[:delete].each { |id|
          thread = Message.find(id).thread
          @messages = Message.where("messages.thread = #{thread} AND (sender_id = #{@user.id} OR recipient_id = #{@user.id})")
          @messages.each do |message|
            message.mark_deleted(@user) unless message.nil?
          end
        }
        flash[:notice] = "Сообщения удалены"
      end
      redirect_to :back
    end
  end
  
  private
    def set_user
      @user = current_user
      @profile = current_user.profile
      add_breadcrumb current_user.nick, profile_path( current_user.profile )
      add_breadcrumb 'Личные сообщения', messages_path
    end
end
