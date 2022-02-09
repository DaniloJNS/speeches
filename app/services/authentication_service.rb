class AuthenticationService
  class AttemptLimitsExceeded < StandardError; end

  ATTEMPS_LIMIT = 5

  def initialize(user_id)
    @chave = "attempts:usuario:#{user_id}"
    @redis = Redis.new
  end

  def self.call(...)
    new(...).call
  end

  def self.validate(...)
    new(...).validate
  end

  def self.restart(...)
    new(...).restart
  end

  def call
    @redis.incr(@chave)
  end

  def restart
    @redis.decrby(@chave, attemps) if attemps.positive?
  end

  def validate
    raise AttemptLimitsExceeded if attemps >= ATTEMPS_LIMIT
  end

  private

  def attemps
    @redis.get(@chave).to_i
  end
end
