module Authenticatable
  def current_user
    return @current_user if @current_user

    header = request.headers["Authorization"]

    return if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_user = User.find(decoded[:user_id]) rescue ActiveRecord::RecordNotFound
  end

  protected

    def check_login
      head :forbidden unless self.current_user
    end
end