require "fcc-content-api/version"
require "weary"
require "json"

module FccContentApi

  def self.client
    @@client ||= FccContentApi::Client.new
  end

  class Content
    def self.where(*args)
      Query.new(self).where(*args)
    end

    def self.all
      Query.new(self).all
    end

    def self.find(id)
      resp = FccContentApi.client.get(:id => id).perform.body
      JSON.parse resp
    end
  end

  class Query

    def initialize(klass); @klass = klass; end

    def criteria; @criteria ||= {}; end

    def where(args)
      criteria.merge! args
      self
    end

    def all; execute; end

    def request
      @request ||= FccContentApi.client.all criteria
    end

    def execute
      resp = request.perform.body
      JSON.parse(resp)
    end

  end

  class Client < Weary::Client
    domain "http://www.fcc.gov/api"

    get :all, "/content.json?" do |resource|
      resource.optional :created_before, :created_after, # YYYY-MM-DD
                        :changed_before, :changed_after, # YYYY-MM-DD
                        :search_string,
                        :limit,
                        :page,
                        :fields,		# true
                        :edocs, 		# true
                        :comments, 	# true
                        :major_topics,
                        :type,
                        :term,
                        :topic,
                        :title
    end

    get :get, "/content/{id}.json"

  end
end