# frozen_string_literal: true

RSpec.describe 'Comments', type: :request do
  let(:article) { create :article }
  subject { get "/articles/#{article.id}/comments" }

  describe 'GET #index' do
    it 'renders a successful response' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return only comments belonging to article' do
      comment = create :comment, article: article
      create :comment
      subject
      expect(json_data.length).to eq(1)
      expect(json_data.first[:attributes][:id]).to eq(comment.id)
    end

    it 'should have proper json body' do
      comment = create :comment, article: article
      subject
      expect(json_data.first[:attributes]).to eq({
                                                   content: comment.content,
                                                   id: comment.id
                                                 })
    end

    it 'should have related objects information in the response' do
      user = create :user
      create :comment, article: article, user: user
      subject
      relationships = json_data.first[:relationships]
      expect(relationships[:article][:data][:id]).to eq(article.id.to_s)
      expect(relationships[:user][:data][:id]).to eq(user.id.to_s)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { content: 'My awesome comment for article' } }
    let(:invalid_attributes) { { content: '' } }

    context 'when not authorized' do
      subject { post "/articles/#{article.id}/comments" }

      it_behaves_like 'forbidden_requests'
    end

    context 'when authorized' do
      let(:user) { create :user }
      let(:access_token) { user.create_access_token }

      let(:headers) { { 'authorization': "Bearer #{access_token.token}" } }

      context 'with valid params' do
        subject { post "/articles/#{article.id}/comments", params: { comment: valid_attributes }, headers: headers }

        it 'returns 201 status code' do
          subject
          expect(response).to have_http_status(:created)
        end

        it 'creates a new Comment' do
          expect { subject }.to change(article.comments, :count).by(1)
        end

        it 'renders a JSON response with the new comment' do
          subject
          expect(json[:content]).to eq('My awesome comment for article')
        end
      end

      context 'with invalid params' do
        subject do
          post "/articles/#{article.id}/comments", params: { comment: invalid_attributes },
                                                   headers: headers
        end

        it 'should return 422 status code' do
          subject
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'renders a JSON response with errors for the new comment' do
          subject
          expect(json).to include({'content': ["can't be blank"]})
        end
      end
    end
  end
end
