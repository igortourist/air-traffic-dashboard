class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable,
  # :recoverable, :registerable and :omniauthable
  devise :database_authenticatable, :rememberable,
         :trackable, :validatable

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
