require 'json'

class BacthRequests
  def initialize(app)
    @app = app
  end

  def call(env)
    @status, @headers, @response = @app.call(env)
    @request = Rack::Request.new(env.dup)
    AuthenticationService.validate user.id if user
    [@status, @headers, @response]
  rescue AuthenticationService::AttemptLimitsExceeded
    [422, {}, ['Acess denied']]
  end

  def params
    @params ||= JSON.parse @request.body.read
  end

  def user
    @user = User.find_by(user_name: params['user_name'])
  end
end
