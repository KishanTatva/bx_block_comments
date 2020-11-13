require 'rails_helper'

RSpec.describe '/bx_block_comments', :jwt do
    let(:endpoint) { '/bx_block_comments/comments' }
  
    let(:headers) { {:token => token} }
  
    let(:json)   { JSON response.body }
    let(:data)   { json['data'] }
    let(:token)  { jwt }
    let(:attributes) { data['attributes']}
    let(:errors) { json['errors'] }
    let(:error)  { errors.first }
    let(:model_errors) { data['attributes']['errors'] }
    let(:model_error)  { errors.first }
  
    let(:account) { create :email_account }
    let(:id)      { account.id }
    let(:post1) { create :post }

    describe 'GET bx_block_comments/comments' do
      
      let!(:comment1) { create :comment , account: account }
      let!(:comment2) { create :comment , account: account }
   
      before { get endpoint, :headers => headers }
  
      it 'returns list of Commensts' do
        expect(response.status).to eq 200
        expect(data.count).to eq 2
        expect(data.first['attributes']['comment']).to eq comment1.comment
        expect(data.second['attributes']['comment']).to eq comment2.comment
      end
    end
        
    describe 'POST bx_block_comments/comments' do
      let(:params) {{ data: {  attributes: {
        comment: "hello",
        post_id: post1.id ,
        account_id: account.id }
      }
      }}
  
      before { post endpoint, :headers => headers, :params => params }
  
      context 'given valid parameters' do
        it 'creates comment record' do
          expect(response.status).to eq 201
          expect(BxBlockComments::Comment.count).to eq 1
        end
      end
  
      context 'given an expired token' do
        let(:token) { jwt_expired }
  
        it 'indicates that the token has expired' do
          expect(response.status).to eq 401
          expect(error['token']).to match(/expired/i)
        end
      end
  
      context 'given an invalid token' do
        let(:token) { 'invalid_token' }
  
        it 'indicates that the record was not found' do
          expect(response.status).to eq 400
          expect(error).to match({'token' => 'Invalid token'})
        end
      end
    end
    
    describe 'GET bx_block_comments/comments/:id' do
      let!(:comment3) { create :comment , account: account }
  
      let(:endpoint2) { "/bx_block_comments/comments/#{comment3.id}" }
  
      before { get endpoint2, :headers => headers }
  
      it 'returns comment attributes' do
        expect(response.status).to eq 200
        expect(data['attributes']['comment']).to eq comment3.comment
      end
    end
    
    describe 'PUT /bx_block_comments/comments/:id' do
      let(:comment) {
        create :comment,account: account,post: post1
      }
      let(:endpoint) { "/bx_block_comments/comments/#{comment.id}" }
  
      let(:new_comment) {  'catalogue_new'  }
      let(:update_params) {{
        data: {  attributes: { comment: new_comment , post_id: post1.id ,account_id: account.id } } 
        }}
  
      before { put endpoint, :headers => headers, :params => update_params }
  
      context 'given valid parameters' do
        it 'updates given attributes' do
          expect(response.status).to eq 200
          expect(data['attributes']['comment']).to eq new_comment
        end
      end

    end

    describe 'DELETE /bx_block_comments/comments/:id' do
      let(:comment1) {
        create :comment , account: account }
      let(:endpoint) { "/bx_block_comments/comments/#{comment1.id}" }
  
      before { delete endpoint, :headers => headers }
  
      context 'given valid parameters' do
        it 'delete given comments' do
          expect(response.status).to eq 200  
          expect(json['message']).to eq "Comment deleted."
        end
      end
    end
  
end