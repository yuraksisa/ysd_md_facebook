require 'ysd-md-profile'
module Model
  module Facebook
    
    GRAPH_API_URL = "http://graph.facebook.com/"

    #
    # It represents a Facebook profile, that is, a profile that used its facebook account to
    # access the system
    #
    class Profile < Users::Profile
      
      property :facebook_user_id, String, :length => 20, :field => 'facebook_user_id', :unique_index => :facebook_user_index

      def photo_url_tiny
        "#{GRAPH_API_URL}#{facebook_user_id}/picture?width=72&height=72" 
      end

      def photo_url_small
        "#{GRAPH_API_URL}#{facebook_user_id}/picture?width=144&height=144"
      end

      def photo_url_medium
        "#{GRAPH_API_URL}#{facebook_user_id}/picture?width=288&height=288"
      end

      def photo_url_full
        "#{GRAPH_API_URL}#{facebook_user_id}/picture?width=480&height=480"
      end

      def facebook_id
        username[3..-1]
      end
      
      #
      # Export as json
      #
      def as_json(options={})

        methods = options[:methods] || []     
        methods << :photo_url_tiny
        methods << :photo_url_small
        methods << :photo_url_medium
        methods << :photo_url_full

        super(options.merge!(:methods => methods))

      end 

    end
  end
end