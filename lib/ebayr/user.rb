# -*- encoding : utf-8 -*-
module Ebayr
  module User
    # Shorthand for call(call, arguments.merge(:auth_token => this.ebay_token))
    # Allows objects which mix in this module to use their own token.
    def ebay_call(call, arguments = {})
      if arguments[:ebay_token].blank?
        raise "#{self} has no eBay token"
      end

      Ebayr.call(call, arguments.merge(auth_token: arguments[:ebay_token]))
    end

    # Gets the user's data
    def get_ebay_data(access_token)
      ebay_call(:GetUser, auth_token: access_token)
    end
  end
end
