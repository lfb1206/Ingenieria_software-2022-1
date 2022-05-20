# frozen_string_literal: true

require 'rails_helper'

class RegistrationsTest < ActiveSupport::TestCase
  # Se agrupan todos los tests relacionados al controlador de Users, se le dice a Rails que será testeado
  RSpec.describe 'User', type: :request do
    # Aquí se utiliza la factory de Request para la creación de una publicación

    describe 'get_in' do
      it 'should return a successful request' do
        get '/users/sign_in'
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'get_sign_up' do
      it 'should return a successful request' do
        @user = FactoryBot.create(:user)
        get '/users/sign_up'
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'get_show' do
      it 'should return a successful request' do
        # Se crea una instancia de User
        @user = FactoryBot.create(:user)
        sign_in @user
        # Se realiza un GET con el id del user recién creado y
        # se espra que la salida sea un 200 que es lo mismo que un ok
        get "/users/show?id#{@user.id}"
        expect(response).to have_http_status(:ok)
      end
    end
  end
end