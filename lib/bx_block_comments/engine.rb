module BxBlockComments
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockComments

     config.generators.api_only = true
     config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_comments.configuration' do |app|
      base = app.config.builder.root_url || ''
      # p base
      app.routes.append do
        # mount BxBlockComments::Engine => base + '/comments'
        mount BxBlockComments::Engine => "/bx_block_comments"
      end
    end

  end
end
