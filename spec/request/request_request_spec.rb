require 'rails_helper.rb'
require 'faker'
require 'factories/request'
require 'factories/user'
require 'factories/turno'

class RequestTest < ActiveSupport::TestCase

    # Se agrupan todos los tests relacionados al controlador de Profiles, con esta línea se le dice a Rails que será testeado
    RSpec.describe 'Request', type: :request do

        # Aquí se utiliza la factory de Request para la creación de una publicación
        let(:user) {create(:user)}
        let(:user2) {create(:user)}
        let(:turno) {create(:turno)}
        let(:request) {create(:request)}

        # Se describe lo que se testea
        describe 'get index' do
            # Comportamiento esperado
            it 'should return a successful request' do
                # Se le señala a Rails que se haga un GET a la ruta /requests
                sign_in @user
                get '/requests/index'
                # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
                expect(response).to have_http_status(:ok)
            end
        end

        describe 'get new' do
            it 'should return a successful request' do
                get '/requests/new'
                expect(response).to have_http_status(:ok)
            end
        end

        describe 'create' do
            # La idea es que cuando yo cree una publicación la cuenta de publicaciones totales se incremente en 1
            it 'should increase count of Request by 1' do
                # Se espera que el bloque de código entregado cambie la cuenta de Publcation en 1 (al poner 1 es +1).
                expect do
                    @attr_valid = {descripcion: "Algun texto"}
                    post '/requests', params: {request: @attr_valid}
                end.to change(Request, :count).by(1)
            end
        end

        describe 'get_show' do
            it 'should return a successful request' do
                get "/requests/show/?id=#{request.id}"
                expect(response).to have_http_status(:ok)
            end
        end
        describe 'edit' do
            it 'should return a successful request' do
                get "/requests/edit?id=#{request.id}"
                expect(response).to have_http_status(:ok)
        
            end
        end
        end
end