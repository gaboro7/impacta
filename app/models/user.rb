# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  nombre             :string(255)      not null
#  email              :string(255)      not null
#  encrypted_password :string(255)      not null
#  salt               :string(255)
#  admin              :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :nombre, :email, :password, :password_confirmation, :admin

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :nombre,  :presence => {:message => "Debe ingresar Nombre de Usuario."},
                    :length   => { :maximum => 50 },
                    :uniqueness => { :case_sensitive => false,:message => "Ya existe un usuario con el Nombre." }
  validates :email, :presence => {:message => "Debe ingresar un e-mail."},
                     :format   => { :with => email_regex , :message => "El e-mail ingresado no es valido."},
                     :uniqueness => { :case_sensitive => true,:message => "Ya existe un usuario con el mismo e-mail." }

  # Automatically create the virtual attribute "password_confirmation"
  validates :password, :presence => {:message => "Debe ingresar un password."},
                    :confirmation => {:message => "Debe confirmar el password."},
                    :length => { :within => 8..40, :message => "Debe ingresar una password mayor a 8 y menor que 40 caracteres." }

  before_save :encrypt_password
  before_destroy :un_administrador

  # Return 'true' if the user's password matches the submitted password
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(nombre, submitted_password)
    user = find_by_nombre(nombre)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end


  private

  def un_administrador
    errors.add(:nombre,"No puede eliminiar el ultimo administrador") if self.admin? and User.count(:conditions => "admin = TRUE") == 1
  end

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end
