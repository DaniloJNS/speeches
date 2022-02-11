class AuthenticationService
  class AttemptLimitsExceeded < StandardError; end

  ATTEMPS_LIMIT = 5
  TIME_EXPIRE = 30 # in seconds
  TIME_EXPIRE_LOCKED = 300 # in seconds

  def initialize(user_id)
    @chave = "attempts:#{user_id}:usuario"
    @redis = $redis
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
    if @redis.incr(@chave).eql? ATTEMPS_LIMIT
      @redis.set(@chave, 'locked')
      @redis.expire(@chave, TIME_EXPIRE_LOCKED)
    end

    @redis.expire(@chave, TIME_EXPIRE)
  end

  def restart
    @redis.decrby(@chave, attemps) if @redis.get(@chave)
  end

  def validate
    raise AttemptLimitsExceeded if locked?
  end

  private

  def locked?
    @redis.get(@chave).eql? 'locked'
  end

  def attemps
    @attemps ||= @redis.get(@chave).to_i
  end
end
