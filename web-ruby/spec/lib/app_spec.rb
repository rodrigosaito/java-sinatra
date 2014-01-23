require "spec_helper"

require "java"

describe "App" do

  before do
    Spring::Context.bean("customerRepository").deleteAll
  end

  let!(:customer) do
    custRepo = Spring::Context.bean("customerRepository")

    customer = Java::JavasinatraCoreModel::Customer.new
    customer.name = "Some Customer"
    customer.email = "customer@domain.org"

    custRepo.save customer

    CustomerResource.new(customer).to_hash
  end

  let(:all_customers) do
    [ customer ]
  end

  describe  "GET /customers" do

    let(:expected_json) do
      all_customers
    end

    it "returns an array with all customers" do
      get "/customers"
      json.should eq expected_json
    end

  end

  describe "GET /customers/:id" do

    let(:expected_json) do
      customer
    end

    it "returns customer" do
      get "/customers/1"
      json.should eq expected_json
    end

    context "when id doesn't exists" do

      it "returns 404" do
        get "/customers/123456789"
        last_response.status.should eq 404
      end

    end

  end


end
