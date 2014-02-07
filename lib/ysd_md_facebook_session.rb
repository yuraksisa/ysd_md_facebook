require 'ysd_md_facebook_profile'
require 'koala'
require 'digest/md5' unless defined?Digest

module Model
  module Facebook
    #
    # It represents a facebook session
    #
    # http://developers.facebook.com/tools/explorer/
    #
    class Session
       
       attr_reader :access_token

       def initialize(access_token)
         @access_token = access_token
       end

       #
       # When a user is connected via facebook.
       #
       # It creates the profile in the system if the user has not been accessed before
       #
       # @return [Profile] the connected user
       #
       def user_connected!
          
          profile = nil

          graph = Koala::Facebook::API.new(access_token)

          if fb_profile = graph.get_object("me")
            profile = Model::Facebook::Profile.first(:facebook_user_id => fb_profile['id']) ||
                      Users::Profile.first(:email => fb_profile['email'])
            unless profile 
              adapted_data = adapt_fb_profile_data(fb_profile)
              profile = Model::Facebook::Profile.create({
                                                :username => "#{fb_profile['id']}01", 
            	                                  :facebook_user_id => fb_profile['id'],
                                                :email => fb_profile['email'], 
            	                                  :full_name => fb_profile['name'],
            	                                  :sex => adapted_data[:gender],
                                                :preferred_language => fb_profile['locale'][0..1],
                                                :date_of_birth => Date.strptime(fb_profile['birthday'],'%m/%d/%Y'),
                                                :country_of_origin => adapted_data[:country_of_origin],
                                                :usergroups => [Users::Group.get('user'), Users::Group.get('facebook')]
            	                                  })
            end
          end

          return profile

       end

       private

       #
       # Adapts profile data from facebook
       #
       # @param [] The facebook profile
       #
       # @return [Hash] The user data adapted
       def adapt_fb_profile_data(fb_profile)
         
         data = {}

         case fb_profile['gender']
            when 'male'
               data.store(:gender,'0')
            when 'female'
               data.store(:gender,'1')
            else
               data.store(:gender,'0')
         end  

         if fb_profile.has_key?('hometown')
           data.store(:country_of_origin, fb_profile['hometown']['name'])
         else
           data.store(:country_of_origin, '')
         end
            
         return data

       end

    end
  end
end
