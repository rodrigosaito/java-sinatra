module Spring

  class TransactionMiddleware

    def initialize(app)
      @app = app
    end

    def call(env)
      Spring::Transaction.execute do
        @app.call(env)
      end
    end

  end

end
