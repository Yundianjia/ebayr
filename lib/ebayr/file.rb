# -*- encoding : utf-8 -*-
module Ebayr
  class File < Request

    def initialize(command, options = {})

      super
    end

    def self.uri
      URI::parse "https://storage#{sandbox ? '.sandbox' : ''}.ebay.com/FileTransferService"
    end

    def self.download(options = {})
      params = {}.merge!({
                             fileReferenceId: options[:file_reference_id],
                             taskReferenceId: options[:task_reference_id]
                         })

      self.new(:downloadFile, input: params, uri: uri, http_timeout: 6000000).send
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
          # 'X-EBAY-SOA-MESSAGE-PROTOCOL' => 'SOAP12',
          'X-EBAY-SOA-OPERATION-NAME' => @command.to_s,
          'X-EBAY-SOA-SECURITY-TOKEN' => self.auth_token,
          'X-EBAY-SOA-REQUEST-DATA-FORMAT' => 'XML',
          'X-EBAY-SOA-RESPONSE-DATA-FORMAT' => 'XML',
          'X-EBAY-SOA-SERVICE-VERSION' => '1.0.0',
          'X-EBAY-SOA-SERVICE-NAME' => 'FileTransferService',
          'Content-Type' => 'text/xml'
      }
    end
  end
end