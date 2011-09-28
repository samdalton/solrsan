module Solrsan
    class Config
        include Singleton

        def initialize
            @server_urls = { :write => {}, :read => {} }
            @solr_servers = { :write => {}, :read => {} }
        end

        def rsolr_object(namespace = :default, method = :read)

            unless @solr_servers[method][namespace]
                @solr_servers[method][namespace] = RSolr.connect :url => @server_urls[method][namespace]
            end
            @solr_servers[method][namespace]

        end

        def add_server(namespace, url, method)

            @server_urls[method][namespace] = url
          
        end
    end
end
