module Solrsan
    class Config
        include Singleton

        def initialize
            @server_urls = { :write => {}, :read => {} }
            @solr_servers = { :write => {}, :read => {} }
        end

        def rsolr_object(namesapce = :default, method = :read)
            unless @solr_servers[method][namesapce]
                @solr_servers[method][namesapce] = RSolr.connect :url => @server_urls[method][namespace]
            end
            @solr_servers[method][namesapce]
        end

        def add_server(namespace, url, method)

            @server_urls[method][namespace] = url
          
        end
    end
end
