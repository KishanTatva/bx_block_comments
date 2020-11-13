module BxBlockComments
    class CommentSerializer < BuilderBase::BaseSerializer
        include FastJsonapi::ObjectSerializer
        attributes *[
            :id,
            :account_id,
            :post_id,
            :comment,
            :created_at,
            :updated_at,
            :post,
            :account
        ]
    end
end