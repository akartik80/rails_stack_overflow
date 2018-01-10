require_relative '../concerns/spec_concern'

describe UsersController do
  include SpecConcern

  let(:create_users) { FactoryBot.create_list(:user, 3) }
  let(:create_user) { FactoryBot.create(:user) }

  def create_session(user)
    FactoryBot.create(:session, user_id: user.id)
  end

  let(:get_user_post_params) {
    fake_password = Faker::Internet.password

    {
      user: {
        name: Faker::Internet.name,
        email: Faker::Internet.email,
        password: fake_password,
        password_confirmation: fake_password
      }
    }
  }

  let(:get_user_put_params) {
    {
      name: Faker::GameOfThrones.character,
      email: Faker::Internet.email
    }
  }

  describe 'GET #index' do
    let(:get_users) { get :index, format: :json }

    context 'when no user exists' do
      it 'returns empty array' do
        get_users
        expect(response).to have_http_status(:ok)
        expect(json(response.body)).to eq []
      end
    end

    context 'when at least one user exists' do
      it 'returns all users' do
        users = create_users
        get_users
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq users.to_json
      end
    end
  end

  describe 'GET #show' do
    context 'when id is not given' do
      it 'throws ActionController::UrlGenerationError' do
        expect { get :show }.to raise_exception ActionController::UrlGenerationError
      end
    end

    context 'invalid params' do
      it 'returns 404 not found' do
        get :show, params: { id: Faker::GameOfThrones.character }, format: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'valid params' do
      context 'when user does not exist' do
        it 'returns status 404 not found' do
          get :show, params: { id: -1 }, format: :json
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'when user exists' do
        it 'returns the user' do
          user = create_user
          get :show, params: { id: user.id }
          expect(response).to have_http_status(:ok)
          expect(response.body).to eq user.to_json
        end
      end
    end
  end

  describe 'POST #create' do
    context 'invalid parameters' do
      it 'returns status 400 bad request if user parameter is not given' do
        pending
        post :create
        expect(response).to have_http_status(:bad_request)
      end

      required_post_params = %i[name email password password_confirmation]

      required_post_params.each do |param|
        # parameter existence validation
        it "returns status 400 bad request if user parameter does not contain #{param}" do
          pending
          user_params = get_user_post_params
          user_params[param] = nil
          post :create, params: user_params
          expect(response).to have_http_status(:bad_request)
        end

        # parameter type validations
        it "returns status 400 bad request if user parameter contains non string #{param}" do
          pending
          user_params = get_user_post_params
          user_params[param] = Faker::Number.between(1, 10)
          post :create, params: user_params
          expect(response).to have_http_status(:bad_request)
        end
      end

      # extra parameter test
      it 'does not delete user if deleted_at parameter is sent' do
        user_params = get_user_post_params
        user_params[:deleted_at] = Time.now
        post :create, params: user_params
        expect(response).to have_http_status(:created)
        expect(User.first).not_to be_nil
      end
    end

    context 'valid parameters' do
      it 'creates user successfully' do
        user_post_params = get_user_post_params
        post :create, params: user_post_params
        expect(response).to have_http_status(:created)

        parsed_response = json(response.body)
        expect(parsed_response[:name]).to eq user_post_params[:user][:name]
        expect(parsed_response[:email]).to eq user_post_params[:user][:email]
      end
    end
  end

  describe 'PUT #update' do
    before(:each) do
      @user = create_user
    end

    context 'when id is not given' do
      it 'throws ActionController::UrlGenerationError' do
        expect { put :update }.to raise_exception ActionController::UrlGenerationError
      end
    end

    context 'user not logged in' do
      it 'returns status 401 unauthorized' do
        pending
        put :update, params: { id: @user[:id], user: get_user_put_params }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'user logged in' do
      before(:each) do
        session = create_session(@user)
        cookies.signed[:session_id] = session[:token]
      end

      context 'invalid parameters' do
        it 'returns status 400 bad request if user parameter is not given' do
          pending
          put :update, params: { id: @user[:id] }
          expect(response).to have_http_status(:bad_request)
        end

        it 'returns status 400 bad request if user parameter contains an invalid parameter' do
          pending
          user_put_params = get_user_put_params
          user_put_params[:name] = Faker::Number.between(1, 10)

          put :update, params: { id: @user[:id], user: user_put_params }
          expect(response).to have_http_status(:bad_request)
        end

        it 'does not delete user if deleted_at parameter is sent' do
          pending
          user_put_params = get_user_put_params
          user_put_params[:deleted_at] = Time.now

          put :update, params: { id: 1, user: user_put_params }
          expect(response).to have_http_status(:ok)
          expect(User.first).not_to be_nil
        end
      end

      context 'valid parameters' do
        it 'updates user successfully' do
          user_put_params = get_user_put_params
          put :update, params: { id: @user.id, user: user_put_params }

          expect(response).to have_http_status(:ok)
          parsed_response = json(response.body)
          expect(parsed_response[:name]).to eq user_put_params[:name]
          expect(parsed_response[:email]).to eq user_put_params[:email]
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @user = create_user
      session = create_session(@user)
      cookies.signed[:session_id] = session[:token]
    end

    context 'when id is not given' do
      it 'throws ActionController::UrlGenerationError' do
        expect { delete :destroy }.to raise_exception ActionController::UrlGenerationError
      end
    end

    context 'user not logged in' do
      it 'returns status 401 unauthorized' do
        pending
        delete :destroy, params: { id: @user[:id] }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'user logged in' do
      it 'deletes successfully' do
        delete :destroy, params: { id: @user.id }
        expect(response).to have_http_status(:ok)
        expect { User.find(@user.id) }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end
end
