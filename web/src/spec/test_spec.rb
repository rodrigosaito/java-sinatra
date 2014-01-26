require "spec_helper"

describe "Test" do

  it "works" do
    get '/customers'

    expect(last_response).to be_ok
    # expect(last_response.body).to eq('Hello World')
  end

end
