require 'rest_client'
require_relative 'base_resource.rb'


#for ssl keys:
#openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -nodes
module Veye
  module API
    class Resource < BaseResource
      def initialize(path = nil)
        super(path)
        @resource = RestClient::Resource.new(
          @full_path,
          :ssl_client_cert  =>  OpenSSL::X509::Certificate.new(File.read("cert.pem")),
          :ssl_client_key   =>  OpenSSL::PKey::RSA.new(File.read("key.pem"), "passphrase, if any"),
          :ssl_ca_file      =>  "ca_certificate.pem",
          :verify_ssl       =>  OpenSSL::SSL::VERIFY_PEER
        )
      end
    end
  end
end