require 'ysd-md-profile'
module Model
  module Facebook
    
    GRAPH_API_URL = "http://graph.facebook.com/"

    #
    # It represents a Facebook profile, that is, a profile that used its facebook account to
    # access the system
    #
    class Profile < Users::Profile

      def photo_url_tiny
        "#{GRAPH_API_URL}#{facebook_id}/picture?width=72&height=72" 
      end

      def photo_url_small
        "#{GRAPH_API_URL}#{facebook_id}/picture?width=144&height=144"
      end

      def photo_url_medium
        "#{GRAPH_API_URL}#{facebook_id}/picture?width=288&height=288"
      end

      def photo_url_full
        "#{GRAPH_API_URL}#{facebook_id}/picture?width=480&height=480"
      end

      def facebook_id
        username[3..-1]
      end

      def exportable_attributes
      
        data = super
        data.store(:photo_url_tiny, photo_url_tiny)
        data.store(:photo_url_small, photo_url_small)
        data.store(:photo_url_medium, photo_url_medium)
        data.store(:photo_url_full, photo_url_full)
       
        return data
  
      end 

    end
  end
end