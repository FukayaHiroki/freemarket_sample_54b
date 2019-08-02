require 'rails_helper'

describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe '#sms' do
    context 'log in' do
      before do
        login(user)
        get :sms
      end
      it 'redirects to root_path' do
        expect(response).to redirect_to(root_path)
      end
    end
    context 'not log in' do
      before do
        get :sms
      end
      it 'render :sms' do
        expect(response).to render_template :sms
      end
    end
  end

  describe '#facebook' do
    context 'log in' do
      before do
        login(user)
        get :facebook
      end
      it 'redirects to root_path' do
        expect(response).to redirect_to(root_path)
      end
    end
    context 'not log in' do
      before do
        get :facebook
      end
      it 'render :facebook' do
        expect(response).to render_template :facebook
      end
    end
  end

  describe '#google' do
    context 'log in' do
      before do
        login(user)
        get :google
      end
      it 'redirects to root_path' do
        expect(response).to redirect_to(root_path)
      end
    end
    context 'not log in' do
      before do
        get :google
      end
      it 'render :google' do
        expect(response).to render_template :google
      end
    end
  end

  # describe '#create' do
  #   let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

  #   context 'log in' do
  #     before do
  #       login user
  #     end

  #     context 'can save' do
  #       subject {
  #         post :create,
  #         params: params
  #       }

  #       it 'count up message' do
  #         expect{ subject }.to change(Message, :count).by(1)
  #       end

  #       it 'redirects to group_messages_path' do
  #         subject
  #         expect(response).to redirect_to(group_messages_path(group))
  #       end
  #     end

  #     context 'can not save' do
  #       let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }

  #       subject {
  #         post :create,
  #         params: invalid_params
  #       }

  #       it 'does not count up' do
  #         expect{ subject }.not_to change(Message, :count)
  #       end

  #       it 'renders index' do
  #         subject
  #         expect(response).to render_template :index
  #       end
  #     end
  #   end

  #   context 'not log in' do

  #     it 'redirects to new_user_session_path' do
  #       post :create, params: params
  #       expect(response).to redirect_to(new_user_session_path)
  #     end
  #   end

end