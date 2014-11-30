module Napa
  module Ext
    class Poison
      MATCHER = %r{\A/poison/(?<pill>normal|nohandle|messy_contagion)\z}

      def initialize app
        @app = app
      end

      def call env
        pill = pill_from env
        if pill
          handler_for(pill).call env
        else
          app.call env
        end
      end

      private

      attr_reader :app

      def pill_from env
        result = MATCHER.match env['PATH_INFO']

        result[:pill] if result
      end

      def handler_for pill
        Rack::Auth::Basic.new PoisonHandler.new(pill) do |username, password|
          ENV['POISON_CREDENTIAL'] &&
            [username, password] == ENV['POISON_CREDENTIAL'].split(':')
        end
      end

      class PoisonHandler < Rack::Auth::Basic
        MESSY_CONTAGION_CMD = %(
          for i in
            `ps aux | grep unicorn | grep -v grep | tr -s ' ' | cut -d' ' -f2`;
            do kill -15 $i;
          done
        ).gsub(/\s+/, ' ')

        def initialize pill
          @pill = pill.to_sym
        end

        def call _
          case pill
          when :normal
            exit 0
          when :nohandle
            exit! 1
          when :messy_contagion
            system MESSY_CONTAGION_CMD
          end
        end

        private

        attr_reader :pill
      end
    end
  end
end
