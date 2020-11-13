module BxBlockComments
  class Comment < ApplicationRecord
    self.table_name = :comments
    belongs_to :account, class_name: 'AccountBlock::Account'
    belongs_to :post, class_name: 'BxBlockPost::Post'
  end
end
