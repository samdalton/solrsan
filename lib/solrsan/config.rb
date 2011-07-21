module Solrsan
    class Config
        include Singleton
        attr_accessor  :solr_server_url
        attr_accessor :solr_server_urls

        def initialize
            @solr_server_urls = {}
            @solr_servers = {}
        end

        def rsolr_object(key = :default)
            unless @solr_servers[key]
                @solr_servers[key] = RSolr.connect :url => get_server_url(key)
            end
            @solr_servers[key]
        end

        def add_server_url(url, key)
            @solr_server_urls[key] = url
        end

        def get_server_url(key)
            @solr_server_urls[key] || @solr_server_urls[:default] || @solr_server_url
        end
    end
end
