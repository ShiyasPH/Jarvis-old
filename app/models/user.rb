# == Schema Information
#
# Table name: users
#
#  id                  :bigint(8)        not null, primary key
#  email               :string           default(""), not null
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :inet
#  last_sign_in_ip     :inet
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  provider            :string
#  uid                 :string
#  token               :string
#  expires_at          :integer
#  expires             :boolean
#  refresh_token       :string
#  name                :string
#  avatar              :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :omniauthable, :rememberable, :trackable, :omniauth_providers => [:google_oauth2]

  validates :email, presence: true
  validates :provider, presence: true
  validates :uid, presence: true

  def self.from_omniauth(auth)
    # Sample `auth`:
    #
    # {
    #   'provider' => 'google_oauth2',
    #   'uid' => '111466905322301202620',
    #   'info' => {
    #     'name' => 'BV Satyaram',
    #     'email' => 'bv@codeastra.com',
    #     'first_name' => 'BV',
    #     'last_name' => 'Satyaram',
    #     'image' => 'https://lh3.googleusercontent.com/-st5fck7RZVM/AAAAAAAAAAI/AAAAAAAAABo/A0O8fpk-3h8/photo.jpg',
    #     'urls' => {
    #       'google' => 'https://plus.google.com/111466905322301202620'
    #     }
    #   },
    #   'credentials' => {
    #     'token' =>
    #     'ya29.GlvBBiwxBsu2E-wS3YHcJ9s8MAw8-TDX7PgV_2QB5ioMEJ8cvjhW386BFK_Xx-h8rE706pVgyH2K8Qakujicun8kLX-y_jvyOToPcYD8we8XTlkwy4VustYYpXSK',
    #     'expires_at' => 1 _551_582_647,
    #     'expires' => true
    #   },
    #   'extra' => {
    #     'id_token' =>
    #     'eyJhbGciOiJSUzI1NiIsImtpZCI6ImYyNGQ2YTE5MzA2NjljYjc1ZjE5NzBkOGI3NTRhYTE5M2YwZDkzMWYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI3NDk4NjUxOTU0MDgta2s2cmViOGwwMWJjYWZscTUwc2xxM2M4MG4ycWxtM2guYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI3NDk4NjUxOTU0MDgta2s2cmViOGwwMWJjYWZscTUwc2xxM2M4MG4ycWxtM2guYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTE0NjY5MDUzMjIzMDEyMDI2MjAiLCJoZCI6ImNvZGVhc3RyYS5jb20iLCJlbWFpbCI6ImJ2QGNvZGVhc3RyYS5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6InhqX1BYQVNhblpBZWNTaHlobWI5UFEiLCJuYW1lIjoiQlYgU2F0eWFyYW0iLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tLy1zdDVmY2s3UlpWTS9BQUFBQUFBQUFBSS9BQUFBQUFBQUFCby9BME84ZnBrLTNoOC9zOTYtYy9waG90by5qcGciLCJnaXZlbl9uYW1lIjoiQlYiLCJmYW1pbHlfbmFtZSI6IlNhdHlhcmFtIiwibG9jYWxlIjoiZW4iLCJpYXQiOjE1NTE1NzkwNDcsImV4cCI6MTU1MTU4MjY0N30.HR393NSj38homWaF9718ujko2txZOW3H3e0BssTU9njIoEh_rn90X82XxTvDbqOrPQXy7AOzmHMBppnfoayXOdE1CyOMdbii1yon1nMbmXP77zjUIfnI-bUgpqypjU6NYpd-A0Prmo7c5_OFKPY5UEoju2s8LFFpiuW8es5k7KQkXp-mNcylb94iELpF_MFXYjgzAhHLvLHA5WOuJ0P2anemaCl0DQHDfftNuUAzN8T3a2v6MskAHPLEDEPz5slMYy3Uyyq3x1sg6wjV7T_v7EQ9kM34QgE9JBVq1No-KqkOpKVxRU_9yx1mnJJHgwYT7yWpBxPrwAFBbSzEAFFzUw',
    #     'id_info' => {
    #       'iss' => 'https://accounts.google.com',
    #       'azp' => '749865195408-kk6reb8l01bcaflq50slq3c80n2qlm3h.apps.googleusercontent.com',
    #       'aud' => '749865195408-kk6reb8l01bcaflq50slq3c80n2qlm3h.apps.googleusercontent.com',
    #       'sub' => '111466905322301202620',
    #       'hd' => 'codeastra.com',
    #       'email' => 'bv@codeastra.com',
    #       'email_verified' => true,
    #       'at_hash' => 'xj_PXASanZAecShyhmb9PQ',
    #       'name' => 'BV Satyaram',
    #       'picture' => 'https://lh3.googleusercontent.com/-st5fck7RZVM/AAAAAAAAAAI/AAAAAAAAABo/A0O8fpk-3h8/s96-c/photo.jpg',
    #       'given_name' => 'BV',
    #       'family_name' => 'Satyaram',
    #       'locale' => 'en',
    #       'iat' => 1 _551_579_047,
    #       'exp' => 1 _551_582_647
    #     },
    #     'raw_info' => {
    #       'sub' => '111466905322301202620',
    #       'name' => 'BV Satyaram',
    #       'given_name' => 'BV',
    #       'family_name' => 'Satyaram',
    #       'profile' => 'https://plus.google.com/111466905322301202620',
    #       'picture' => 'https://lh3.googleusercontent.com/-st5fck7RZVM/AAAAAAAAAAI/AAAAAAAAABo/A0O8fpk-3h8/photo.jpg',
    #       'email' => 'bv@codeastra.com',
    #       'email_verified' => true,
    #       'gender' => 'other',
    #       'locale' => 'en',
    #       'hd' => 'codeastra.com'
    #     }
    #   }
    # }

    # Either create a User record or update it based on the provider (Google) and the UID
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.token = auth.credentials.token
      user.expires = auth.credentials.expires
      user.expires_at = auth.credentials.expires_at
      user.refresh_token = auth.credentials.refresh_token

      user.email = auth.info.email
      user.name = auth.info.first_name
      user.avatar = auth.info.image
    end
  end
end
