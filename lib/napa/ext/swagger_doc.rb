module Napa
  module Ext
    class SwaggerDoc
      def initialize app, api_doc_path: '/api_doc'
        @app = app
        @api_doc_path = api_doc_path
      end

      def call env
        if enabled? && api_doc?(env)
          [
            '301',
            { 'Location' => target_swagger_url(env), 'Content-Type' => 'text/html' },
            []
          ]
        else
          app.call env
        end
      end

      private

      attr_reader :app, :api_doc_path

      def api_doc? env
        env['PATH_INFO'] == api_doc_path
      end

      def enabled?
        ENV.key? 'SWAGGER_UI_URL'
      end

      def target_swagger_url env
        swagger_api_uri = env['REQUEST_URI'].gsub api_doc_path, '/swagger_doc'

        "#{ENV['SWAGGER_UI_URL']}?swagger_doc=#{swagger_api_uri}"
      end
    end
  end
end
