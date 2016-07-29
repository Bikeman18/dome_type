class User < ApplicationRecord
  alias_attribute :username, :guid
  has_one :user_profile, :dependent => :destroy
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :notifications
  has_many :course_user_ships
  has_many :courses, through: :course_user_ships
  has_many :consults
  has_many :course_user_scores
  has_many :team_user_ships
  mount_uploader :avatar, AvatarUploader
  accepts_nested_attributes_for :user_profile, allow_destroy: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :cas_authenticatable, :rememberable, :trackable, :validatable,
         :timeoutable

  validates :nickname, presence: true, uniqueness: true, length: {in: 2..10}, format: {with: /\A[\u4e00-\u9fa5_a-zA-Z0-9]+\Z/i, message: '昵称只能包含中文、数字、字母、下划线'}
  validates :email, uniqueness: true, allow_blank: true, format: {with: /\A[^@\s]+@[^@\s]+\z/, message: '已被使用'}

  def cas_extra_attributes=(extra_attributes)
    extra_attributes.each do |name, value|
      case name.to_sym
      when :nickname
        self.nickname = value
      when :email
        self.email = value
      when :mobile
        self.mobile = value
      end
    end
  end

  def email_changed?
    false
  end

  def email_required?
    false
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  attr_accessor :login
  attr_accessor :email_info
  attr_accessor :email_code
  attr_accessor :mobile_info
  attr_accessor :return_url
  attr_accessor :password

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(['nickname = :value OR email = :value OR mobile = :value', {:value => login}]).first
    else
      where(conditions).first
    end
  end

  private

end
