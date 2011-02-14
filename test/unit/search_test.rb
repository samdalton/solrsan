require 'test_helper'
require 'search_test_helper'

class SearchTest < Test::Unit::TestCase
  include SearchTestHelper

  def setup
    Document.destroy_all_index_documents!
    @document = document_mock
  end
  
  def teardown
    Document.destroy_all_index_documents!
  end

  def test_simple_query
    Document.index(@document)
    q = @document.attributes[:title]

    response = Document.search(:q => q)
    metadata = response[:metadata]
    docs = response[:docs]
    assert metadata[:total_count] > 0
  end

  def test_sort
    Document.index(Document.new(:id => 3, :title => "solar city",:review_count => 10))
    Document.index(Document.new(:id => 4, :title => "city solar", :review_count => 5))

    q = "solar"
    response = Document.search(:q => q, :sort => "review_count asc")
    docs = response[:docs]

    assert_not_nil docs[0], "Not enough docs for #{q} to test."
    first_result_name = docs[0][:title]
    assert_not_nil docs[1], "Not enough docs for #{q} to test."
    second_result_name = docs[1][:title]

    assert_equal [second_result_name, first_result_name].sort, [first_result_name, second_result_name]

    response = Document.search(:q => q, :sort => "review_count desc")
    docs = response[:docs]

    assert_not_nil docs[0], "Not enough docs for #{q} to test."
    first_result_name = docs[0][:title]
    assert_not_nil docs[1], "Not enough docs for #{q} to test."
    second_result_name = docs[1][:title]

    assert_equal [second_result_name, first_result_name].sort.reverse, [first_result_name, second_result_name]
  end
  
  def test_invalid_query_should_return_error_message_in_metadata
    response = Document.search(:q => "http://tommy.chheng.com")
    docs = response[:docs]
    metadata = response[:metadata]

    assert_not_nil response[:metadata][:error]
    assert_equal 400, response[:metadata][:error][:http_status_code]
  end

  def test_parse_facet_counts
    facet_counts = {'facet_queries'=>{},
      'facet_fields' => {'language' => ["Scala", 2, "Ruby", 1, "Java", 0]},
      'facet_dates'=>{}}
    
    facet_counts = Document.parse_facet_counts(facet_counts)
    
    assert_equal ["Scala", "Ruby", "Java"], facet_counts['facet_fields']['language'].keys
  end

  def test_text_faceting
    Document.index(Document.new(:id => 3, :author => "Bert", :title => "solr lucene",:review_count => 10))
    Document.index(Document.new(:id => 4, :author => "Ernie", :title => "lucene solr", :review_count => 5))
    
    response = Document.search(:q => "solr", :'facet.field' => ['author'])
    docs = response[:docs]
    facet_counts = response[:facet_counts]
    assert_not_nil facet_counts["facet_fields"]["author"]

    author_facet_entries = facet_counts["facet_fields"]["author"]
    assert author_facet_entries.keys.include?("Bert") && author_facet_entries.keys.include?("Ernie")
  end
end

