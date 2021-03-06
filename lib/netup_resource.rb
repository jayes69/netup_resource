# -*- encoding : utf-8 -*-
# NetupResource - Object-RESTFullService-Mapper v 0.1.0-beta-p004
# NetupResource is a Object-RESTFullService-Mapper mapping http-requests on
# Ruby Objects. As all Mappers it uses Ruby class inheritance within Model-Classes.
#
# Models inherit the Rest Methods post(), get(), put(), delete()
# from NetupResource::Base
#
# For your response objects there are 4 possible types:
#  -> Model Schema  :  (see settings)
#
#  -> YAML Schema   : create a *.yml file within the dir '/config/netup_record/schema'.
#                     the name of this schema should be the downcased model name.
#                     the schema should look like:
#
#                       :foo:
#
#                       :bar:
#                         - :sub1
#                         - :sub2
#
#                      as you see, the yaml-schema accepts one sub-level schema
#                      per root. more than 1 sub-level is currently not supported.
#                      The Mapper will map all roots to attributes of the response
#                      Object. If a root has one or more sub-attributes, another
#                      Object will be generated with an attribute for each sub.
#                      This Sub-Object will be linked to the corrisponding Root-
#                      level attribute, like 'my_request.bar.sub1'.
#                      If the response to the sub-containing root-level-attribute
#                      is an Array, an Array of Sub-Objects will be linked to the
#                      corrisponding root level attribute.
#
#  -> Auto Detected Rails Record:
#
#                       If you neither define a YAML Schema nor a Model Schema,
#                       this plugin will test wether the response is an Array
#                       including only Hashes of the same Schema or not.
#                       If so, the answer to the request will be formated to
#                       an Array of Objects, whos attributes are set according to
#                       the auto detected schema.
#
#  -> Single Result:
#
#                       If non of the upper methods fits, the Mapper will create
#                       an Object having the attribute 'result' containing all
#                       of the response content.
#
# Types of Configuration on a Model:
#
#   self.url        :   required : base url of the API
#   self.schema     :   optional : (give the response object a strict schema
#                                   result object will be built out of the schema)
#   self.type       :   required : response format
#
#
# Example
# =======
#
# in your model
# class Post < NetupResource::Base
#    self.url = "http://www.example.com/" #define base url
#    self.schema = [:id,:date] #define response Object Schema if needed
#    self.type = :json # request format
# end
#
# in your controller
#
# @posts = Post.get( # get request (post has has same params)
#    'my_uri',   # required! request uri
#    {id: 1,name: 'foo'}, # optional : request params; type: ruby-hash
#    {user: 'me',password: 'test'} # optional : base auth
# )
#
#

module NetupResource
  require "netup_resource/yaml"
  require "netup_resource/response_object"
  require "netup_resource/core"
  require "netup_resource/http"
  require "utility/array"
  require "utility/hash"
end