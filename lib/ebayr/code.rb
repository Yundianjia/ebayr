# -*- encoding : utf-8 -*-
module Ebayr #:nodoc:

  # Ebay enum constants
  # API Reference: http://developer.ebay.com/DevZone/XML/docs/Reference/ebay/enumindex.html

  # 站点
  module SiteCodeType
    AU = 15
    AT = 16
    CA = 2
    FR = 71
    DE = 77
    HK = 201
    IN = 203
    IE = 205
    IT = 101
    MY = 207
    NL = 146
    PH = 211
    PL = 212
    RU = 215
    SG = 216
    ES = 186
    CH = 193
    UK = 3
    US = 0
    CAFR = 210
    BENL = 123
    BEFR = 23
  end

  module CurrencyCodeType
    %w(AUD CAD CHY CNY EUR GBP HKD INR MYR PHP PLN SEK SGD TWD USD).each do |item|
      self.const_set item, item
    end
  end

  module ListingDurationCodeType
    %w(1 3 5 7 10 14 21 30 60 90 120).each do |item|
      item = "Days_#{item}"
      self.const_set item, item
    end
    GTC = 'GTC' # Good Til Cancel
  end

  module CountryCodeType
    countries = %w(AA AD AE AF AG AI AL AM AN AO AQ AR AS AT AU AW AZ BA BB BD BE BF BG BH BI BJ BM BN BO BR BS BT BV BW BY BZ CA CC CD CF CG CH CI CK CL CM CN CO CR CU CV CX CY CZ DE DJ DK DM DO DZ EC EE EG EH ER ES ET FI FJ FK FM FO FR GA GB GD GE GF GG GH GI GL GM GN GP GQ GR GS GT GU GW GY HK HM HN HR HT HU ID IE IL IN IO IQ IR IS IT JE JM JO JP KE KG KH KI KM KN KP KR KW KY KZ LA LB LC LI LK LR LS LT LU LV LY MA MC MD ME MG MH MK ML MM MN MO MP MQ MR MS MT MU MV MW MX MY MZ NA NC NE NF NG NI NL NO NP NR NU NZ OM PA PE PF PG PH PK PL PM PN PR PS PT PW PY QA QM QN QO RE RO RS RU RW SA SB SC SD SE SG SH SI SJ SK SL SM SN SO SR ST SV SY SZ TC TD TF TG TH TJ TK TM TN TO TP TR TT TV TW TZ UA UG UM US UY UZ VA VC VE VG VI VN VU WF WS YE YT YU ZA ZM ZW ZZ)

    countries.each do |item|
      self.const_set item, item
    end
  end

  # http://developer.ebay.com/devzone/XML/docs/Reference/ebay/types/FeatureIDCodeType.html
  module FeatureIDCodeType
    code_types = %w(AdditionalCompatibilityEnabled AdFormatEnabled BestOfferAutoAcceptEnabled BestOfferAutoDeclineEnabled BestOfferCounterEnabled BestOfferEnabled BrandMPNIdentifierEnabled BuyerGuaranteeEnabled ClassifiedAdAutoAcceptEnabled ClassifiedAdAutoDeclineEnabled ClassifiedAdBestOfferEnabled ClassifiedAdCompanyNameEnabled ClassifiedAdContactByAddressEnabled ClassifiedAdContactByEmailEnabled ClassifiedAdContactByPhoneEnabled ClassifiedAdCounterOfferEnabled ClassifiedAdPaymentMethodEnabled ClassifiedAdShippingMethodEnabled CompatibilityEnabled CompatibleVehicleType ConditionEnabled ConditionValues CrossBorderTradeEnabled CustomCode DigitalGoodDeliveryEnabled EANEnabled eBayMotorsProAdFormatEnabled eBayMotorsProAutoAcceptEnabled eBayMotorsProAutoDeclineEnabled eBayMotorsProBestOfferEnabled eBayMotorsProCompanyNameEnabled eBayMotorsProContactByAddressEnabled eBayMotorsProContactByEmailEnabled eBayMotorsProContactByPhoneEnabled eBayMotorsProCounterOfferEnabled eBayMotorsProPaymentMethodCheckOutEnabled eBayMotorsProSellerContactDetailsEnabled eBayMotorsProShippingMethodEnabled FreeGalleryPlusEnabled FreePicturePackEnabled GalleryFeaturedDurations GlobalShippingEnabled Group1MaxFlatShippingCost Group2MaxFlatShippingCost Group3MaxFlatShippingCost HandlingTimeEnabled HomePageFeaturedEnabled INEscrowWorkflowTimeline IntangibleEnabled ISBNEnabled ItemSpecificsEnabled ListingDurations LocalListingDistances LocalMarketAdFormatEnabled LocalMarketAutoAcceptEnabled LocalMarketAutoDeclineEnabled LocalMarketBestOfferEnabled LocalMarketCompanyNameEnabled LocalMarketContactByAddressEnabled LocalMarketContactByEmailEnabled LocalMarketContactByPhoneEnabled LocalMarketCounterOfferEnabled LocalMarketNonSubscription LocalMarketPaymentMethodCheckOutEnabled LocalMarketPremiumSubscription LocalMarketRegularSubscription LocalMarketSellerContactDetailsEnabled LocalMarketShippingMethodEnabled LocalMarketSpecialitySubscription MaxCompatibleApplications MaxFlatShippingCost MaxFlatShippingCostCBTExempt MaxGranularFitmentCount MinCompatibleApplications MinimumReservePrice NonSubscription PaisaPayFullEscrowEnabled PaymentMethods PaymentProfileCategoryGroup PayPalBuyerProtectionEnabled PayPalRequired PickupDropOffEnabled PremiumSubscription ProductCreationEnabled ProPack ProPackPlus RegularSubscription ReturnPolicyEnabled ReturnPolicyProfileCategoryGroup RevisePriceAllowed ReviseQuantityAllowed SafePaymentRequired SellerContactDetailsEnabled ShippingProfileCategoryGroup ShippingTermsRequired SkypeMeNonTransactionalEnabled SkypeMeTransactionalEnabled SpecialitySubscription StoreOwnerExtendedListingDurations StoreOwnerExtendedListingDurationsEnabled UPCEnabled UserConsentRequired ValueCategory ValuePack VariationsEnabled)

    code_types.each do |item|
      self.const_set item.sub(/^eBay/, 'Ebay'), item
    end
  end

  # http://developer.ebay.com/devzone/XML/docs/Reference/ebay/types/DetailLevelCodeType.html
  module DetailLevelCodeType
    code_types = %w(ItemReturnAttributes ItemReturnCategories ItemReturnDescription ReturnAll ReturnHeaders ReturnMessages ReturnSummary)

    code_types.each do |item|
      self.const_set item, item
    end

  end

  # http://developer.ebay.com/devzone/XML/docs/Reference/ebay/types/WarningLevelCodeType.html
  module WarningLevelCodeType
    High = 'High'
    Low = 'Low'
  end

  # http://developer.ebay.com/DevZone/guides/ebayfeatures/Development/Desc-ItemCondition.html
  module ConditionIDCodeType
    NEW =  1000

    NEW_OTHER = 1500

    NEW_WITH_DEFECTS = 1750

    MANUFACTURER_REFURBISHED = 2000

    SELLER_REFURBISHED = 2500

    LIKE_NEW = 2750

    USED = 3000

    VERY_GOOD = 4000

    GOOD = 5000

    ACCEPTABLE = 6000

    PART_DAMAGE = 7000
  end

  module ListingStatusCodeType
    Ended = 'Ended'.freeze

    Active = 'Active'.freeze

    Completed = 'Completed'.freeze

    CoustomCode = 'CustomCode'.freeze
  end

  # http://developer.ebay.com/DevZone/XML/docs/Reference/eBay/types/SelectionModeCodeType.html
  module SelectionModeCodeType
    code_types = %w(Automatic CustomCode FreeText Manual Prefilled SelectionOnly)

    code_types.each do |item|
      self.const_set item, item
    end
  end
end