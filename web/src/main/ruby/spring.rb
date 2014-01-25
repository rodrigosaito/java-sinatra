require "java"

require "spring/context"
require "spring/base"
require "spring/transaction"

# Sinatra
require "spring/sinatra"

#Rack
require "spring/transaction_middleware"


# Initialize Spring context
Spring::Context.instance
