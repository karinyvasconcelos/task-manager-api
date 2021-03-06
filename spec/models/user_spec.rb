require 'rails_helper'

RSpec.describe User, type: :model do

	let(:user) { build(:user) }

	#Using shoulda matchers
	it { is_expected.to validate_presence_of(:email) }
	it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
	it { is_expected.to validate_confirmation_of(:password) }
	it { is_expected.to allow_value('costa@nonato.com').for(:email) }
	it { is_expected.to validate_uniqueness_of(:auth_token) }

	describe '#info' do
		it 'returns email and created_at' do
			user.save!
			#Utilizando mock - friedly_token (metodo duble)
			allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')

			expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc123xyzTOKEN")

		end
	end

	describe '#generate_authentication_token!' do
		it 'generates a unique auth token' do
			allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')
			user.generate_authentication_token!

			expect(user.auth_token).to eq('abc123xyzTOKEN')
		end

		it 'generates another auth token when the current auth token already has been taken' do
			#Criando um novo usuario no sistema e deixa-lo com o token
			allow(Devise).to receive(:friendly_token).and_return('abc123tokenxyz', 'abc123tokenxyz', 'abcXYZ123456789')
			existing_user = create(:user)
			user.generate_authentication_token!
			#Espera-se que dois usuarios nao tenham o mesmo token
			expect(user.auth_token).not_to eq(existing_user.auth_token)
		end
	end
end
