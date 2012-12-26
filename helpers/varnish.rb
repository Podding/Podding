module Net
  class HTTP::VarnishBan < HTTPRequest
        METHOD='BAN'
        REQUEST_HAS_BODY = false
        RESPONSE_HAS_BODY = true
  end
end
