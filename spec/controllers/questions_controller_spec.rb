require_relative '../concerns/spec_concern'

describe QuestionsController do
  include SpecConcern

  let(:create_questions) { FactoryBot.create_list(:question, 3) }
  let(:create_question) { FactoryBot.create(:question) }
  let(:create_user) { FactoryBot.create(:user) }

  let(:get_question_post_params) {
    fake_password = Faker::Internet.password

    {
      question: {
        name: Faker::Internet.name,
        email: Faker::Internet.email,
        password: fake_password,
        password_confirmation: fake_password
      }
    }
  }

  let(:get_question_put_params) {
    {
      name: Faker::GameOfThrones.character,
      email: Faker::Internet.email
    }
  }

  def create_session(user)
    FactoryBot.create(:session, user_id: user.id)
  end

  describe 'GET #index' do
    let(:get_questions) { get :index, format: :json }

    context 'when no question exists' do
      it 'returns empty array' do
        get_questions
        expect(response).to have_http_status(:ok)
        expect(json(response.body)).to eq []
      end
    end

    context 'when at least one question exists' do
      it 'returns all question' do
        question = create_questions
        get_questions
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq question.to_json
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
      context 'when question does not exist' do
        it 'returns status 404 not found' do
          get :show, params: { id: -1 }, format: :json
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'when question exists' do
        it 'returns the question' do
          question = create_question
          get :show, params: { id: question.id }
          expect(response).to have_http_status(:ok)
          expect(response.body).to eq question.to_json
        end
      end
    end
  end

  describe 'POST #create' do
    before(:each) do
      @user = create_user
      session = create_session(@user)
      cookies.signed[:session_id] = session[:token]
    end

    context 'invalid parameters' do
      it 'returns status 400 bad request if question parameter is not given' do
        pending
        post :create
        expect(response).to have_http_status(:bad_request)
      end

      required_post_params = %i[text]

      required_post_params.each do |param|
        # parameter existence validation
        it "returns status 400 bad request if question parameter does not contain #{param}" do
          # pending
          question_params = get_question_post_params
          question_params[param] = nil
          post :create, params: question_params
          expect(response).to have_http_status(:bad_request)
        end

        # parameter type validations
        it "returns status 400 bad request if question parameter contains non string #{param}" do
          # pending
          question_params = get_question_post_params
          question_params[param] = Faker::Number.between(1, 10)
          post :create, params: question_params
          expect(response).to have_http_status(:bad_request)
        end
      end

      # extra parameter test
      it 'does not delete question if deleted_at parameter is sent' do
        question_params = get_question_post_params
        question_params[:deleted_at] = Time.now
        post :create, params: question_params
        expect(response).to have_http_status(:created)
        expect(question.first).not_to be_nil
      end
    end

    # context 'valid parameters' do
    #   it 'creates question successfully' do
    #     question_post_params = get_question_post_params
    #     post :create, params: question_post_params
    #     expect(response).to have_http_status(:created)
    #
    #     parsed_response = json(response.body)
    #     expect(parsed_response[:name]).to eq question_post_params[:question][:name]
    #     expect(parsed_response[:email]).to eq question_post_params[:question][:email]
    #   end
    # end
  end
end
