# -*- encoding : utf-8 -*-
require 'rest-client'

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
          'X-EBAY-SOA-SERVICE-NAME' => 'FileTransferService',
          'Content-Type' => 'text/xml'
      }
    end

    def send
      response = RestClient::Request.execute(:method => :post, :url => url, :payload => body, :headers => headers, :timeout => @http_timeout, :open_timeout => @http_timeout)

      generate_file response, 'ebay_response.text'
      generate_file response.body, 'ebay_content.text'
    rescue => e

    end

    # 根据字符创生成文件
    def generate_file(content = '', file = '')
      File.open 'tmp/' + file, 'w+' do |f|
        f.puts content
      end
    end
  end
end