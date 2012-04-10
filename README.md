The FCC Content API allows you to programmatically access much of the content accessible on [FCC.gov](http://fcc.gov).

fcc-content-api is a lightweight Ruby wrapper for the Federal Communication Commission's Content API. The query interface resembles ActiveRecord. The response objects are simple Ruby `Hash`es and `Array`s.

The FCC Content API is powered by the [Drupal Content API Module](http://drupal.org/project/contentapi).

## Usage

First, familiarize yourself with the [FCC Content API REST Documentation](http://www.fcc.gov/developer/fcc-content-api).

The `FccContentApi::Content` object is where you'll do most of the querying.

```ruby 
results = FccContentApi::Content.where(:search_string => "broadband").all
results.first # => {"count"=>"587", "pages"=>58, "itemsPerPage"=>10, "currentPage"=>0}
results[1] # => {"nid"=>"38802", "title"=>"PSHSB Seeks Comment on Broadband Waiver Transition Process", "created"=>"2012-04-06", "changed"=>"2012-04-09", "type"=>"edoc", "webUrl"=>"http://www.fcc.gov/document/pshsb-seeks-comment-broadband-waiver-transition-process", "uri"=>"http://www.fcc.gov/api/content/38802"}
```

Options for `FccContentApi#where` map 1-to-1 to the query options listed in the official [FCC docs](http://www.fcc.gov/developer/fcc-content-api).

For example, if you want proceedings, related edocs and comments:

```ruby
FccContentApi::Content.where(:edocs => "true").where(:type => "proceeding").where(:comments => "true").all

# or pass a single Hash:
FccContentApi::Content.where({:edocs => "true", :type => "proceeding" :comments => "true"}).all
```

If you know the id of the object you want, use `FccContentApi::Content#find`:

```ruby
FccContentApi::Content.find(38660)
```

## Installation

`gem install fcc-content-api` or:

```ruby
# Gemfile
gem "fcc-content-api"
```

## More Info

For more information, please visit the [FCC's Developers page](http://www.fcc.gov/developers) and the [FCC's Github page](http://github.com/fcc).