class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and 
  before_create :build_defaults
  
  def messages
    Message
      .where("(sender_id = #{id} AND sender_deleted < 1) OR (recipient_id = #{id} AND recipient_deleted < 1)")
      .order("created_at DESC")

  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :roles
  has_one :avatar, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_many :places
  has_many :soldiers
  has_many :place_photos
  has_many :comments
  has_private_messages


  #validates_uniqueness_of :nick
  #validates :nick, :format => { :with => /[\w\W\d()\-_.]{3,}+/, 
  #  :maximum => 12, :minimum => 3,
    # :message => I18n.t('user.nick.valid_hint') }  
  
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :nick, :roles, :provider, :url
  attr_accessible :provider, :uid#, :nickname 

  def soldiers
    Soldier.where(:user_id => self.id)
  end

  def place_photos
    PlacePhoto.where(:user_id => self.id)
  end

  def build_defaults
    self.create_profile
    self.create_avatar
    self.roles << Role.find_by_name('user')
  end
  
  def admin?
    role? :admin
  end
  
  def forum_avatar
    self.avatar.photo.forum
  end

  def to_s
    nick
  end

  def role?(*role_names)
    self.roles.where(:name => role_names).present?
  end
=begin
  def self.find_for_facebook_oauth access_token
    if user = User.where(:url => access_token.info.urls.Facebook).first
      user
    else 
      User.create!(:provider => access_token.provider, :url => access_token.info.urls.Facebook, :username => access_token.extra.raw_info.name, :nickname => access_token.extra.raw_info.username, :email => access_token.extra.raw_info.email, :password => Devise.friendly_token[0,20]) 
    end
  end
=end
  def self.find_for_vkontakte_oauth access_token
    #if user = User.where(:uid => access_token.info.urls.Vkontakte).first
    #  user
    #else
    logger.debug "**********#{access_token}"
    User.create_or_create_by_uid :provider => access_token.provider,
      :uid => access_token.info.urls.Vkontakte,
      :nick => access_token.info.name,
      #:nickname => access_token.extra.raw_info.domain,
      :email => access_token.extra.raw_info.domain+'@vk.com',
      :password => Devise.friendly_token[0,20] 
  end
end

