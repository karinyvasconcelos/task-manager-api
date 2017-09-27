require 'rails_helper'

#O describe descreve comportamentos do código
RSpec.describe 'Users API', type: :request do
	let!(:user) { create(:user) } #O '!' força a criação da instância
	let(:user_id) { user.id }

	before { host! 'api.taskmanager.dev' }

	describe 'GET /users/:id' do
		before do #Ocorre em cada 'it'
			headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
			get "/users/#{user_id}", params: {}, headers: headers
		end

		context 'when the user exists' do

			it 'returns the user' do
				user_response = JSON.parse(response.body, symbolize_names: true) #Converte a string vinda de body
				expect(user_response[:id]).to eq(user_id) #Espera-se que o id do usuário seja igual ao da base de dados criada em let
			end

			it 'return status code 200' do
				expect(response).to have_http_status(200)
			end
		end

		context 'when the user does not exist' do
			let(:user_id) { 10000 } #Sobrescrevendo user_id

			it 'returns status code 404' do
				expect(response).to have_http_status(404)
			end
		end
	end


	describe 'POST /users' do

		before do
			headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
			#Fazer requisicao
			post '/users', params: { user: user_params }, headers: headers
		end

		context 'when the request params are valid' do
			let(:user_params) { attributes_for(:user) }

			it 'returns status code 201' do
				expect(response).to have_http_status(201)

			end


			it 'returns json data for the created user' do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response[:email]).to eq(user_params[:email])

			end
		end

		context 'when the request params area invalid' do
			let(:user_params) { attributes_for(:user, email: 'invalid_email@'	) }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'returns the json data for the errors' do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response).to have_key(:errors)
			end

		end
	end

	describe 'PUT /users/:id' do
		before do
			headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
			put "/users/#{user_id}", params: { user: user_params }, headers: headers
		end

		context 'when the request params are valid' do
			let(:user_params) { { email: 'new_email@taskmanager.com' } }
			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end

			it 'returns the json data for the updated user' do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response[:email]).to eq(user_params[:email])
			end
		end

		context 'when the request params are invalid' do
			let(:user_params) { { email: 'invalid_email@' } }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'returns the json data for the errors' do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response).to have_key(:errors)
			end
		end
	end

	describe 'DELETE/users/:id' do
		before do
			headers = { 'Accept' => 'application/vnd.taskmanager.v1'}
			delete "/users/#{user_id}", params: {}, headers: headers
		end

		it 'returns status code 204' do
			expect(response).to have_http_status(204)
		end

		it 'removes the user from database' do
			expect( User.find_by(id: user_id) ).to be_nil
		end

	end

end
