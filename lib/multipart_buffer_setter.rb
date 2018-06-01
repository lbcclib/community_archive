# Sets the Rack multipart buffer to 2 gigs
class MultipartBufferSetter
  def initialize app
    @app = app
  end

  def call env
    env.merge!(Rack::RACK_MULTIPART_BUFFER_SIZE => (1024*1024*2))
    @app.call env
  end
end

