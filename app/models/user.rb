class User < ActiveRecord::Base
    has_many :entries

    has_secure_password

    #validations
    validates_presence_of :email
    validates :email, uniqueness: {case_sensitive: true}
    validates_presence_of :password, :on => :create
    validates_presence_of :password_confirmation
    validates_confirmation_of :password
    validates_presence_of :phone_number
    validates :phone_number, uniqueness: {case_sensitive: true}

    #create the proper remember token for the user
    before_create :create_remember_token

    def User.new_remember_token
        SecureRandom.urlsafe_base64
    end

    def User.encrypt(token)
        Digest::SHA1.hexdigest(token.to_s)
    end

    private

    def create_remember_token
        self.remember_token = User.encrypt(User.new_remember_token)
    end

end
