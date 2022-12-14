# frozen_string_literal: true

require 'rails_helper'

class RequestTest < ActiveSupport::TestCase
  # Se agrupan todos los tests relacionados al controlador de Profiles, le dice a Rails que será testeado
  RSpec.describe 'Request', type: :request do
    # Aquí se utiliza la factory de Request para la creación de una publicación
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end
    let!(:turno) { create(:turno, cantidad_asientos: 0, estado: 'CONFIRMADO') }
    let!(:request) { create(:request, estado: 'Pendiente', turno: turno) }
    let!(:invalid_attr_request) { { descripcion: nil } }

    # Se describe lo que se testea
    describe 'get new' do
      it 'should return a successful request' do
        get requests_path(id: request.id, id_viaje: turno.id)
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'get index' do
      # Comportamiento esperado
      it 'should return a successful request' do
        # Se le señala a Rails que se haga un GET a la ruta /requests
        get requests_index_path(id: request.id)
        # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'create' do
      # La idea es que cuando yo cree una publicación la cuenta de publicaciones totales se incremente en 1
      it 'should increase count of Request by 1' do
        # Se espera que el bloque de código entregado cambie la cuenta de Publcation en 1 (al poner 1 es +1).
        expect do
          post requests_create_path(id: request.id), params: { request: request.attributes }
        end.to change(Request, :count).by(1)
      end
      # Se pasan atributos invalidos y se ve que la cuenta de Publicaciones no cambie
      it 'should not increase count of Request' do
        expect do
          invalid_attr_request['turno_id'] = turno.id
          post requests_create_path(id: request.id), params: { request: invalid_attr_request }
        end.to change(Request, :count).by(0)
      end
    end

    describe 'get_show' do
      it 'should return a successful request' do
        get requests_show_path(id: request.id)
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'edit' do
      it 'should return a successful request' do
        get requests_edit_path(id: request.id)
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'update' do
      it 'should change a Request' do
        expect do
          patch requests_update_path(id: request.id), params: { request: { descripcion: 'Ejemplo para cambiar' } }
          # Se recarga la instancia de request nuevamente con los posibles nuevos atributos
          # Luego se revisa si cambió alguno de los atributos del usuario
          request.reload
        end.to change(request, :descripcion)
      end
    end

    describe 'update' do
      it 'should not change a Request' do
        expect do
          patch requests_update_path(id: request.id), params: { request: { descripcion: nil } }
          # Se recarga la instancia de request nuevamente con los posibles nuevos atributos
          # Luego se revisa si cambió alguno de los atributos de la request
          request.reload
        end.to_not change(request, :attributes)
      end
    end

    # En este caso se trata de haer un update pero con atributos que no son válidos por las validaciones hechas.

    describe 'update' do
      it 'should not change a Request' do
        expect do
          patch requests_update_path(id: request.id), params: { request: { estado: nil } }
          # Se recarga la instancia de request nuevamente con los posibles nuevos atributos
          # Luego se revisa si cambió alguno de los atributos de la request
          request.reload
        end.to_not change(request, :attributes)
      end
    end

    describe 'update' do
      it 'should change a Request' do
        expect do
          patch requests_update_path(id: request.id), params: { request: { estado: 'Completado' } }
          # Se recarga la instancia de request nuevamente con los posibles nuevos atributos
          # Luego se revisa si cambió alguno de los atributos del usuario
          request.reload
        end.to change(request, :estado)
      end
      it 'should change a Request' do
        expect do
          patch requests_update_path(id: request.id), params: { request: { estado: 'ACEPTADO' } }
          # Se recarga la instancia de request nuevamente con los posibles nuevos atributos
          # Luego se revisa si cambió alguno de los atributos del usuario
          request.reload
        end.to change(request, :estado)
      end
    end

    describe 'delete' do
      it 'should decrease count of Request by 1' do
        expect do
          delete requests_delete_path(id: request.id)
        end.to change(Request, :count).by(-1)
      end
    end
  end
end
