module Solrsan
    class Config
        include Singleton
        attr_accessor  :solr_server_url
        attr_accessor :solr_server_urls

        def initialize
            @solr_server_urls = {}
        end

        def rsolr_object(key = false)
            @rsolr = RSolr.connect :url => get_server_url(key)
        end

        def add_server_url(url, key)
            @solr_server_urls[key] = url
        end

        def get_server_url(key)
            @solr_server_urls[key] || @solr_server_url
        end
    end
end
