java_import "org.springframework.transaction.support.TransactionTemplate"
java_import "org.springframework.transaction.support.TransactionCallbackWithoutResult"

module Spring

  module Transaction

    class << self
      include Spring::Base

      def execute(&block)
        txManager = bean("transactionManager")

        transactionTemplate = TransactionTemplate.new txManager

        ret_val = nil

        transaction = Class.new(TransactionCallbackWithoutResult) do
          define_method :doInTransactionWithoutResult do |status|
            ret_val = block.call
          end
        end.new

        transactionTemplate.execute(transaction)

        ret_val
      end
    end

  end

end
