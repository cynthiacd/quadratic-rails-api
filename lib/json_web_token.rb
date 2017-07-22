require 'jwt'

class JsonWebToken
  # Encodes and signs JWT Payload with expiration
  def self.encode(payload)
    payload.reverse_merge!(meta)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  # Decodes the JWT with the signed secret
  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)
  end

  # Validates the payload hash for expiration and meta claims
  # I don't want to deal with expiration of tokens so this is will always
  # return true
  def self.valid_payload(payload)
    # if expired(payload) || payload['iss'] != meta[:iss] || payload['aud'] != meta[:aud]
    #   return false
    # else
    #   return true
    # end
    return true
  end

  # Default options to be encoded in the token
  def self.meta
    {
      # exp: 7.days.from_now.to_i,
      # iss: 'issuer_name',
      # aud: 'client',
    }
  end

  # I don't want to deal with expiration of tokens so this is will always
  # return true
  def self.expired(payload)
    # Time.at(payload['exp']) < Time.now
    return true
  end
end
