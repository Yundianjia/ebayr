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
      http_timeout = options[:http_timeout] || 6000000

      params = {}.merge!({
                             fileReferenceId: options[:fileReferenceId],
                             taskReferenceId: options[:taskReferenceId],
                         })

      self.new(:downloadFile, input: params, uri: uri, http_timeout: http_timeout).send
    end

    def self.upload(options = {})
      self.new(:uploadFile, options).send
    end

    def body
      <<-XML
        <?xml version="1.0" encoding="utf-8"?>
        <#{@command}Request xmlns="http://www.ebay.com/marketplace/services">
      #{self.input_xml}
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
      if debug == true
        logger.info "Request URL: #{@uri.to_s}"
        logger.info "Request Timeout: #{@http_timeout}"
        logger.info "Request headers: #{self.headers}"
        logger.info "Request body: #{self.body}"
      end

      response = RestClient::Request.execute(method: :post, url: @uri.to_s, payload: self.body, headers: self.headers, timeout: @http_timeout, open_timeout: @http_timeout)

      if debug == true
        logger.info "Response: #{response}"
      end

      generate_file response, 'ebay_response.text'
      generate_file response.body, 'ebay_content.text'
    rescue => e
      logger.info "下载文件失败: #{e}"
    end

    # 根据字符创生成文件
    def generate_file(content = '', file = '')
      File.open 'tmp/' + file, 'w+' do |f|
        f.puts content
      end
    end
  end
end