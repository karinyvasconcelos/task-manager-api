class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Atributo virtual, nao esta presente na base de dados, utilizado nos testes

  validates_uniqueness_of :auth_token
  before_create :generate_authentication_token!

  def info
  	"#{email} - #{created_at} - Token: #{Devise.friendly_token}"
  end

  def generate_authentication_token!
  	#Enquanto houve um usuario com o mesmo token, é gerado um novo
  	begin
  		self.auth_token = Devise.friendly_token
  	end while User.exists?(auth_token: auth_token)
  end

end
