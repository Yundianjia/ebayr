# -*- encoding : utf-8 -*-
module Ebayr
  class File < Request

    def self.uri
      URI::parse "https://storage#{sandbox ? '.sandbox' : ''}.ebay.com/FileTransferService"
    end

    def self.download(options = {})
      options.merge!({
                         taskReferenceId: '5783644587',
                         fileReferenceId: '5869435317'
                     })
      self.new(:downloadFile, input: options, uri: uri).send
    end

    def self.upload(options = {})
      self.new(:uploadFile, options).send
    end

    def body
      <<-XML
        <?xml version="1.0" encoding="utf-8"?>
        <#{@command}Request xmlns="http://www.ebay.com/marketplace/services">
      #{input_xml}
        </#{@command}Request>
      XML
    end

    def headers
      {
          'X-EBAY-SOA-MESSAGE-PROTOCOL' => 'SOAP12',
          'X-EBAY-SOA-OPERATION-NAME' => @command.to_s,
          'X-EBAY-SOA-SECURITY-TOKEN' =>  self.auth_token,
          'Content-Type' => 'text/xml'
      }
    end
  end
end