require "test_helper"

class TestQuery < Test::Unit::TestCase


	def test_where
		query = FccContentApi::Query.new(FccContentApi::Content)
		query.where(:attribute => "value")
		assert_equal query.criteria[:attribute], "value"
	end

	def test_stacked_wheres
		query = FccContentApi::Query.new(FccContentApi::Content)
		query.where(:attribute => "value")
		assert_equal query.criteria[:attribute], "value"
		query.where(:second_attribute => "second_value")
		assert_equal query.criteria[:second_attribute], "second_value"
		assert_equal query.criteria[:attribute], "value"
	end

	def test_request
		query = FccContentApi::Query.new(FccContentApi::Content)
		assert_equal query.request.class, Weary::Request
	end

end