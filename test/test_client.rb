require "test_helper"

class TestClient < Test::Unit::TestCase
  VCR.use_cassette("test_title") do
    def test_title
      title = "Open Internet Workshops and Speeches"
      resp = FccContentApi::Content.where(:title => URI.encode(title)).all
      assert_equal resp.first.keys.sort!, ["count", "pages", "itemsPerPage", "currentPage"].sort!
      assert_equal resp[1].keys.sort!, ["nid", "title", "created", "changed", "type", "webUrl", "uri"].sort!
      assert_equal title, resp[1]["title"]
    end
  end

  VCR.use_cassette("test_all") do
    def test_all
      resp = FccContentApi::Content.all
      assert_equal resp.first.keys.sort!, ["count", "pages", "itemsPerPage", "currentPage"].sort!
      assert_equal resp[1].keys.sort!, ["nid", "title", "created", "changed", "type", "webUrl", "uri"].sort!
    end
  end

  VCR.use_cassette("test_find") do
    def test_find
      resp = FccContentApi::Content.find 38837
      assert_equal resp.class, Hash
      keys = ["nid", "title", "created", "changed", 
              "type", "webUrl", "taxonomy", "body", 
              "vid", "field_short_title", "field_short_description", 
              "field_author", "field_job_title", "field_edoc_internal_id", 
              "field_released_date", "field_published_date", 
              "field_adopted_date", "field_comment_date", "field_edoc_id", 
              "field_featured_image", "topics", "uri"] 
      assert_equal resp.keys.sort!, keys.sort!
    end
  end

  def test_params
    params = {
      :attribute1 => "value1", # invalid
      :search_string => "searchq"  # valid
    }
    req = FccContentApi::Content.where(params).request
    assert_equal req.uri.to_s.split("?")[1], "search_string=searchq"
  end

  def test_equivalent_queries
    q1 = FccContentApi::Content.where({:search_string => "broadband", :created_afer => "2012-1-1"}).request
    q2 = FccContentApi::Content.where(:search_string => "broadband").where(:created_afer => "2012-1-1").request
    assert_equal q1.uri.to_s, q2.uri.to_s
  end
end