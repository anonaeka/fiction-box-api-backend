# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  auth_token             :string
#  bio                    :text
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  image_url              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_auth_token            (auth_token)
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :fictions, dependent: :destroy

  before_create :generate_auth_token

  def generate_auth_token
    self.auth_token = SecureRandom.uuid
  end

  def jwt(exp=10.days.from_now)
    JWT.encode({ auth_token: self.auth_token, exp: exp.to_i }, Rails.application.secret_key_base, "HS256")
  end

  def as_json_with_jwt
    json = {}
    json[:email] = self.email
    json[:username] = self.username
    json[:auth_jwt] = self.jwt
    json
  end

  def as_profile_json
    json = {}
    json[:email] = self.email
    json[:username] = self.username
    json[:bio] = self.bio
    json[:image_url] = self.image_url
    json
  end
end
