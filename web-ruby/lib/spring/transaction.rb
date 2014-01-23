require "java"

module Spring

  module Transaction

    def self.without_result(&block)
      txManager = ::Spring::Context.bean("transactionManager")

      transactionTemplate = Java::OrgSpringframeworkTransactionSupport::TransactionTemplate.new txManager

      ret_val = nil

      transactionWithoutResult = Class.new(Java::OrgSpringframeworkTransactionSupport::TransactionCallbackWithoutResult) do
        define_method :doInTransactionWithoutResult do |status|
          ret_val = block.call
        end
      end.new

      transactionTemplate.execute(transactionWithoutResult)
      puts ret_val
      ret_val
    end

  end

end
